import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rp_jewellery/business_logic/all_products_bloc/all_products_bloc.dart';
import 'package:rp_jewellery/business_logic/filter_cubit/filter_cubit.dart';
import 'package:rp_jewellery/business_logic/product_category_bloc/product_category_bloc.dart';
import 'package:rp_jewellery/constants/constants.dart';
import 'package:rp_jewellery/main.dart';
import 'package:rp_jewellery/model/cart_model.dart';
import 'package:rp_jewellery/screens/admin/add_announcement.dart';
import 'package:rp_jewellery/screens/admin/add_product.dart';
import 'package:rp_jewellery/screens/admin/add_schemes.dart';
import 'package:rp_jewellery/screens/all_products/cart.dart';
import 'package:rp_jewellery/screens/all_products/orders.dart';

import 'package:rp_jewellery/screens/all_products/product_list.dart';
import 'package:rp_jewellery/screens/auth/login.dart';
import 'package:rp_jewellery/screens/home_screen/home_screen.dart';
import 'package:rp_jewellery/screens/schemes/schemes.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SortOption { highToLow, lowToHigh, defaultPrice }

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
                (!widget.isAdmin && _currentIndex == 1)
                    ? IconButton(
                        onPressed: () {
                          _scaffoldKey.currentState?.openEndDrawer();
                        },
                        icon: Icon(
                          Icons.filter_list,
                          size: 24,
                          color: Theme.of(context).textTheme.bodyLarge!.color!,
                        ),
                      )
                    : SizedBox(),
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => CartScreen()));
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
      endDrawer: (!widget.isAdmin && _currentIndex == 1)
          ? Drawer(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              // backgroundColor: Color.fromRGBO(247, 243, 243, 1),
              width: MediaQuery.of(context).size.width / 1.5,
              child: BlocBuilder<FilterCubit, SortOption>(
                builder: (context, state) {
                  return Column(
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Text("Filters"),
                      SizedBox(height: 10),
                      RadioListTile<SortOption>(
                        title: const Text("High to Low"),
                        value: SortOption.highToLow,
                        groupValue: state,
                        onChanged: (value) {
                          context.read<FilterCubit>().setData(value!);
                          context
                              .read<AllProductsBloc>()
                              .add(StartGetProducts(id: 0, filter: "high"));
                          Navigator.pop(context);
                        },
                      ),
                      RadioListTile<SortOption>(
                        title: const Text("Low to High"),
                        value: SortOption.lowToHigh,
                        groupValue: state,
                        onChanged: (value) {
                          context.read<FilterCubit>().setData(value!);
                          context
                              .read<AllProductsBloc>()
                              .add(StartGetProducts(id: 0, filter: "low"));

                          Navigator.pop(context);
                        },
                      ),
                    ],
                  );
                },
              ),
            )
          : SizedBox(),
      drawer: widget.isAdmin
          ? SizedBox()
          : Drawer(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              // backgroundColor: Color.fromRGBO(247, 243, 243, 1),
              width: MediaQuery.of(context).size.width / 1.5,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 100,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                alignment: Alignment.centerLeft,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(15)),
                                    color: Color.fromARGB(100, 232, 9, 9)),
                                width: MediaQuery.of(context).size.width / 1.5,
                                child: Row(
                                  children: [
                                    FutureBuilder<String>(
                                        future: getInitial(),
                                        builder: (context, snap) {
                                          return CircleAvatar(
                                            radius: 20,
                                            backgroundColor: whiteColor,
                                            child: Text(
                                              snap.data ?? " - ",
                                              style: const TextTheme()
                                                  .headlineLarge,
                                            ),
                                          );
                                        }),
                                    const SizedBox(width: 20),
                                    FutureBuilder<String>(
                                        future: getName(),
                                        builder: (context, snap) {
                                          return Text(snap.data ?? " - ",
                                              style: TextStyle(
                                                  color: whiteColor,
                                                  fontSize: 18));
                                        }),
                                  ],
                                ),
                              ),
                              ListTile(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyOrders()));
                                },
                                tileColor: whiteColor,
                                title: Text("My Orders"),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    BlocBuilder<ProductCategoryBloc,
                                        ProductCategoryState>(
                                      builder: (context, state) {
                                        if (state is ProductCategorySuccess) {
                                          return ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount:
                                                  state.data.data?.length ?? 0,
                                              itemBuilder: (context, index) {
                                                final data =
                                                    state.data.data?[index];
                                                return Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 10.0),
                                                  child: ExpansionTile(
                                                      shape: const Border
                                                          .fromBorderSide(
                                                          BorderSide.none),
                                                      dense: true,
                                                      title: Text(
                                                        data?.materialName ??
                                                            "",
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800),
                                                      ),
                                                      children: List.generate(
                                                          data?.productDetails
                                                                  ?.length ??
                                                              0,
                                                          (index) => ListTile(
                                                                onTap: () {
                                                                  context
                                                                      .read<
                                                                          AllProductsBloc>()
                                                                      .add(StartGetProducts(
                                                                          id: data!
                                                                              .productDetails![index]
                                                                              .productMaterialId!));
                                                                  setState(() {
                                                                    _currentIndex =
                                                                        1;
                                                                  });
                                                                },
                                                                title: Text(data
                                                                        ?.productDetails?[
                                                                            index]
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
                              ListTile(
                                trailing: Icon(Icons.logout),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()));
                                },
                                tileColor: whiteColor,
                                title: Text("Logout"),
                              ),
                            ],
                          ),
                          // SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Contact Us"),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text("Email : rpjewellery1992@gmail.com"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text("Mobile : 6381776235"),
                        ),
                        Text(
                            "Location : Pannadi Complex,Oddanchatram, Dindigul"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      body: IndexedStack(
        index: _currentIndex,
        children: widget.isAdmin
            ? const [
                // const AdminAddAnnouncementScreen(),
                AdminOrderTracking(),
                AdminAddProductScreen(),
                AdminAddGoldSchemeScreen()
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

  Future<String> getInitial() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('profile') ?? "";
  }

  Future<String> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('name') ?? "";
  }
}
