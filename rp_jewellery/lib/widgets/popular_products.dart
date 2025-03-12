import 'package:flutter/material.dart';
import 'package:rp_jewellery/constants/constants.dart';
import 'package:rp_jewellery/model/product_model.dart';
import 'package:rp_jewellery/widgets/product_card.dart';

class PopularProducts extends StatelessWidget {
  PopularProducts({
    super.key,
  });

  final List<ProductModel> data = List.generate(
    10,
    (index) => ProductModel(
      image: productDemoImg1,
      title: "Mountain Warehouse for Women",
      brandName: "Lipsy london",
      price: 540,
      priceAfetDiscount: 420,
      dicountpercent: 20,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: defaultPadding / 2),
        Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Text(
            "Popular products",
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        // While loading use 👇
        // const ProductsSkelton(),
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            // Find demoPopularProducts on models/ProductModel.dart
            itemCount: data.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(
                left: defaultPadding,
                right: index == data.length - 1 ? defaultPadding : 0,
              ),
              child: ProductCard(
                image: data[index].image,
                brandName: data[index].brandName,
                title: data[index].title,
                price: data[index].price,
                priceAfetDiscount: data[index].priceAfetDiscount,
                dicountpercent: data[index].dicountpercent,
                press: () {},
              ),
            ),
          ),
        )
      ],
    );
  }
}
