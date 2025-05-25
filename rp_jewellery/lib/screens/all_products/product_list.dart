import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rp_jewellery/business_logic/all_products_bloc/all_products_bloc.dart';
import 'package:rp_jewellery/constants/constants.dart';
import 'package:rp_jewellery/screens/all_products/view_product.dart';

class AddToCart extends StatelessWidget {
  const AddToCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AllProductsBloc, AllProductsState>(
        builder: (context, state) {
          if (state is AllProductsLoading) {
            return CircularProgressIndicator();
          } else if (state is AllProductsSuccess) {
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                            color: const Color.fromARGB(255, 215, 214, 214)),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Image.asset('assets/icons/studs.jpg'),
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
    );
  }
}
