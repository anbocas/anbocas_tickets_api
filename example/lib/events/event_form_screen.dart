import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';
import 'package:example/shared/company_dropdown_form_field.dart';
import 'package:example/shared/my_text_field.dart';
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
        children: [
          DropdownButtonFormField<String>(
            items: const [],
            value: categoryId,
            hint: const Text('Category'),
            onChanged: (value) {
              setState(() {
                categoryId = value;
              });
            },
          ),
          const Gap(20),
          CompanyDropdownFormField(
            value: company,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  company = value;
                });
              }
            },
          ),
          const Gap(20),
          MyTextField(
            controller: name,
            hintText: 'Event Name',
          ),
          const Gap(20),
          MyTextField(
            controller: description,
            hintText: 'Event description',
          ),
          const Gap(20),
          MyTextField(
            controller: website,
            hintText: 'Website',
          ),
          const Gap(20),
          MyTextField(
            controller: venue,
            hintText: 'Venue',
          ),
          const Gap(20),
          MyTextField(
            controller: location,
            hintText: 'Location',
          ),
          const Gap(20),
          MyTextField(
            controller: latitude,
            hintText: 'Latitude',
          ),
          const Gap(20),
          MyTextField(
            controller: longitude,
            hintText: 'Longitude',
          ),
          const Gap(20),
          DropdownButtonFormField(
            items: AnbocasEventLocationType.values
                .map((e) => DropdownMenuItem(value: e, child: Text(e.value)))
                .toList(),
            value: locationType,
            hint: const Text('Location Type'),
            onChanged: (value) {
              setState(() {
                locationType = value;
              });
            },
          ),
          const Gap(20),
          MyTextField(
            controller: meetingLink,
            hintText: 'Meeting Link',
          ),
          const Gap(20),
          Row(
            spacing: 8,
            children: [
              const Text('Is Public'),
              Checkbox(
                value: isPublic,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      isPublic = value;
                    });
                  }
                },
              )
            ],
          ),
          const Gap(20),
          Row(
            spacing: 8,
            children: [
              const Text('Group Ticketing Allowed'),
              Checkbox(
                value: groupTicketingAllowed,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      groupTicketingAllowed = value;
                    });
                  }
                },
              )
            ],
          ),
          const Gap(20),
          Row(
            spacing: 8,
            children: [
              const Text('Create Organiser For Venue'),
              Checkbox(
                value: createOrganiserForVenue,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      createOrganiserForVenue = value;
                    });
                  }
                },
              )
            ],
          ),
          const Gap(20),
          Row(
            spacing: 8,
            children: [
              const Text('Is Booking Open'),
              Checkbox(
                value: isBookingOpen,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      isBookingOpen = value;
                    });
                  }
                },
              )
            ],
          ),
          const Gap(20),
          MyTextField(
            controller: referenceId,
            hintText: 'Reference Id',
          ),
          const Gap(20),
          MyTextField(
            controller: bannerPath,
            hintText: 'Banner Path',
          ),
          const Gap(20),
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

  String? categoryId;
  AnbocasCompanyModel? company;
  final name = TextEditingController();
  final description = TextEditingController();
  final website = TextEditingController();
  final venue = TextEditingController();
  final location = TextEditingController();
  final latitude = TextEditingController();
  final longitude = TextEditingController();
  DateTime? startDateTime;
  DateTime? endDateTime;
  AnbocasEventLocationType? locationType;
  final meetingLink = TextEditingController();
  bool isPublic = false;
  bool groupTicketingAllowed = false;
  bool createOrganiserForVenue = false;
  bool isBookingOpen = false;
  final referenceId = TextEditingController();
  final bannerPath = TextEditingController();
}
