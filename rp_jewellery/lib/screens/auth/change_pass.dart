import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rp_jewellery/constants/constants.dart';
import 'package:rp_jewellery/screens/auth/login.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text(
              "Set new password",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            Text(
              "Your new password must be differnet from previously used passwords.",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              onSaved: (pass) {
                // Password
              },
              validator: (val) {},
              obscureText: true,
              decoration: InputDecoration(
                hintText: "New password",
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16 * 0.75),
                  child: SvgPicture.asset(
                    "assets/icons/Lock.svg",
                    height: 24,
                    width: 24,
                    colorFilter: ColorFilter.mode(
                        Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .color!
                            .withOpacity(0.3),
                        BlendMode.srcIn),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              onSaved: (pass) {
                // Password
              },
              validator: (val) {},
              obscureText: true,
              decoration: InputDecoration(
                hintText: "New password again",
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16 * 0.75),
                  child: SvgPicture.asset(
                    "assets/icons/Lock.svg",
                    height: 24,
                    width: 24,
                    colorFilter: ColorFilter.mode(
                        Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .color!
                            .withOpacity(0.3),
                        BlendMode.srcIn),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                },
                child: const Text("Change Password"))
          ],
        ),
      ),
    );
  }
}
