import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rp_jewellery/business_logic/all_products_bloc/all_products_bloc.dart';
import 'package:rp_jewellery/constants/constants.dart';
import 'package:rp_jewellery/model/all_product_model.dart';
import 'package:rp_jewellery/repository/repository.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductViewScreen extends StatefulWidget {
  final AllProductData data;
  const ProductViewScreen({super.key, required this.data});

  @override
  State<ProductViewScreen> createState() => _ProductViewScreenState();
}

class _ProductViewScreenState extends State<ProductViewScreen> {
  final List<String> _images = [
    'assets/icons/studs.jpg',
    'assets/icons/studs.jpg',
    'assets/icons/studs.jpg',
  ];

  List memoryImage = [];

  final PageController _pageController = PageController();
  int _currentIndex = 0;
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    memoryImage = widget.data.image != null
        ? [
            base64Decode(
                widget.data.image!.replaceAll('\n', '').replaceAll('\r', '')),
            base64Decode(
                widget.data.image!.replaceAll('\n', '').replaceAll('\r', '')),
            base64Decode(
                widget.data.image!.replaceAll('\n', '').replaceAll('\r', '')),
          ]
        : _images;
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product View'),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        // backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 300,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.data.image != null
                      ? memoryImage.length
                      : _images.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: widget.data.image != null
                          ? Image.memory(memoryImage[index])
                          : Image.asset(
                              _images[index],
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: AnimatedSmoothIndicator(
                  activeIndex: _currentIndex,
                  count: _images.length,
                  effect: const ExpandingDotsEffect(
                    // activeDotColor: Colors.teal,
                    dotHeight: 8,
                    dotWidth: 8,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Quantity",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: _decrementQuantity,
                      ),
                      Text(
                        '$_quantity',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: _incrementQuantity,
                      ),
                    ],
                  ),
                  ColorSelection()
                ],
              ),
              Text(
                "Description",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(widget.data.descrption ?? ""),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _showAddToCartBottomSheet(
                    context,
                    _quantity,
                    double.parse(widget.data.grandTotal ?? "0"),
                    widget.data.productMaterialId!),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  // backgroundColor: Colors.teal,
                ),
                child: const Text('Add to Cart'),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "People also like",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              BlocBuilder<AllProductsBloc, AllProductsState>(
                builder: (context, state) {
                  if (state is AllProductsLoading) {
                    return CircularProgressIndicator();
                  } else if (state is AllProductsSuccess) {
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(10),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15,
                              childAspectRatio: 1 / 1.6),
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
                                  style: TextStyle(
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
    );
  }
}

class ColorSelection extends StatefulWidget {
  const ColorSelection({super.key});

  @override
  State<ColorSelection> createState() => _ColorSelectionState();
}

class _ColorSelectionState extends State<ColorSelection> {
  final List<Color> _availableColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
  ];
  int _selectedColorIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Row(
          children: List.generate(_availableColors.length, (index) {
            final color = _availableColors[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColorIndex = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: _selectedColorIndex == index
                        ? Colors.black
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

void _showAddToCartBottomSheet(
    BuildContext context, _quantity, double unitPrice, int producId) {
  const double discount = 200;
  const double gstRate = 0.18;

  final double price = unitPrice * _quantity;
  final double gst = (price - discount) * gstRate;
  final double total = price - discount + gst;

  showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              "Bill Summary",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            _buildBillRow(
                "Price (x$_quantity)", "₹${price.toStringAsFixed(2)}"),
            _buildBillRow("Discount", "- ₹${discount.toStringAsFixed(2)}"),
            _buildBillRow("GST (18%)", "+ ₹${gst.toStringAsFixed(2)}"),
            const Divider(),
            _buildBillRow(
              "Total",
              "₹${total.toStringAsFixed(2)}",
              isBold: true,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Repository().addToCart(producId, _quantity);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Item added to cart")),
                  );
                },
                child: const Text("Confirm Add to Cart"),
              ),
            )
          ],
        ),
      );
    },
  );
}

Widget _buildBillRow(String label, String value, {bool isBold = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            )),
        Text(value,
            style: TextStyle(
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            )),
      ],
    ),
  );
}
