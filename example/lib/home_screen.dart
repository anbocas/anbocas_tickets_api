import 'package:example/companies/companies_tab_view.dart';
import 'package:example/events/events_tab_view.dart';
import 'package:example/orders/orders_tab_view.dart';
import 'package:example/tickets/tickets_tab_view.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: AnbocasFeatures.values.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Anbocas Tickets'),
        ),
        body: Column(
          children: [
            TabBar(
              tabs: AnbocasFeatures.values
                  .map((e) => Tab(text: e.label))
                  .toList(),
            ),
            Expanded(
                child: TabBarView(
              children:
                  AnbocasFeatures.values.map((e) => e.getTabView()).toList(),
            ))
          ],
        ),
      ),
    );
  }
}

enum AnbocasFeatures {
  events('Events'),
  orders('Orders'),
  companies('Companies'),
  tickets('Tickets');

  final String label;

  const AnbocasFeatures(this.label);
}

extension AnbocasFeaturesView on AnbocasFeatures {
  Widget getTabView() {
    switch (this) {
      case AnbocasFeatures.events:
        return const EventsTabView();
      case AnbocasFeatures.orders:
        return const OrdersTabView();
      case AnbocasFeatures.companies:
        return const CompaniesTabView();
      case AnbocasFeatures.tickets:
        return const TicketsTabView();
    }
  }
}
