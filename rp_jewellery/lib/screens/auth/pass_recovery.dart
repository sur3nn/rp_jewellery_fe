import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rp_jewellery/constants/constants.dart';
import 'package:rp_jewellery/screens/auth/enter_otp.dart';
import 'package:rp_jewellery/screens/auth/login.dart';
import 'package:rp_jewellery/validations/validator.dart';

class PassRecovery extends StatelessWidget {
  PassRecovery({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();

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
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Password recovery",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            Text(
              "Enter your E-mail address to recover your password",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            Form(
              key: _formKey,
              child: TextFormField(
                validator: Validator.email,
                controller: email,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Email address",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16 * 0.75),
                    child: SvgPicture.asset(
                      "assets/icons/Message.svg",
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
            ),
            const SizedBox(
              height: 100,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EnterOTP(email: email.text)));
                }
              },
              child: const Text("Next"),
            ),
          ],
        ),
      ),
    );
  }
}
