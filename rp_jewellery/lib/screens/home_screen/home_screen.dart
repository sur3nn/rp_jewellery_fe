import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rp_jewellery/business_logic/all_products_bloc/all_products_bloc.dart';
import 'package:rp_jewellery/business_logic/gold_price_bloc/gold_price_bloc.dart';
import 'package:rp_jewellery/business_logic/silver_price_bloc/silver_price_bloc.dart';
import 'package:rp_jewellery/constants/constants.dart';
import 'package:rp_jewellery/screens/all_products/view_product.dart';
import 'package:rp_jewellery/widgets/offer_carousel.dart';
import 'package:rp_jewellery/widgets/popular_products.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SilverPriceBloc>().add(GetSilverPriceEvent());
      context.read<GoldPriceBloc>().add(GetGoldPriceEvent());
    });
    return Scaffold(
      backgroundColor: const Color.fromRGBO(253, 239, 233, 1),
      body: SafeArea(
        child: Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/goldcoin.svg",
                                height: 40,
                                width: 40,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                children: [
                                  const Text("Gold Rate"),
                                  Text(
                                    "₹ 9,340 ",
                                    style: const TextStyle(color: Colors.green),
                                  ),
                                  // BlocBuilder<GoldPriceBloc, GoldPriceState>(
                                  //   builder: (context, state) {
                                  //     if (state is GoldPriceSuccess) {
                                  //       return Text(
                                  //         state.price,
                                  //         style:
                                  //             const TextStyle(color: Colors.green),
                                  //       );
                                  //     } else if (state is GoldPriceFailure) {
                                  //       return Text(
                                  //         "9,340 ",
                                  //         style:
                                  //             const TextStyle(color: Colors.green),
                                  //       );
                                  //     }

                                  //     return const SizedBox();
                                  //   },
                                  // ),
                                  const Text("22KT Per gram",
                                      style: TextStyle(
                                        fontSize: 10,
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/silvercoin.svg",
                                height: 40,
                                width: 40,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Column(
                                children: [
                                  Text("Silver Rate"),
                                  Text(
                                    "₹ 112",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                  // BlocBuilder<SilverPriceBloc, SilverPriceState>(
                                  //   builder: (context, state) {
                                  //     if (state is SilverPriceSucess) {
                                  //       return Text(
                                  //         state.price,
                                  //         style: TextStyle(color: Colors.green),
                                  //       );
                                  //     } else if (state is SilverPriceFailure) {
                                  //       return Text(
                                  //         "112",
                                  //         style: TextStyle(color: Colors.green),
                                  //       );
                                  //     }
                                  //     return SizedBox();
                                  //   },
                                  // ),
                                  Text("Per gram",
                                      style: TextStyle(
                                        fontSize: 10,
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const OffersCarousel(),
                // PopularProducts(),

                BlocBuilder<AllProductsBloc, AllProductsState>(
                  builder: (context, state) {
                    if (state is AllProductsLoading) {
                      return CircularProgressIndicator();
                    } else if (state is AllProductsSuccess) {
                      return GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(10),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 15,
                                childAspectRatio: 1 / 1.60),
                        itemCount: state.data.data?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          final data = state.data.data![index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ProductViewScreen(
                                            data: data,
                                          )));
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 215, 214, 214)),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  data.image != null
                                      ? Image.memory(
                                          height: 150,
                                          width: 150,
                                          base64Decode(data.image!
                                              .replaceAll('\n', '')
                                              .replaceAll('\r', '')))
                                      : Image.asset('assets/icons/studs.jpg'),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    data.metal ?? "",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(fontSize: 10),
                                  ),
                                  const SizedBox(height: defaultPadding / 2),
                                  Text(
                                    data.name ?? "",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(fontSize: 12),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "Rs.${data.grandTotal}",
                                    style: const TextStyle(
                                      color: Color(0xFF31B0D8),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
