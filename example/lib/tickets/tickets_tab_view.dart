import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';
import 'package:flutter/material.dart';

class TicketsTabView extends StatefulWidget {
  const TicketsTabView({super.key, required this.event});

  final AnbocasEventModel event;

  

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
