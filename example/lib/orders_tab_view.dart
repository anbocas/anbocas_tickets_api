import 'package:flutter/material.dart';

class OrdersTabView extends StatefulWidget {
  const OrdersTabView({super.key});

  @override
  State<OrdersTabView> createState() => _OrdersTabViewState();
}

class _OrdersTabViewState extends State<OrdersTabView> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Orders'),
    );
  }
}
