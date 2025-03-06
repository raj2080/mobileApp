import 'package:flutter/material.dart';

import '../../domain/entity/OrderEntity.dart';
import '../../domain/entity/OrderItemEntity.dart';
import '../../domain/entity/ShippingInfoEntity.dart';

class OrderDetailPage extends StatelessWidget {
  final OrderEntity order;

  const OrderDetailPage({Key? key, required this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('#${order.id}', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Order Status Section
              _buildSectionHeader('Order Status', screenWidth),
              _buildOrderTracker(order.orderStatus, screenWidth, screenHeight),
              SizedBox(height: screenHeight * 0.03), // Responsive spacing
              // Order Details Section
              _buildSectionHeader('Order Details', screenWidth),
              _buildDetailRow(
                Icons.payment_outlined,
                'Payment Status',
                order.orderStatus,
                screenWidth,
                color: order.orderStatus == 'Paid' ? Colors.green : Colors.red,
              ),
              SizedBox(height: screenHeight * 0.03), // Responsive spacing
              // Shipping Info Section
              _buildSectionHeader('Shipping Information', screenWidth),
              _buildShippingInfo(order.shippingInfo, screenWidth),
              SizedBox(height: screenHeight * 0.03), // Responsive spacing
              // Total Price Section
              _buildSectionHeader('Total Price', screenWidth),
              _buildPriceRow(order.totalPrice, screenWidth),
              SizedBox(height: screenHeight * 0.03), // Responsive spacing
              // Ordered Products Section
              _buildSectionHeader('Ordered Products', screenWidth),
              SizedBox(height: screenHeight * 0.02), // Responsive spacing
              _buildProductList(order.orderItems, screenWidth),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.03),
      child: Text(
        title,
        style: TextStyle(fontSize: screenWidth * 0.06, fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent),
      ),
    );
  }

  Widget _buildOrderTracker(String status, double screenWidth, double screenHeight) {
    const stages = ["pending", "processing", "delivered"];
    final currentStageIndex = stages.indexOf(status);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(stages.length, (index) {
        final isActive = index <= currentStageIndex;
        return Column(
          children: [
            Container(
              width: screenWidth * 0.14,
              height: screenWidth * 0.14,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors:
                      isActive
                          ? [Colors.purpleAccent, Colors.deepPurple]
                          : [Colors.grey.shade400, Colors.grey.shade600],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  if (isActive)
                    BoxShadow(color: Colors.deepPurpleAccent.withOpacity(0.8), blurRadius: 6, spreadRadius: 1),
                ],
              ),
              child: Icon(isActive ? Icons.check : Icons.circle, color: Colors.white, size: screenWidth * 0.06),
            ),
            SizedBox(height: screenHeight * 0.01),
            Text(
              stages[index],
              style: TextStyle(
                fontSize: screenWidth * 0.04,
                color: isActive ? Colors.deepPurpleAccent : Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String value, double screenWidth, {Color? color}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      child: Row(
        children: [
          Icon(icon, size: screenWidth * 0.06, color: color ?? Colors.deepPurpleAccent),
          SizedBox(width: screenWidth * 0.04),
          Expanded(
            child: Text(
              title,
              style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold, color: Colors.grey.shade700),
            ),
          ),
          Text(
            value,
            style: TextStyle(fontSize: screenWidth * 0.045, color: color ?? Colors.black, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceRow(int price, double screenWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total Price',
            style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold, color: Colors.grey.shade700),
          ),
          Text(
            'Npr.${price.toStringAsFixed(2)}',
            style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold, color: Colors.green.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildProductList(List<OrderItemEntity> items, double screenWidth) {
    return Column(
      children:
          items.map((item) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: screenWidth * 0.015),
              child: Container(
                padding: EdgeInsets.all(screenWidth * 0.03),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(screenWidth * 0.015),
                  boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 8, spreadRadius: 2)],
                ),
                child: Row(
                  children: [
                    // Product Image
                    Container(
                      width: screenWidth * 0.22,
                      height: screenWidth * 0.22,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(screenWidth * 0.015),
                        image: DecorationImage(
                          image: NetworkImage("http://10.0.2.2:3001/products/${item.productImg}"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.03),
                    // Product Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.productName,
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          SizedBox(height: screenWidth * 0.01),
                          Text(
                            'Quantity: ${item.quantity}',
                            style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.grey.shade600),
                          ),
                          SizedBox(height: screenWidth * 0.01),
                          Text(
                            'Npr.${item.price.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: screenWidth * 0.04,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
    );
  }

  Widget _buildShippingInfo(ShippingInfoEntity shippingInfo, double screenWidth) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(screenWidth * 0.015),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 8, spreadRadius: 2)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow(
            Icons.location_on_outlined,
            'Address',
            "${shippingInfo.address}, ${shippingInfo.city}, ${shippingInfo.country}",
            screenWidth,
            color: Colors.grey.shade700,
          ),
          SizedBox(height: screenWidth * 0.02),
          _buildDetailRow(
            Icons.phone_outlined,
            'Phone Number',
            "${shippingInfo.phoneNo}",
            screenWidth,
            color: Colors.grey.shade700,
          ),
        ],
      ),
    );
  }
}
