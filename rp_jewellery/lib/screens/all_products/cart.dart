import 'package:flutter/material.dart';
import 'package:rp_jewellery/model/cart_model.dart';

class CartScreen extends StatelessWidget {
  final List<CartItem> cartItems;

  const CartScreen({Key? key, required this.cartItems}) : super(key: key);

  double _calculateSubtotal() {
    return cartItems.fold(0, (sum, item) => sum + item.price * item.quantity);
  }

  @override
  Widget build(BuildContext context) {
    double discount = 200;
    double subtotal = _calculateSubtotal();
    double gst = (subtotal - discount) * 0.18;
    double total = subtotal - discount + gst;

    return Scaffold(
      appBar: AppBar(title: const Text("Your Cart")),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: cartItems.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return ListTile(
                  leading: Image.asset(item.imagePath, width: 50),
                  title: Text(item.name),
                  subtitle: Text("Qty: ${item.quantity}"),
                  trailing: Text(
                      "₹${(item.price * item.quantity).toStringAsFixed(2)}"),
                );
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _buildSummaryRow("Subtotal", "₹${subtotal.toStringAsFixed(2)}"),
                _buildSummaryRow(
                    "Discount", "- ₹${discount.toStringAsFixed(2)}"),
                _buildSummaryRow("GST (18%)", "+ ₹${gst.toStringAsFixed(2)}"),
                const Divider(),
                _buildSummaryRow("Total", "₹${total.toStringAsFixed(2)}",
                    bold: true),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // navigate to payment screen or place order
                    },
                    child: const Text("Proceed to Checkout"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
          Text(value,
              style: TextStyle(
                  fontWeight: bold ? FontWeight.bold : FontWeight.normal)),
        ],
      ),
    );
  }
}
