import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_tracker/order_tracker.dart';
import 'package:rp_jewellery/business_logic/my_orders_bloc/my_orders_bloc.dart';
import 'package:rp_jewellery/constants/constants.dart';
import 'package:rp_jewellery/screens/all_products/order_tracking.dart';

class MyOrders extends StatelessWidget {
  const MyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<MyOrdersBloc>().add(StartOrders());
    return Scaffold(
      appBar: AppBar(title: Text("My Orders")),
      body: BlocBuilder<MyOrdersBloc, MyOrdersState>(
        builder: (context, state) {
          if (state is MyOrdersLoading) {
            return CircularProgressIndicator();
          } else if (state is MyOrdersSuccess) {
            return ListView.separated(
                padding: EdgeInsets.all(15),
                itemCount: state.dat.data?.length ?? 0,
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final data = state.dat.data![index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderTracking(
                                    date: data.date ?? "",
                                    status: data.status ?? "",
                                  )));
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: blackColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: data.orderDetails
                                    ?.map(
                                      (e) => Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            e.image != null
                                                ? Image.memory(base64Decode(e
                                                    .image!
                                                    .replaceAll('\n', '')
                                                    .replaceAll('\r', '')))
                                                : Image.asset(
                                                    'assets/icons/studs.jpg'),
                                            Text(e.total?.toString() ?? " - "),
                                            Text(e.productName ?? " - "),
                                          ],
                                        ),
                                      ),
                                    )
                                    .toList() ??
                                []),
                      ),
                    ),
                  );
                });
          }
          return SizedBox();
        },
      ),
    );
  }
}
