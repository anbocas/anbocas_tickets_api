import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';
import 'package:example/tickets/ticket_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({super.key, required this.event});

  final AnbocasEventModel event;

  static void navigate(BuildContext context, AnbocasEventModel event) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TicketsScreen(event: event),
      ),
    );
  }

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  @override
  Widget build(BuildContext context) {
    final tickets = _ticketsResponse?.data ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.event.name ?? 'N/A'} Tickets'),
      ),
      floatingActionButton: !_isLoading
          ? FloatingActionButton(
              onPressed: () {
                TicketFormScreen.navigate(
                  context,
                  widget.event,
                ).then(
                  (value) {
                    if (value != null) {
                      setState(() {
                        _ticketsResponse = _ticketsResponse?.copyWith(
                          data: [value, ...(_ticketsResponse?.data ?? [])],
                        );
                      });
                    }
                  },
                );
              },
              child: const Icon(Icons.create),
            )
          : null,
      bottomNavigationBar: !_isLoading
          ? MaterialButton(
              height: 50,
              minWidth: double.infinity,
              textColor: Colors.white,
              onPressed: () {
                if (_ticketsResponse?.currentPage != null &&
                    _ticketsResponse?.lastPage != null &&
                    _ticketsResponse!.currentPage! >=
                        _ticketsResponse!.lastPage!) {
                  toastification.show(
                    title: const Text('Nothing to load.'),
                    style: ToastificationStyle.minimal,
                    type: ToastificationType.info,
                    autoCloseDuration: const Duration(seconds: 5),
                  );
                } else {
                  getTickets();
                }
              },
              color: Colors.blue,
              child: const Text('Load more'),
            )
          : null,
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () async => getTickets(true),
              child: ListView.builder(
                itemCount: tickets.length,
                itemBuilder: (context, index) {
                  final ticket = tickets[index];
                  return ListTile(
                    onTap: () {
                      // TicketDetailsScreen.navigate(context, ticket);
                    },
                    title: Text(ticket.name ?? 'N/A'),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) => _itemBuilder(context, ticket),
                    ),
                  );
                },
              ),
            ),
    );
  }

  final _anbocasTickets = AnbocasTickets();
  bool _isLoading = false;
  AnbocasPaginatedResponse<List<AnbocasTicketModel>>? _ticketsResponse;

  @override
  void initState() {
    super.initState();
    getTickets();
  }

  void getTickets([bool refresh = false]) async {
    setState(() {
      _isLoading = true;
    });
    if (_ticketsResponse == null || refresh) {
      _ticketsResponse = await _anbocasTickets.getTickets(
        eventId: widget.event.id ?? '',
        paginate: true,
      );
    } else {
      final prevTicketsResponse = _ticketsResponse;
      _ticketsResponse = await _anbocasTickets.getTickets(
        eventId: widget.event.id ?? '',
        paginate: true,
        page: (_ticketsResponse!.currentPage ?? 0) + 1,
      );

      _ticketsResponse = _ticketsResponse!.copyWith(
        data: [...prevTicketsResponse!.data, ..._ticketsResponse!.data],
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  List<PopupMenuEntry> _itemBuilder(
    BuildContext context,
    AnbocasTicketModel ticket,
  ) {
    return [
      PopupMenuItem(
        onTap: () {
          // TicketFormScreen.navigate(context, ticket);
        },
        child: const Text('Edit'),
      ),
      PopupMenuItem(
        onTap: () async {
          // try {
          //   await _anbocasTickets.deleteTicket(
          //     ticketId: ticket.id ?? '',
          //   );

          //   toastification.show(
          //     title: const Text('Ticket deleted successfully.'),
          //     style: ToastificationStyle.minimal,
          //     type: ToastificationType.success,
          //     autoCloseDuration: const Duration(seconds: 5),
          //   );

          //   setState(() {
          //     _ticketsResponse = _ticketsResponse?.copyWith(
          //       data: (_ticketsResponse?.data
          //               .where(
          //                 (element) => element.id != ticket.id,
          //               )
          //               .toList() ??
          //           []),
          //     );
          //   });
          // } catch (e) {
          //   toastification.show(
          //     title: const Text('Opps! something went wrong, Try again.'),
          //     style: ToastificationStyle.minimal,
          //     type: ToastificationType.error,
          //     autoCloseDuration: const Duration(seconds: 5),
          //   );
          // }
        },
        child: const Text('Delete'),
      ),
    ];
  }
}
