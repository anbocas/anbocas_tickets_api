import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key, required this.order});

  final AnbocasOrderModel order;

  static void navigate(BuildContext context, AnbocasOrderModel order) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderDetailsScreen(order: order),
        ));
  }

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.order.name ?? 'N/A'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : order != null
              ? ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Text(order!.name ?? 'N/A'),
                    const Gap(10),
                    Text(
                        'Order Convenience Fee: ${order!.convenienceFee ?? 'N/A'}'),
                    const Gap(10),
                    Text('Company: ${order!.company?.name ?? 'N/A'}'),
                    const Gap(10),
                    Text('Discount Amount: ${order!.discountAmount ?? 'N/A'}'),
                    const Gap(10),
                    Text('ConvenienceTax: ${order!.convenienceTax ?? 'N/A'}'),
                    const Gap(10),
                    Text('Company Name: ${order!.company?.name}'),
                    const Gap(10),
                    Text('Email: ${order!.email}'),
                    const Gap(10),
                    Text('Order: ${order!.event?.name ?? 'N/A'}'),
                    const Gap(10),
                  ],
                )
              : null,
    );
  }

  bool isLoading = false;
  AnbocasOrderModel? order;
  final anbocasOrders = AnbocasOrders();

  @override
  void initState() {
    super.initState();
    getOrder();
  }

  void getOrder() async {
    setState(() {
      isLoading = true;
    });
    order = await anbocasOrders.getOrder(widget.order.id ?? '');
    setState(() {
      isLoading = false;
    });
  }
}
