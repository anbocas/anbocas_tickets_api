import 'package:flutter/material.dart';

enum AnbocasFeatures {
  events('Events'),
  orders('Orders'),
  companies('Companies'),
  tickets('Tickets');

  final String label;

  const AnbocasFeatures(this.label);
}

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
            Expanded(child: TabBarView(children: []))
          ],
        ),
      ),
    );
  }
}
