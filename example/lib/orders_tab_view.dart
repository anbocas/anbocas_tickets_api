import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';
import 'package:example/main.dart';
import 'package:flutter/material.dart';

class OrdersTabView extends StatefulWidget {
  const OrdersTabView({super.key});

  @override
  State<OrdersTabView> createState() => _OrdersTabViewState();
}

class _OrdersTabViewState extends State<OrdersTabView> {
  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    final orders = _orderResponse?.data??[];

    return RefreshIndicator(
      onRefresh: () async => getOrders(),
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          // final event = _events[index];
          return ListTile(
            // title: Text(event.name ?? 'N/A'),
          );
        },
      ),
    );
  }

  final _anbocasOrders = AnbocasOrders();
  bool _isLoading = false;
  OrderResponse? _orderResponse;

  @override
  void initState() {
    super.initState();
    getOrders();
  }

  void getOrders() async {
    setState(() {
      _isLoading = true;
    });
    _orderResponse = await _anbocasOrders.getOrders(companyId: kCompanyId);
    setState(() {
      _isLoading = false;
    });
  }
}
