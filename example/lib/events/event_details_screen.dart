import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EventDetailsScreen extends StatefulWidget {
  const EventDetailsScreen({super.key, required this.event});

  final AnbocasEventModel event;

  static void navigate(BuildContext context, AnbocasEventModel event) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EventDetailsScreen(event: event),
        ));
  }

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event.name ?? 'N/A'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : event != null
              ? ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Text(event!.description ?? 'N/A'),
                    const Gap(10),
                    Text(
                        'Event Platform Fee: ${event!.absorbPlatformFee ?? 'N/A'}'),
                    const Gap(10),
                    Text('Company: ${event!.company?.name ?? 'N/A'}'),
                    const Gap(10),
                    Text('Start Date: ${event!.startDate ?? 'N/A'}'),
                    const Gap(10),
                    Text('End Date: ${event!.endDate ?? 'N/A'}'),
                    const Gap(10),
                    Text(
                        'Is Group: ${(event!.groupTicketingAllowed == 1) ? 'Yes' : 'No'}'),
                    const Gap(10),
                    Text('Is Free: ${(event!.isFree == 1) ? 'Yes' : 'No'}'),
                    const Gap(10),
                    Text(
                        'Is Booking Open: ${(event!.isBookingOpen == 1) ? 'Yes' : 'No'}'),
                    const Gap(10),
                  ],
                )
              : null,
    );
  }

  bool isLoading = false;
  AnbocasEventModel? event;
  final anbocasEvents = AnbocasEvents();

  @override
  void initState() {
    super.initState();
    getEvent();
  }

  void getEvent() async {
    setState(() {
      isLoading = true;
    });
    event = await anbocasEvents.getEvent(widget.event.id ?? '');
    setState(() {
      isLoading = false;
    });
  }
}
