import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';
import 'package:example/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EventFormScreen extends StatefulWidget {
  const EventFormScreen({super.key, this.event});

  final AnbocasEventModel? event;

  static void navigate(BuildContext context, [AnbocasEventModel? event]) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventFormScreen(event: event),
      ),
    );
  }

  @override
  State<EventFormScreen> createState() => _EventFormScreenState();
}

class _EventFormScreenState extends State<EventFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event == null ? 'Create Event' : 'Update Event'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          MyTextField(
            hintText: 'Event Name',
          ),
          Gap(20),
          MyTextField(
            hintText: 'Event description',
          ),
          Gap(20),
        ],
      ),
      bottomNavigationBar: MaterialButton(
        height: 50,
        minWidth: double.infinity,
        textColor: Colors.white,
        onPressed: () {
          //_anbocasEvents.createEvent(
          // required String categoryId,
          // required String companyId,
          // required String name,
          // required String description,
          // String? website,
          // String? venue,
          // required String location,
          // required String latitude,
          // required String longitude,
          // required DateTime startDateTime,
          // required DateTime endDateTime,
          // required AnbocasEventLocationType locationType,
          // String? meetingLink,
          // bool isPublic = true,
          // bool isFree = false,
          // bool groupTicketingAllowed = true,
          // bool createOrganiserForVenue = false,
          // bool isBookingOpen = true,
          // String? referenceId,
          // String? bannerPath,
          //         );
        },
        color: Colors.blue,
        child: const Text('Submit'),
      ),
    );
  }

  final _anbocasEvents = AnbocasEvents();
}
