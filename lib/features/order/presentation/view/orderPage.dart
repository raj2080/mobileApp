import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodel/order_view_model.dart';
import 'orderDetailPage.dart';

class OrderPage extends ConsumerStatefulWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  ConsumerState<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends ConsumerState<OrderPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(orderViewModelProvider.notifier).fetchUserOrders();
    });
  }

  @override
  Widget build(BuildContext context) {
    var orderstate = ref.watch(orderViewModelProvider);
    print(orderstate.orders);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        backgroundColor: Colors.deepPurple.shade200,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child:orderstate.orders == null || orderstate.orders!.isEmpty
            ? Center(
          child: Text(
            'You haven\'t ordered any items yet.',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
        )
            : ListView.builder(
          itemCount: orderstate.orders?.length ?? 0,
          itemBuilder: (context, index) {
            final order = orderstate.orders?[orderstate.orders!.length - 1 - index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5,
              margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
              child: ListTile(
                contentPadding: const EdgeInsets.all(15.0),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.deepPurple.shade200,
                  child: Icon(
                    Icons.shopping_bag,
                    color: Colors.deepPurple,
                    size: 30,
                  ),
                ),
                title: Row(
                  children: [
                    Icon(Icons.confirmation_number, size: 18, color: Colors.deepOrange),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '#${order?.id}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 5),
                    Text(
                      "Details of the order #${order?.id}'",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 14, color: Colors.grey[600]),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            'Order Name: ${order?.orderItems?.map((item) => item.productName).join(', ') ?? 'No Items'}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.shopping_cart, size: 14, color: Colors.grey[600]),
                        SizedBox(width: 5),
                        Text(
                          'Items: ${order?.orderItems?.map((item) => item.quantity).join(', ') ?? 'No Items'}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.payment, size: 14, color: Colors.grey[600]),
                        SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            'Payment Method: ${order?.paymentInfo}',
                            style: TextStyle(
                              fontSize: 12,
                              color: order?.orderStatus == 'Paid' ? Colors.green : Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    _buildStatusBadge("${order?.orderStatus}"),
                  ],
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Npr.${order?.totalPrice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderDetailPage(order: order!),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    final statusColor = status == 'Delivered'
        ? Colors.green
        : status == 'Processing'
        ? Colors.orange
        : Colors.red;
    final statusText = status == 'Delivered'
        ? 'Delivered'
        : status == 'processing'
        ? 'Processing'
        : 'Pending';

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: statusColor),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          color: statusColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
