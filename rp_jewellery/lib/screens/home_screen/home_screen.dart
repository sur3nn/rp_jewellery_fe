import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:rp_jewellery/widgets/offer_carousel.dart';
import 'package:rp_jewellery/widgets/popular_products.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(252, 242, 243, 1),
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
                              Text("Gold Rate"),
                              Text(
                                "₹ 8,020",
                                style: TextStyle(color: Colors.green),
                              ),
                              Text("22KT Per gram",
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
                                "₹ 8,020",
                                style: TextStyle(color: Colors.green),
                              ),
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
