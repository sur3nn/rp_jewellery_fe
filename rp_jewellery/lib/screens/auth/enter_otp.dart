import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:rp_jewellery/business_logic/forgot_pass_bloc/forgot_pass_bloc.dart';
import 'package:rp_jewellery/business_logic/pass_otp_verify_bloc/pass_otp_verify_bloc.dart';
import 'package:rp_jewellery/business_logic/user_otp_verify_bloc/user_otp_verify_bloc.dart';
import 'package:rp_jewellery/constants/constants.dart';
import 'package:rp_jewellery/screens/auth/change_pass.dart';
import 'package:rp_jewellery/screens/bottom_navigation/bottom_navigation.dart';

class EnterOTP extends StatelessWidget {
  final String email;
  final String from;
  final TextEditingController code = TextEditingController();
  EnterOTP({super.key, required this.email, required this.from});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<UserOtpVerifyBloc, UserOtpVerifyState>(
          listener: (context, state) {
            if (state is UserOtpVerifySucess) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.data.message ?? "Something Went Wrong")));

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BottomNavigation()));
            } else if (state is UserOtpVerifyFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.data.message ?? "Something Went Wrong")));
            }
          },
        ),
        BlocListener<PassOtpVerifyBloc, PassOtpVerifyState>(
          listener: (context, state) {
            if (state is PassOtpVerifySucess) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.data.message ?? "Something Went Wrong")));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangePassword(
                            email: email,
                          )));
            } else if (state is PassOtpVerifyFailure) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(state.data.message ?? "Something Went Wrong")));
            }
          },
        )
      ],
      child: Scaffold(
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
                          onPressed: () {
                            context
                                .read<ForgotPassBloc>()
                                .add(SendMailEvent(email: email));
                          },
                          child: const Text("Resend"))),
                  const SizedBox(
                    width: 30,
                  ),
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            if (from == "login") {
                              context
                                  .read<UserOtpVerifyBloc>()
                                  .add(VerifyOtp(email: email, otp: code.text));
                            } else if (from == "forgot_password") {
                              context.read<PassOtpVerifyBloc>().add(
                                  VerifyPassOtp(email: email, otp: code.text));
                            }
                          },
                          child: const Text("Confirm")))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
