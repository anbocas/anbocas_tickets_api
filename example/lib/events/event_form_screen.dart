import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';
import 'package:example/shared/category_dropdown_form_field.dart';
import 'package:example/shared/company_dropdown_form_field.dart';
import 'package:example/shared/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

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
          CategoryDropdownFormField(
            value: category,
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  category = value;
                });
              }
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
                          startDateTime = value;
                        });
                      }
                    },
                  );
                },
                icon: const Icon(Icons.calendar_month),
              ),
              Text(startDateTime != null
                  ? DateFormat('dd/MM/yyyy hh:mm a').format(startDateTime!)
                  : 'Select Start Date & Time')
            ],
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
                          endDateTime = value;
                        });
                      }
                    },
                  );
                },
                icon: const Icon(Icons.calendar_month),
              ),
              Text(endDateTime != null
                  ? DateFormat('dd/MM/yyyy hh:mm a').format(endDateTime!)
                  : 'Select End Date & Time')
            ],
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
              const Text('Is Free'),
              Checkbox(
                value: isFree,
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      isFree = value;
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
        onPressed: _createEvent,
        color: Colors.blue,
        child: const Text('Submit'),
      ),
    );
  }

  final _anbocasEvents = AnbocasEvents();
  bool isLoading = false;

  AnbocasCategoryModel? category;
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
  bool isFree = false;
  final referenceId = TextEditingController();
  final bannerPath = TextEditingController();

  @override
  void initState() {
    super.initState();
    name.text = 'Event 1';
    description.text = 'This is the description for my event.';
    website.text = 'https://forwardcode.com';
    venue.text = 'Here comes my venu.';
    location.text = 'Remote';
    latitude.text = '0';
    longitude.text = '0';
    startDateTime = DateTime.now();
    endDateTime = startDateTime!.add(const Duration(days: 10));
    locationType = AnbocasEventLocationType.virtual;
    meetingLink.text = 'https://forwardcode.com';
    isPublic = true;
    groupTicketingAllowed = true;
    createOrganiserForVenue = true;
    isBookingOpen = true;
  }

  void _createEvent() async {
    setState(() {
      isLoading = true;
    });
    try {
      _anbocasEvents.createEvent(
      categoryId: category?.id ?? '',
      companyId: company?.id ?? '',
      name: name.text.trim(),
      description: description.text.trim(),
      website: website.text.trim(),
      venue: venue.text.trim(),
      location: location.text.trim(),
      latitude: latitude.text.trim(),
      longitude: longitude.text.trim(),
      startDateTime: startDateTime!,
      endDateTime: endDateTime!,
      locationType: locationType!,
      meetingLink: meetingLink.text.trim(),
      isPublic: isPublic,
      isFree: isFree,
      groupTicketingAllowed: groupTicketingAllowed,
      createOrganiserForVenue: createOrganiserForVenue,
      isBookingOpen: isBookingOpen,
      referenceId: referenceId.text.trim(),
      bannerPath: bannerPath.text.trim(),
    );
    } catch(e) {
      
    }

    setState(() {
      isLoading = false;
    });
  }
}
