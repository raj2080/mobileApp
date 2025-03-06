import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import '../../../home/domain/entity/product_entity.dart';
import '../../data/model/OrderItemModel.dart';
import '../../data/model/ShippingInfoModel.dart';
import '../../data/model/order_model.dart';
import '../viewmodel/order_view_model.dart';
import 'package:flutter_paypal/flutter_paypal.dart';

class PaymentPage extends ConsumerStatefulWidget {
  final double shipping;
  final List<ProductEntity> products;

  const PaymentPage({Key? key, required this.shipping, required this.products}) : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends ConsumerState<PaymentPage> {
  String? _selectedPaymentMethod;
  final _addressController = TextEditingController();
  final _phoneNoController = TextEditingController();
  final _cityController = TextEditingController();
  final _provinceController = TextEditingController();
  final _countryController = TextEditingController();
  final _postalCodeController = TextEditingController();
  Map<ProductEntity, int> _productQuantities = {};

  @override
  void initState() {
    super.initState();
    // Initialize product quantities
    _productQuantities = {for (var product in widget.products) product: 1};
  }

  double get _subtotal {
    return _productQuantities.entries.fold(0.0, (sum, entry) {
      return sum + (entry.key.productPrice * entry.value);
    });
  }

  double get _tax => _subtotal * 0.13; // 13% tax

  double get _shipping => widget.shipping; // Use the provided shipping fee

  double get _total => _subtotal + _tax + _shipping;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: const Text('Payment'), backgroundColor: Colors.purple, centerTitle: true),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple[100]!, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('Payment Details', screenWidth),
                SizedBox(height: screenHeight * 0.02),
                _buildPaymentDetail('Subtotal', 'Npr.${_subtotal.toStringAsFixed(2)}', screenWidth),
                _buildPaymentDetail('Shipping', 'Npr.${widget.shipping.toStringAsFixed(2)}', screenWidth),
                _buildPaymentDetail('Tax Price', 'Npr.${_tax.toStringAsFixed(2)}', screenWidth),
                _buildPaymentDetail('Total', 'Npr.${_total.toStringAsFixed(2)}', screenWidth),
                SizedBox(height: screenHeight * 0.02),
                _buildSectionTitle('Products', screenWidth),
                SizedBox(height: screenHeight * 0.01),
                _buildProductList(screenWidth),
                SizedBox(height: screenHeight * 0.02),
                _buildSectionTitle('Payment Method', screenWidth),
                SizedBox(height: screenHeight * 0.01),
                _buildSectionTitle('Payment Method', screenWidth),
                SizedBox(height: screenHeight * 0.01),
                _buildPaymentMethod(
                  Icons.payment,
                  'Cash on Delivery',
                  'Pay with cash when the order is delivered.',
                  screenWidth,
                ),
                SizedBox(height: screenHeight * 0.02),
                _buildPaymentMethod(Icons.paypal, 'Paypal', 'Pay with PayPal for secure payment .', screenWidth),
                SizedBox(height: screenHeight * 0.02),
                _buildSectionTitle('Shipping Information', screenWidth),
                SizedBox(height: screenHeight * 0.01),
                _buildShippingInformation(screenWidth),
                SizedBox(height: screenHeight * 0.02),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _confirmOrder,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenWidth * 0.03)),
                        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02, horizontal: screenWidth * 0.1),
                        elevation: 8,
                      ).copyWith(
                        shadowColor: MaterialStateProperty.all(Colors.purple.withOpacity(0.5)),
                        side: MaterialStateBorderSide.resolveWith(
                          (states) => BorderSide(color: Colors.purpleAccent, width: screenWidth * 0.005),
                        ),
                      ),
                      child: Text(
                        'Confirm Payment',
                        style: TextStyle(
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, double screenWidth) {
    return Text(
      title,
      style: TextStyle(fontSize: screenWidth * 0.06, fontWeight: FontWeight.bold, color: Colors.purple),
    );
  }

  Widget _buildPaymentDetail(String title, String value, double screenWidth) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenWidth * 0.03)),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.w600)),
            Text(value, style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.grey[700])),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentMethod(IconData icon, String method, String description, double screenWidth) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenWidth * 0.03)),
      child: ListTile(
        leading: Icon(icon, color: Colors.purple, size: screenWidth * 0.08),
        title: Text(
          method,
          style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold, color: Colors.purple),
        ),
        subtitle: Text(description, style: TextStyle(color: Colors.grey[600], fontSize: screenWidth * 0.04)),
        onTap: () {
          setState(() {
            _selectedPaymentMethod = method;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Selected: $method')));
        },
        tileColor: _selectedPaymentMethod == method ? Colors.purple[50] : Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: _selectedPaymentMethod == method ? Colors.purple : Colors.transparent, width: 2),
          borderRadius: BorderRadius.circular(screenWidth * 0.03),
        ),
      ),
    );
  }

  Widget _buildShippingInformation(double screenWidth) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTextField('Address:', _addressController, screenWidth),
        SizedBox(height: 8.0),
        _buildTextField('City:', _cityController, screenWidth),
        SizedBox(height: 8.0),
        _buildTextField('Province:', _provinceController, screenWidth),
        SizedBox(height: 8.0),
        _buildTextField('Country:', _countryController, screenWidth),
        SizedBox(height: 8.0),
        _buildTextField('Postal Code:', _postalCodeController, screenWidth, keyboardType: TextInputType.number),
        SizedBox(height: 8.0),
        _buildTextField('Phone Number:', _phoneNoController, screenWidth, keyboardType: TextInputType.number),
      ],
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    double screenWidth, {
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: screenWidth * 0.04)),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Enter your $label'.toLowerCase()),
        ),
      ],
    );
  }

  Widget _buildProductList(double screenWidth) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _productQuantities.length,
      itemBuilder: (context, index) {
        final product = _productQuantities.keys.elementAt(index);
        return Card(
          elevation: 4,
          margin: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(screenWidth * 0.03)),
          child: Padding(
            padding: EdgeInsets.all(screenWidth * 0.03),
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: "http://10.0.2.2:3001/products/${product.productImage}",
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  width: screenWidth * 0.2,
                  height: screenWidth * 0.2,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: screenWidth * 0.03),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.productName,
                        style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: screenWidth * 0.01),
                      Text(
                        'Npr.${product.productPrice.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.grey[700]),
                      ),
                      SizedBox(height: screenWidth * 0.02),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildQuantityControl(product, screenWidth),
                          Text(
                            'Total: Npr.${(product.productPrice * _productQuantities[product]!).toStringAsFixed(2)}',
                            style: TextStyle(fontSize: screenWidth * 0.04, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuantityControl(ProductEntity product, double screenWidth) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.remove, color: Colors.purple, size: screenWidth * 0.07),
          onPressed: () {
            setState(() {
              if (_productQuantities[product]! > 1) {
                _productQuantities[product] = _productQuantities[product]! - 1;
              }
            });
          },
        ),
        Text(
          '${_productQuantities[product]}',
          style: TextStyle(fontSize: screenWidth * 0.045, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: Icon(Icons.add, color: Colors.purple, size: screenWidth * 0.07),
          onPressed: () {
            setState(() {
              _productQuantities[product] = _productQuantities[product]! + 1;
            });
          },
        ),
      ],
    );
  }

  void _confirmOrder() {
    if (_selectedPaymentMethod == null ||
        _addressController.text.isEmpty ||
        _phoneNoController.text.isEmpty ||
        _cityController.text.isEmpty ||
        _provinceController.text.isEmpty ||
        _countryController.text.isEmpty ||
        _postalCodeController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Please fill in all fields and select a payment method.')));
      return;
    }

    final shippingInfo = ShippingInfoModel(
      address: _addressController.text,
      city: _cityController.text,
      province: _provinceController.text,
      country: _countryController.text,
      postalCode: int.parse(_postalCodeController.text),
      phoneNo: int.parse(_phoneNoController.text),
    );

    final orderItems =
        _productQuantities.entries.map((entry) {
          return OrderItemModel(
            productId: "${entry.key.id}",
            quantity: entry.value,
            price: entry.key.productPrice,
            productName: entry.key.productName,
            productImg: entry.key.productImage,
          );
        }).toList();

    final orderModel = OrderModel(
      shippingInfo: shippingInfo,
      orderItems: orderItems,
      paymentInfo: "cash on Delivery",
      itemsPrice: _subtotal.round(),
      taxPrice: _tax.round(),
      shippingPrice: _shipping.round(),
      totalPrice: _total.round(),
      orderStatus: 'Processing',
      user: '',
    );

    ref.read(orderViewModelProvider.notifier).createOrder(orderModel);

    if (_selectedPaymentMethod == "Paypal") {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder:
              (BuildContext context) => UsePaypal(
                sandboxMode: true,
                clientId: "AcnpbvL-nqay69eboBK-a2hcQLnkFTQZXbTF0f4UafVwhRYAXe11Z0B3PtFyWCTDH24INY6Cu2U0rhRC",
                secretKey: "EGZXWncK71BKAfqH7ClPpldekK6kSKvO9yIk0Loz36CkdM7uLC_vuE5mjbGjRhJhBT5BeOYyBB-_p6WW",
                returnURL: "https://samplesite.com/return",
                cancelURL: "https://samplesite.com/cancel",
                transactions: [
                  {
                    "amount": {
                      "total": '20',
                      "currency": "USD",
                      "details": {"subtotal": '20', "shipping": '0', "shipping_discount": 0},
                    },
                    "description": "The payment transaction description.",
                    "item_list": {
                      "items": [
                        {"name": 'tewst', "quantity": 1, "price": '20', "currency": "USD"},
                      ],
                    },
                  },
                ],
                note: "Contact us for any questions on your order.",
                onSuccess: (Map params) async {
                  if (mounted) {
                    setState(() {
                      // Handle successful payment
                    });
                  }
                  print("onSuccess: $params");
                  // Handle successful payment
                },
                onError: (error) {
                  if (mounted) {
                    setState(() {
                      // Handle payment error
                    });
                  }
                  print("onError: $error");
                },
                onCancel: (params) {
                  if (mounted) {
                    setState(() {
                      // Handle payment cancellation
                    });
                  }
                  print('Cancelled: $params');
                },
              ),
        ),
      );
    }
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Order has been confirmed!')));
    // showDialog(
    //   context: context,
    //   builder: (context) {
    //     return AlertDialog(
    //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    //       content: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         children: [
    //           Lottie.asset(
    //             'assets/success.json', // Update the path to your Lottie animation file
    //             width: 150,
    //             height: 150,
    //             fit: BoxFit.cover,
    //           ),
    //           SizedBox(height: 16),
    //           Text(
    //             'Order Placed Successfully!',
    //             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purple),
    //           ),
    //           SizedBox(height: 8),
    //           Text('Thank you for your purchase.', textAlign: TextAlign.center),
    //         ],
    //       ),
    //       actions: [
    //         TextButton(
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //             // Navigate to the order details or home page
    //             Navigator.of(context).pop(); // Pop the PaymentPage
    //           },
    //           child: Text('OK'),
    //         ),
    //       ],
    //     );
    //   },
    // );
  }
}
