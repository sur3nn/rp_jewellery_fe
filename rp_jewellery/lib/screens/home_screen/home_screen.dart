import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rp_jewellery/business_logic/gold_price_bloc/gold_price_bloc.dart';
import 'package:rp_jewellery/business_logic/silver_price_bloc/silver_price_bloc.dart';
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
            PopularProducts(),
          ],
        ),
      ),
    );
  }
}
