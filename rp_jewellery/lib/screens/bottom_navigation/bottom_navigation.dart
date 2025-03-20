import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rp_jewellery/constants/constants.dart';

import 'package:rp_jewellery/screens/cart/add_to_cart.dart';
import 'package:rp_jewellery/screens/home_screen/home_screen.dart';
import 'package:rp_jewellery/screens/profile/profile.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
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
      appBar: AppBar(
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
            onPressed: () {},
            icon: SvgPicture.asset(
              "assets/icons/Notification.svg",
              height: 24,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).textTheme.bodyLarge!.color!,
                  BlendMode.srcIn),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        // backgroundColor: Color.fromRGBO(247, 243, 243, 1),
        width: MediaQuery.of(context).size.width / 1.5,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              ...List.generate(
                  5,
                  (index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text("Diamond"), Icon(Icons.add)],
                        ),
                      ))
            ],
          ),
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          HomePage(),

          // EmptyCartScreen(), // if Cart is empty
          AddToCart(),
          MyProfile(),
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
            BottomNavigationBarItem(
              icon: svgIcon("assets/icons/Shop.svg"),
              activeIcon: svgIcon("assets/icons/Shop.svg", color: primaryColor),
              label: "Shop",
            ),
            BottomNavigationBarItem(
              icon: svgIcon("assets/icons/Bag.svg"),
              activeIcon: svgIcon("assets/icons/Bag.svg", color: primaryColor),
              label: "Cart",
            ),
            BottomNavigationBarItem(
              icon: svgIcon("assets/icons/Profile.svg"),
              activeIcon:
                  svgIcon("assets/icons/Profile.svg", color: primaryColor),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
