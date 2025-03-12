import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:rp_jewellery/constants/constants.dart';
import 'package:rp_jewellery/screens/auth/change_pass.dart';

class EnterOTP extends StatelessWidget {
  final String email;
  final TextEditingController code = TextEditingController();
  EnterOTP({super.key, required this.email});

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
          children: [
            Text(
              "Verification code",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(
              height: defaultPadding,
            ),
            Text(
              "We have sent the verification code to ${email.substring(1, 3)}*******${email.substring(email.indexOf("."), email.length)}",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            Pinput(
              controller: code,
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                    child: OutlinedButton(
                        onPressed: () {}, child: const Text("Resend"))),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ChangePassword()));
                        },
                        child: const Text("Confirm")))
              ],
            )
          ],
        ),
      ),
    );
  }
}
