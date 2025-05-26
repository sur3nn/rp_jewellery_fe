import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_upi_india/flutter_upi_india.dart';
import 'package:rp_jewellery/business_logic/cart_list_bloc/cart_list_bloc.dart';
import 'package:rp_jewellery/model/cart_list_model.dart';
import 'package:rp_jewellery/model/cart_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({
    Key? key,
  }) : super(key: key);

  double _calculateSubtotal(List<CartData> data) {
    return data.fold(
        0, (sum, item) => sum + int.parse(item.totalPrice!) * item.quantity!);
  }

  @override
  Widget build(BuildContext context) {
    context.read<CartListBloc>().add(StartCartList());
    return Scaffold(
      appBar: AppBar(title: const Text("Your Cart")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder<CartListBloc, CartListState>(
              builder: (context, state) {
                if (state is CartListLoading) {
                  return CircularProgressIndicator();
                } else if (state is CartListSuccess) {
                  double discount = 200;
                  double subtotal = _calculateSubtotal(state.data.data!);
                  double gst = (subtotal - discount) * 0.18;
                  double total = subtotal - discount + gst;
                  return Column(
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(16),
                        itemCount: state.data.data?.length ?? 0,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final item = state.data.data![index];
                          return ListTile(
                            leading: Image.asset('assets/icons/studs.jpg',
                                width: 50),
                            title: Text(item.descrption ?? ""),
                            subtitle: Text("Qty: ${item.quantity}"),
                            trailing: Text(
                                "₹${(int.parse(item.totalPrice!) * item.quantity!).toStringAsFixed(2)}"),
                          );
                        },
                      ),
                      const Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            _buildSummaryRow("Subtotal",
                                "₹${_calculateSubtotal(state.data.data!).toStringAsFixed(2)}"),
                            _buildSummaryRow("Discount",
                                "- ₹${discount.toStringAsFixed(2)}"),
                            _buildSummaryRow(
                                "GST (18%)", "+ ₹${gst.toStringAsFixed(2)}"),
                            const Divider(),
                            _buildSummaryRow(
                                "Total", "₹${total.toStringAsFixed(2)}",
                                bold: true),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  _showUpiApps(context);
                                },
                                child: const Text("Proceed to Checkout"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showUpiApps(BuildContext context) async {
    List<ApplicationMeta>? apps = await UpiPay.getInstalledUpiApplications(
        statusType: UpiApplicationDiscoveryAppStatusType.all);

    if (apps.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No UPI apps found!")),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      builder: (context) => ListView(
        shrinkWrap: true,
        children: apps.map((app) {
          return ListTile(
            leading: app.iconImage(40),
            title: Text(app.upiApplication.getAppName()),
            onTap: () {
              Navigator.pop(context); // Close bottom sheet
              _initiateTransaction(app);
            },
          );
        }).toList(),
      ),
    );
  }

  Future<void> _initiateTransaction(ApplicationMeta appMeta) async {
    final response = await UpiPay.initiateTransaction(
      app: appMeta.upiApplication,
      receiverName: 'Surendar S',
      receiverUpiAddress: 'surendar9080@ybl',
      transactionRef: 'UPITXREF0001',
      transactionNote: 'A UPI Transaction',
      amount: "100",
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
