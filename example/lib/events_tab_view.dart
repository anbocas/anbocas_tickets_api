import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';
import 'package:example/main.dart';
import 'package:flutter/material.dart';

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
          child: RefreshIndicator(
            onRefresh: () async => getEvents(true),
            child: ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                return ListTile(
                  onTap: () {},
                  title: Text(event.name ?? 'N/A'),
                );
              },
            ),
          ),
        ),
        MaterialButton(
          height: 50,
          minWidth: double.infinity,
          textColor: Colors.white,
          onPressed: () {
            if (_eventsResponse != null &&
                _eventsResponse!.currentPage >= _eventsResponse!.lastPage) {
              ScaffoldMessenger.maybeOf(context)?.showSnackBar(
                  const SnackBar(content: Text('Nothing to load.')));
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
        page: _eventsResponse!.currentPage + 1,
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
