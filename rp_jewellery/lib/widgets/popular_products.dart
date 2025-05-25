import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rp_jewellery/business_logic/all_products_bloc/all_products_bloc.dart';
import 'package:rp_jewellery/constants/constants.dart';
import 'package:rp_jewellery/model/product_model.dart';
import 'package:rp_jewellery/widgets/product_card.dart';

class PopularProducts extends StatelessWidget {
  PopularProducts({
    super.key,
  });
  final List<ProductModel> meta = List.generate(
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
        BlocBuilder<AllProductsBloc, AllProductsState>(
          builder: (context, state) {
            if (state is AllProductsLoading) {
              return CircularProgressIndicator();
            } else if (state is AllProductsSuccess) {
              final data = state.data.data;
              return SizedBox(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  // Find demoPopularProducts on models/ProductModel.dart
                  itemCount: data?.length ?? 0,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(
                      left: defaultPadding,
                      right: index == data!.length - 1 ? defaultPadding : 0,
                    ),
                    child: ProductCard(
                      image: productDemoImg1,
                      brandName: data[index].name ?? "",
                      title: data[index].metal ?? "",
                      price: double.parse(data[index].grandTotal ?? "0"),
                      priceAfetDiscount:
                          double.parse(data[index].grandTotal ?? "0"),
                      dicountpercent: 20,
                      press: () {},
                    ),
                  ),
                ),
              );
            }
            return SizedBox();
          },
        ),
      ],
    );
  }
}
