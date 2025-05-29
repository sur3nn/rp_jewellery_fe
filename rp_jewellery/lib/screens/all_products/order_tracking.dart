import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:order_tracker/order_tracker.dart';
import 'package:rp_jewellery/constants/constants.dart';

class OrderTracking extends StatelessWidget {
  final String status;
  final String date;

  const OrderTracking({super.key, required this.status, required this.date});

  @override
  Widget build(BuildContext context) {
    List<TextDto> orderList = [
      TextDto("Your order has been placed", formatCustomDate(date)),
      TextDto("Seller ha processed your order", formatCustomDate(date)),
    ];

    List<TextDto> shippedList = [
      TextDto("Your order has been shipped", formatCustomDate(date)),
    ];

    List<TextDto> outOfDeliveryList = [
      TextDto("Your order is out for delivery", formatCustomDate(date)),
    ];

    List<TextDto> deliveredList = [
      TextDto("Your order has been delivered", formatCustomDate(date)),
    ];
    return Scaffold(
      appBar: AppBar(title: Text("Order Tracking")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: OrderTracker(
          headingTitleStyle: TextStyle(
              color: blackColor, fontWeight: FontWeight.w600, fontSize: 16),
          headingDateTextStyle: TextStyle(
              color: blackColor, fontWeight: FontWeight.w500, fontSize: 16),
          subDateTextStyle: TextStyle(color: blackColor, fontSize: 14),
          subTitleTextStyle: TextStyle(
              color: const Color.fromARGB(255, 58, 58, 58), fontSize: 12),
          status: status == "Pending"
              ? Status.order
              : status == "Shipped"
                  ? Status.shipped
                  : Status.delivered,
          activeColor: Colors.green,
          inActiveColor: Colors.grey[300],
          orderTitleAndDateList: orderList,
          shippedTitleAndDateList: shippedList,
          outOfDeliveryTitleAndDateList: outOfDeliveryList,
          deliveredTitleAndDateList: deliveredList,
        ),
      ),
    );
  }

  String formatCustomDate(String rawDateStr) {
    // Step 1: Parse input like "30 May 4:36 AM"
    final now = DateTime.now();
    final fullRaw = '${now.year} $rawDateStr'; // Add year to parse it
    final inputFormat = DateFormat("yyyy d MMM h:mm a");
    final dateTime = inputFormat.parse(fullRaw);

    // Step 2: Build final format
    final weekday = DateFormat('EEE').format(dateTime); // e.g., Fri
    final day = dateTime.day;
    final month = DateFormat('MMM').format(dateTime); // e.g., Mar
    final year = DateFormat("''yy").format(dateTime); // e.g., '22
    final time =
        DateFormat('h:mma').format(dateTime).toLowerCase(); // e.g., 10:47pm

    // Step 3: Add ordinal suffix (st, nd, rd, th)
    String suffix;
    if (day >= 11 && day <= 13) {
      suffix = 'th';
    } else {
      switch (day % 10) {
        case 1:
          suffix = 'st';
          break;
        case 2:
          suffix = 'nd';
          break;
        case 3:
          suffix = 'rd';
          break;
        default:
          suffix = 'th';
      }
    }

    return "$weekday, ${day}${suffix} $month $year - $time";
  }
}
