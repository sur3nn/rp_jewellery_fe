import 'package:flutter/material.dart';

import 'package:flutter_upi_india/flutter_upi_india.dart';
import 'package:intl/intl.dart';

import 'package:lottie/lottie.dart';
import 'package:rp_jewellery/repository/repository.dart';
import 'package:rp_jewellery/screens/all_products/orders.dart';

class PaymentStatus extends StatelessWidget {
  final UpiTransactionResponse status;
  final List<int> ids;

  const PaymentStatus({
    super.key,
    required this.status,
    required this.ids,
  });

  @override
  Widget build(BuildContext context) {
    if (status.status == UpiTransactionStatus.success) {
      Repository().orderPaid(ids);
    }
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(
                height: 250,
                width: 250,
                status.status == UpiTransactionStatus.success
                    ? "assets/lotties/success.lottie"
                    : "assets/lotties/failed.lottie",
                animate: true,
                repeat: false,
                decoder: customDecoder),
            const SizedBox(height: 15),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  border: Border.all(), borderRadius: BorderRadius.circular(8)),
              child: Column(
                children: [
                  Text("Status : ${status.status?.name}"),
                  Text(
                      "Date : ${DateFormat('dd/MM/yyyy').format(DateTime.now())}"),
                  Text("TxnId : ${status.txnId}"),
                  Text("TxnRef : ${status.txnRef}"),
                  Text("Approve No : ${status.approvalRefNo}"),
                ],
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyOrders()));
                },
                child: Text("View Orders"))
          ],
        ),
      ),
    );
  }

  Future<LottieComposition?> customDecoder(List<int> bytes) {
    return LottieComposition.decodeZip(bytes, filePicker: (files) {
      return files.firstWhere(
          (f) => f.name.startsWith('animations/') && f.name.endsWith('.json'));
    });
  }
}
