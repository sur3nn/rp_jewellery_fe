import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rp_jewellery/business_logic/all_products_bloc/all_products_bloc.dart';
import 'package:rp_jewellery/business_logic/product_category_bloc/product_category_bloc.dart';
import 'package:rp_jewellery/constants/constants.dart';
import 'package:rp_jewellery/main.dart';
import 'package:rp_jewellery/model/cart_model.dart';
import 'package:rp_jewellery/screens/admin/add_announcement.dart';
import 'package:rp_jewellery/screens/admin/add_product.dart';
import 'package:rp_jewellery/screens/admin/add_schemes.dart';
import 'package:rp_jewellery/screens/all_products/cart.dart';

import 'package:rp_jewellery/screens/all_products/product_list.dart';
import 'package:rp_jewellery/screens/home_screen/home_screen.dart';
import 'package:rp_jewellery/screens/schemes/schemes.dart';

class BottomNavigation extends StatefulWidget {
  final bool isAdmin;
  const BottomNavigation({super.key, required this.isAdmin});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  void initState() {
    super.initState();
    context.read<ProductCategoryBloc>().add(GetCategories());
    context.read<AllProductsBloc>().add(StartGetProducts(id: 0));
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    SvgPicture svgIcon(String src, {Color? color}) {
      return SvgPicture.asset(
        src,
        height: 24,
        colorFilter: ColorFilter.mode(
            color ??
                Theme.of(context).iconTheme.color!.withOpacity(
                    Theme.of(context).brightness == Brightness.dark ? 0.3 : 1),
            BlendMode.srcIn),
      );
    }

    return Scaffold(
      key: _scaffoldKey,
      appBar: widget.isAdmin
          ? null
          : AppBar(
              // pinned: true,
              // floating: true,
              // snap: true,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              leading: const SizedBox(),
              leadingWidth: 0,
              centerTitle: false,

              title: GestureDetector(
                onTap: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
                child: const Text(
                  "RP Jewellery",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                CartScreen(cartItems: cartItems)));
                  },
                  icon: SvgPicture.asset(
                    "assets/icons/Bag.svg",
                    height: 24,
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).textTheme.bodyLarge!.color!,
                        BlendMode.srcIn),
                  ),
                ),
              ],
            ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        // backgroundColor: Color.fromRGBO(247, 243, 243, 1),
        width: MediaQuery.of(context).size.width / 1.5,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 100,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15)),
                    color: Color.fromARGB(100, 232, 9, 9)),
                width: MediaQuery.of(context).size.width / 1.5,
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: whiteColor,
                      child: Text(
                        "MH",
                        style: const TextTheme().headlineLarge,
                      ),
                    ),
                    const SizedBox(width: 20),
                    const Text("Michael",
                        style: TextStyle(color: whiteColor, fontSize: 18)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    BlocBuilder<ProductCategoryBloc, ProductCategoryState>(
                      builder: (context, state) {
                        if (state is ProductCategorySuccess) {
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: state.data.data?.length ?? 0,
                              itemBuilder: (context, index) {
                                final data = state.data.data?[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: ExpansionTile(
                                      shape: const Border.fromBorderSide(
                                          BorderSide.none),
                                      dense: true,
                                      title: Text(
                                        data?.materialName ?? "",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w800),
                                      ),
                                      children: List.generate(
                                          data?.productDetails?.length ?? 0,
                                          (index) => ListTile(
                                                title: Text(data
                                                        ?.productDetails?[index]
                                                        .productName ??
                                                    ""),
                                              ))),
                                );
                              });
                        }
                        return const SizedBox();
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: widget.isAdmin
            ? [
                const AdminAddAnnouncementScreen(),
                const AdminAddProductScreen(),
                const AdminAddGoldSchemeScreen()
              ]
            : const [
                HomePage(),

                // EmptyCartScreen(), // if Cart is empty
                AddToCart(),
                GoldSchemeScreen(),
              ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: defaultPadding / 2),
        color: Theme.of(context).brightness == Brightness.light
            ? Colors.white
            : const Color(0xFF101015),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            if (index != _currentIndex) {
              setState(() {
                _currentIndex = index;
              });
            }
          },
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Colors.white
              : const Color(0xFF101015),
          type: BottomNavigationBarType.fixed,
          // selectedLabelStyle: TextStyle(color: primaryColor),
          selectedFontSize: 12,
          selectedItemColor: primaryColor,
          unselectedItemColor: Colors.transparent,
          items: [
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_max_outlined,
                  color: blackColor,
                ),
                activeIcon: Icon(Icons.home_max_outlined, color: primaryColor),
                label: "Home"),
            BottomNavigationBarItem(
              icon: svgIcon("assets/icons/Shop.svg"),
              activeIcon: svgIcon("assets/icons/Shop.svg", color: primaryColor),
              label: "Shop",
            ),
            const BottomNavigationBarItem(
              icon: Icon(
                Icons.monetization_on_outlined,
                color: blackColor,
              ),
              activeIcon: Icon(Icons.monetization_on, color: primaryColor),
              label: "Schemes",
            ),
            // BottomNavigationBarItem(
            //   icon: svgIcon("assets/icons/Profile.svg"),
            //   activeIcon:
            //       svgIcon("assets/icons/Profile.svg", color: primaryColor),
            //   label: "Profile",
            // ),
          ],
        ),
      ),
    );
  }
}
