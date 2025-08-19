import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';
import 'package:example/events/event_form_screen.dart';
import 'package:example/main.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class EventsTabView extends StatefulWidget {
  const EventsTabView({super.key});

  @override
  State<EventsTabView> createState() => _EventsTabViewState();
}

class _EventsTabViewState extends State<EventsTabView> {
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final events = _eventsResponse?.data ?? [];

    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              Positioned.fill(
                child: RefreshIndicator(
                  onRefresh: () async => getEvents(true),
                  child: ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      final event = events[index];
                      return ListTile(
                        onTap: () {},
                        title: Text(event.name ?? 'N/A'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                EventFormScreen.navigate(context, event);
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                _anbocasEvents.deleteEvent(
                                  eventId: event.id ?? '',
                                  eventName: event.name ?? '',
                                );
                              },
                              icon: const Icon(Icons.delete),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                right: 16,
                bottom: 20,
                child: FloatingActionButton(
                  onPressed: () {
                    EventFormScreen.navigate(context);
                  },
                  child: const Icon(Icons.create),
                ),
              )
            ],
          ),
        ),
        MaterialButton(
          height: 50,
          minWidth: double.infinity,
          textColor: Colors.white,
          onPressed: () {
            if (_eventsResponse?.currentPage != null &&
                _eventsResponse?.lastPage != null &&
                _eventsResponse!.currentPage! >= _eventsResponse!.lastPage!) {
              toastification.show(
                title: const Text('Nothing to load.'),
                style: ToastificationStyle.minimal,
                type: ToastificationType.info,
                autoCloseDuration: const Duration(seconds: 5),
              );
            } else {
              getEvents();
            }
          },
          color: Colors.blue,
          child: const Text('Load more'),
        )
      ],
    );
  }

  final _anbocasEvents = AnbocasEvents();
  bool _isLoading = false;
  AnbocasPaginatedResponse<List<AnbocasEventModel>>? _eventsResponse;

  @override
  void initState() {
    super.initState();
    getEvents();
  }

  void getEvents([bool refresh = false]) async {
    setState(() {
      _isLoading = true;
    });
    if (_eventsResponse == null || refresh) {
      _eventsResponse = await _anbocasEvents.getEvents(
        companyId: kCompanyId,
        pageLength: 1,
      );
    } else {
      final prevEventsResponse = _eventsResponse;
      _eventsResponse = await _anbocasEvents.getEvents(
        companyId: kCompanyId,
        page: (_eventsResponse!.currentPage ?? 0) + 1,
        pageLength: 1,
      );

      _eventsResponse = _eventsResponse!.copyWith(
        data: [...prevEventsResponse!.data, ..._eventsResponse!.data],
      );
    }
    setState(() {
      _isLoading = false;
    });
  }
}
