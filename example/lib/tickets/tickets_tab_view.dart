import 'package:flutter/material.dart';

class TicketsTabView extends StatefulWidget {
  const TicketsTabView({super.key});

  @override
  State<TicketsTabView> createState() => _TicketsTabViewState();
}

class _TicketsTabViewState extends State<TicketsTabView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Tickets'),
    );
  }
}
