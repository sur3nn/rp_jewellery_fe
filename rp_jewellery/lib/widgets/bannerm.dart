import 'package:flutter/material.dart';
import 'package:rp_jewellery/widgets/network_loader.dart';

class BannerM extends StatelessWidget {
  const BannerM(
      {super.key,
      required this.image,
      required this.press,
      required this.children});

  final String image;
  final VoidCallback press;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.87,
      child: GestureDetector(
        onTap: press,
        child: Stack(
          children: [
            // NetworkImageWithLoader(image, radius: 0),
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'assets/icons/adv1.webp',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Container(color: Colors.black45),
            // ...children,
          ],
        ),
      ),
    );
  }
}
