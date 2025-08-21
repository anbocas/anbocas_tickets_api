import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';
import 'package:example/shared/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';

class TicketFormScreen extends StatefulWidget {
  const TicketFormScreen({
    super.key,
    required this.event,
    this.ticket,
  });

  final AnbocasEventModel event;
  final AnbocasTicketModel? ticket;

  static Future<AnbocasTicketModel?> navigate(
    BuildContext context,
    AnbocasEventModel event, [
    final AnbocasTicketModel? ticket,
  ]) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TicketFormScreen(
          event: event,
          ticket: ticket,
        ),
      ),
    );
  }

  @override
  State<TicketFormScreen> createState() => _TicketFormScreenState();
}

class _TicketFormScreenState extends State<TicketFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.ticket == null ? 'Create Ticket' : 'Update Ticket'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Gap(20),
          MyTextField(
            controller: name,
            hintText: 'Ticket Name',
          ),
          const Gap(20),
          DropdownButtonFormField(
            items: AnbocasTicketStatus.values
                .map((e) => DropdownMenuItem(value: e, child: Text(e.value)))
                .toList(),
            value: status,
            hint: const Text('Status'),
            onChanged: (value) {
              setState(() {
                status = value;
              });
            },
          ),
          const Gap(20),
          Row(
            spacing: 8,
            children: [
              IconButton(
                onPressed: () {
                  showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2050),
                  ).then(
                    (value) {
                      if (value != null) {
                        setState(() {
                          availableFrom = value;
                        });
                      }
                    },
                  );
                },
                icon: const Icon(Icons.calendar_month),
              ),
              Text(availableFrom != null
                  ? DateFormat('dd/MM/yyyy hh:mm a').format(availableFrom!)
                  : 'Select Available From Date & Time')
            ],
          ),
          Row(
            spacing: 8,
            children: [
              IconButton(
                onPressed: () {
                  showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2050),
                  ).then(
                    (value) {
                      if (value != null) {
                        setState(() {
                          availableTo = value;
                        });
                      }
                    },
                  );
                },
                icon: const Icon(Icons.calendar_month),
              ),
              Text(availableTo != null
                  ? DateFormat('dd/MM/yyyy hh:mm a').format(availableTo!)
                  : 'Select Available To Date & Time')
            ],
          ),
          const Gap(20),
          MyTextField(
            controller: description,
            hintText: 'Description',
          ),
          const Gap(20),
          MyTextField(
            controller: capacity,
            hintText: 'Capacity',
          ),
          const Gap(20),
          MyTextField(
            controller: price,
            hintText: 'Price',
          ),
          const Gap(20),
        ],
      ),
      bottomNavigationBar: MaterialButton(
        height: 50,
        minWidth: double.infinity,
        textColor: Colors.white,
        onPressed: _createTicket,
        color: Colors.blue,
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text('Submit'),
      ),
    );
  }

  final _anbocasTickets = AnbocasTickets();
  bool isLoading = false;

  final name = TextEditingController();
  final description = TextEditingController();
  final capacity = TextEditingController();
  AnbocasTicketStatus? status;
  final price = TextEditingController();
  DateTime? availableFrom;
  DateTime? availableTo;

  @override
  void initState() {
    super.initState();
    final ticket = widget.ticket;
    if (ticket == null) {
      name.text = 'Ticket 1';
      description.text = 'Ticket description';
      capacity.text = '10';
      price.text = '498';
    } else {
      name.text = ticket.name ?? '';
      description.text = ticket.description ?? '';
      capacity.text = ticket.capacity?.toString() ?? '';
      price.text = ticket.capacity?.toString() ?? '';
    }
  }

  @override
  void dispose() {
    name.dispose();
    description.dispose();
    capacity.dispose();
    price.dispose();
    super.dispose();
  }

  void _createTicket() async {
    setState(() {
      isLoading = true;
    });
    try {
      late final AnbocasTicketModel ticket;

      if (widget.ticket == null) {
        ticket = await _anbocasTickets.createTicket(
          eventId: widget.event.id ?? '',
          name: name.text,
          status: status!,
          description: description.text,
          capacity: int.parse(capacity.text),
          price: double.parse(price.text),
          availableFrom: availableFrom!,
          availableTo: availableTo!,
        );
      } else {
        ticket = await _anbocasTickets.updateTicket(
          ticketId: widget.ticket?.id ?? '',
          eventId: widget.event.id ?? '',
          name: name.text,
          status: status!,
          description: description.text,
          capacity: int.parse(capacity.text),
          price: double.parse(price.text),
          availableFrom: availableFrom,
          availableTo: availableTo,
        );
      }

      if (mounted) {
        toastification.show(
          title: const Text('Ticket created successfullly'),
          style: ToastificationStyle.minimal,
          type: ToastificationType.success,
          autoCloseDuration: const Duration(seconds: 5),
        );
        Navigator.pop(context, ticket);
      }
    } catch (e) {
      toastification.show(
        title: const Text('Opps! something went wrong, Try Again'),
        style: ToastificationStyle.minimal,
        type: ToastificationType.error,
        autoCloseDuration: const Duration(seconds: 5),
      );
    }

    setState(() {
      isLoading = false;
    });
  }
}
