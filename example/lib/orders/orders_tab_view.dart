// import 'package:anbocas_tickets_api/anbocas_tickets_api.dart';
// import 'package:example/events/event_details_screen.dart';
// import 'package:example/events/event_form_screen.dart';
// import 'package:example/main.dart';
// import 'package:flutter/material.dart';
// import 'package:toastification/toastification.dart';

// class OrdersTabView extends StatefulWidget {
//   const OrdersTabView({super.key});

//   @override
//   State<OrdersTabView> createState() => _OrdersTabViewState();
// }

// class _OrdersTabViewState extends State<OrdersTabView> {
//   @override
//   Widget build(BuildContext context) {
//     if (_isLoading) {
//       return const Center(
//         child: CircularProgressIndicator(),
//       );
//     }

//     final events = _eventsResponse?.data ?? [];

//     return Column(
//       children: [
//         Expanded(
//           child: RefreshIndicator(
//             onRefresh: () async => getOrders(true),
//             child: ListView.builder(
//               itemCount: events.length,
//               itemBuilder: (context, index) {
//                 final event = events[index];
//                 return ListTile(
//                   onTap: () {
//                     OrderDetailsScreen.navigate(context, event);
//                   },
//                   title: Text(event.name ?? 'N/A'),
//                   trailing: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       IconButton(
//                         onPressed: () {
//                           OrderFormScreen.navigate(context, event);
//                         },
//                         icon: const Icon(Icons.edit),
//                       ),
//                       IconButton(
//                         onPressed: () async {
//                           try {
//                             await _anbocasOrders.deleteOrder(
//                               eventId: event.id ?? '',
//                               eventName: event.name ?? '',
//                             );
          
//                             toastification.show(
//                               title: const Text(
//                                   'Order deleted successfully.'),
//                               style: ToastificationStyle.minimal,
//                               type: ToastificationType.success,
//                               autoCloseDuration:
//                                   const Duration(seconds: 5),
//                             );
          
//                             setState(() {
//                               _eventsResponse = _eventsResponse?.copyWith(
//                                 data: (_eventsResponse?.data
//                                         .where(
//                                           (element) =>
//                                               element.id != event.id,
//                                         )
//                                         .toList() ??
//                                     []),
//                               );
//                             });
//                           } catch (e) {
//                             toastification.show(
//                               title: const Text(
//                                   'Opps! something went wrong, Try again.'),
//                               style: ToastificationStyle.minimal,
//                               type: ToastificationType.error,
//                               autoCloseDuration:
//                                   const Duration(seconds: 5),
//                             );
//                           }
//                         },
//                         icon: const Icon(Icons.delete),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//         MaterialButton(
//           height: 50,
//           minWidth: double.infinity,
//           textColor: Colors.white,
//           onPressed: () {
//             if (_eventsResponse?.currentPage != null &&
//                 _eventsResponse?.lastPage != null &&
//                 _eventsResponse!.currentPage! >= _eventsResponse!.lastPage!) {
//               toastification.show(
//                 title: const Text('Nothing to load.'),
//                 style: ToastificationStyle.minimal,
//                 type: ToastificationType.info,
//                 autoCloseDuration: const Duration(seconds: 5),
//               );
//             } else {
//               getOrders();
//             }
//           },
//           color: Colors.blue,
//           child: const Text('Load more'),
//         )
//       ],
//     );
//   }

//   final _anbocasOrders = AnbocasOrders();
//   bool _isLoading = false;
//   AnbocasPaginatedResponse<List<AnbocasOrderModel>>? _eventsResponse;

//   @override
//   void initState() {
//     super.initState();
//     getOrders();
//   }

//   void getOrders([bool refresh = false]) async {
//     setState(() {
//       _isLoading = true;
//     });
//     if (_eventsResponse == null || refresh) {
//       _eventsResponse = await _anbocasOrders.getOrders(
//         companyId: kCompanyId,
//       );
//     } else {
//       final prevOrdersResponse = _eventsResponse;
//       _eventsResponse = await _anbocasOrders.getOrders(
//         companyId: kCompanyId,
//         page: (_eventsResponse!.currentPage ?? 0) + 1,
//       );

//       _eventsResponse = _eventsResponse!.copyWith(
//         data: [...prevOrdersResponse!.data, ..._eventsResponse!.data],
//       );
//     }
//     setState(() {
//       _isLoading = false;
//     });
//   }
// }
