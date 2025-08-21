import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key, required this.company});

  final AnbocasCompanyModel company;

  static void navigate(BuildContext context, AnbocasCompanyModel company) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OrdersScreen(company: company),
      ),
    );
  }

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final orders = _ordersResponse?.data ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.company.name ?? 'N/A'} Orders'),
      ),
      bottomNavigationBar: !_isLoading
          ? MaterialButton(
              height: 50,
              minWidth: double.infinity,
              textColor: Colors.white,
              onPressed: () {
                if (_ordersResponse?.currentPage != null &&
                    _ordersResponse?.lastPage != null &&
                    _ordersResponse!.currentPage! >=
                        _ordersResponse!.lastPage!) {
                  toastification.show(
                    title: const Text('Nothing to load.'),
                    style: ToastificationStyle.minimal,
                    type: ToastificationType.info,
                    autoCloseDuration: const Duration(seconds: 5),
                  );
                } else {
                  getOrders();
                }
              },
              color: Colors.blue,
              child: const Text('Load more'),
            )
          : null,
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () async => getOrders(true),
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  final order = orders[index];
                  return ListTile(
                    onTap: () {
                      // CompanyDetailsScreen.navigate(context, order);
                    },
                    title: Text(order.name ?? 'N/A'),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) => _itemBuilder(context, order),
                    ),
                  );
                },
              ),
            ),
    );
  }

  final _anbocasOrders = AnbocasOrders();
  bool _isLoading = false;
  AnbocasPaginatedResponse<List<AnbocasOrderModel>>? _ordersResponse;

  @override
  void initState() {
    super.initState();
    getOrders();
  }

  void getOrders([bool refresh = false]) async {
    setState(() {
      _isLoading = true;
    });
    if (_ordersResponse == null || refresh) {
      _ordersResponse = await _anbocasOrders.getOrders(
        companyId: widget.company.id ?? '',
        paginate: true,
      );
    } else {
      final prevOrdersResponse = _ordersResponse;
      _ordersResponse = await _anbocasOrders.getOrders(
        companyId: widget.company.id ?? '',
        paginate: true,
        page: (_ordersResponse!.currentPage ?? 0) + 1,
      );

      _ordersResponse = _ordersResponse!.copyWith(
        data: [...prevOrdersResponse!.data, ..._ordersResponse!.data],
      );
    }
    setState(() {
      _isLoading = false;
    });
  }

  List<PopupMenuEntry> _itemBuilder(
    BuildContext context,
    AnbocasOrderModel order,
  ) {
    return [
      PopupMenuItem(
        onTap: () {
          // CompanyFormScreen.navigate(context, order);
        },
        child: const Text('Edit'),
      ),
      PopupMenuItem(
        onTap: () async {
          // try {
          //   await _anbocasOrders.deleteCompany(
          //     orderId: order.id ?? '',
          //   );

          //   toastification.show(
          //     title: const Text('Company deleted successfully.'),
          //     style: ToastificationStyle.minimal,
          //     type: ToastificationType.success,
          //     autoCloseDuration: const Duration(seconds: 5),
          //   );

          //   setState(() {
          //     _ordersResponse = _ordersResponse?.copyWith(
          //       data: (_ordersResponse?.data
          //               .where(
          //                 (element) => element.id != order.id,
          //               )
          //               .toList() ??
          //           []),
          //     );
          //   });
          // } catch (e) {
          //   toastification.show(
          //     title: const Text('Opps! something went wrong, Try again.'),
          //     style: ToastificationStyle.minimal,
          //     type: ToastificationType.error,
          //     autoCloseDuration: const Duration(seconds: 5),
          //   );
          // }
        },
        child: const Text('Delete'),
      ),
    ];
  }
}
