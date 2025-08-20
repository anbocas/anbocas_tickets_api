import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';
import 'package:example/shared/category_dropdown_form_field.dart';
import 'package:example/shared/company_dropdown_form_field.dart';
import 'package:example/shared/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:toastification/toastification.dart';

class EventFormScreen extends StatefulWidget {
  const EventFormScreen({super.key, this.event});

  final AnbocasEventModel? event;

  static Future<AnbocasEventModel?> navigate(BuildContext context,
      [AnbocasEventModel? event]) {
    return Navigator.push(
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
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : const Text('Submit'),
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
    final event = widget.event;
    if (event == null) {
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
    } else {
      name.text = event.name ?? '';
      description.text = event.description ?? '';
      website.text = event.website ?? '';
      venue.text = event.venue ?? '';
      location.text = event.location ?? '';
      latitude.text = event.latitude?.toString() ?? '0';
      longitude.text = event.longitude?.toString() ?? '0';
      startDateTime = DateTime.tryParse(event.startDate ?? '');
      endDateTime = DateTime.tryParse(event.endDate ?? '');
      locationType = event.locationType;
      meetingLink.text = event.meetingLink ?? '';
      isPublic = event.isPublic == 1;
      groupTicketingAllowed = event.groupTicketingAllowed == 1;
      isBookingOpen = event.isBookingOpen == 1;
    }
  }

  @override
  void dispose() {
    name.dispose();
    description.dispose();
    website.dispose();
    venue.dispose();
    location.dispose();
    meetingLink.dispose();
    latitude.dispose();
    longitude.dispose();
    referenceId.dispose();
    bannerPath.dispose();
    super.dispose();
  }

  void _createEvent() async {
    setState(() {
      isLoading = true;
    });
    try {
      late final AnbocasEventModel event;

      if (widget.event == null) {
        event = await _anbocasEvents.createEvent(
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
      } else {
        event = await _anbocasEvents.updateEvent(
          eventId: widget.event?.id ?? '',
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
          isBookingOpen: isBookingOpen,
          bannerPath: bannerPath.text.trim(),
        );
      }

      if (mounted) {
        toastification.show(
          title: Text(
              'Event ${widget.event == null ? 'created' : 'updated'} successfullly'),
          style: ToastificationStyle.minimal,
          type: ToastificationType.success,
          autoCloseDuration: const Duration(seconds: 5),
        );
        Navigator.pop(context, event);
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
