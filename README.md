# Anbocas Tickets API

Anbocas Tickets API is a Dart plugin designed to simplify API requests for managing company data, events, and tickets within your application. The plugin handles API calls with a simple, centralized configuration, making it easy to integrate and manage.

# Features

1. Centralized configuration for API requests.
2. Pre-built classes for company, event, and ticket APIs.
3. Supports custom headers, query parameters, and bearer token authentication.
4. Configurable logging for debugging purposes.

# Getting Started

### Prerequisites

** Before using the plugin, you'll need to obtain an API key. To get an API key**

[Contact Use]: https://github.com/anbocas/anbocas_tickets_api

Installing

Add `anbocas_tickets_api` to your `pubspec.yaml` file:

```dart
dependencies:
  anbocas_tickets_api: ^0.0.1

```

Then run,

dependencies:
flutter pub get

# Usage

### Initial Setup

Before making any API calls, you need to configure the plugin with your API key and any other required settings. This should be done at the start of your application:

```dart
import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';

void main() async {
  AnbocasRequestPlugin.instance
      ?.config(token: dotenv.env['API_KEY'], enableLog: true);

  runApp(MyApp());
}

```

# Making API Requests

Once configured, you can start making API requests. Here are some examples:

### Fetching Company List

```dart
import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';

void fetchCompanies() async {
  var companyList = await AnbocasRequestPlugin.company.get();
  print(companyList);
}
```

### Fetching Event Data

```dart
import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';

void fetchEvents() async {
  var events = await AnbocasRequestPlugin.event.get();
  print(events);
}
```

### Adding a New ticket

```dart
import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';
 Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final api = AnbocasRequestPlugin.ticket;
        await api.createTicket(
          eventId: HERE EVENT ID,
          name: HERE Ticket Name,
          description: DESCRIPTION,
          capacity: TICKET CAPACITY,
          price: PER TICKET PRICE,
          availableFrom:  TICKET DATE,
          availableTo: TICKET DATE,
          status: TICKET STATUS,
        );

    }
  }
```

# API Overview

1. Company API: Access company-related data.
2. Event API: Manage event-related data.
3. Tickets API: Handle ticket-related operations.

# License

This project is licensed under the BSD-3 License - see the LICENSE file for details.

# Support

For any issues or to request an API key, please contact [support@anbocas.com] https://github.com/anbocas/anbocas_tickets_api
