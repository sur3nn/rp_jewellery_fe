import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rp_jewellery/business_logic/signup_bloc/signup_bloc.dart';
import 'package:rp_jewellery/constants/constants.dart';
import 'package:rp_jewellery/validations/validator.dart';

class SignUp extends StatelessWidget {
  SignUp({super.key});
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameCtlr = TextEditingController();
  final TextEditingController emailCtlr = TextEditingController();
  final TextEditingController passCtlr = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is SignupSucess) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.data.message ?? "Something Went Wrong")));
          Navigator.pop(context);
        } else if (state is SignupFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error.message ?? "Something Went Wrong")));
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  "assets/images/kayadu-lohar.webp",
                  height: MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Let’s get started!",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: defaultPadding / 2),
                    const Text(
                      "Please enter your valid data in order to create an account.",
                    ),
                    const SizedBox(height: defaultPadding),
                    SignUpForm(
                      formKey: formKey,
                      emailCtlr: emailCtlr,
                      nameCtlr: nameCtlr,
                      passCtlr: passCtlr,
                    ),
                    const SizedBox(height: defaultPadding),
                    // Row(
                    //   children: [
                    //     Checkbox(
                    //       onChanged: (value) {},
                    //       value: false,
                    //     ),
                    //     const Expanded(
                    //       child: Text.rich(
                    //         TextSpan(
                    //           text: "I agree with the",
                    //           children: [
                    //             TextSpan(
                    //               // recognizer: TapGestureRecognizer()
                    //               //   ..onTap = () {
                    //               //     Navigator.pushNamed(
                    //               //         context, termsOfServicesScreenRoute);
                    //               // },
                    //               text: " Terms of service ",
                    //               style: TextStyle(
                    //                 color: primaryColor,
                    //                 fontWeight: FontWeight.w500,
                    //               ),
                    //             ),
                    //             TextSpan(
                    //               text: "& privacy policy.",
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // ),
                    const SizedBox(height: 16 * 2),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState?.validate() == true) {
                          context.read<SignupBloc>().add(StartSignup(
                              name: nameCtlr.text.trim(),
                              email: emailCtlr.text.trim(),
                              pass: passCtlr.text.trim()));
                        }
                      },
                      child: const Text("Continue"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Do you have an account?"),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Log in"),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameCtlr;
  final TextEditingController emailCtlr;
  final TextEditingController passCtlr;
  const SignUpForm(
      {super.key,
      required this.formKey,
      required this.nameCtlr,
      required this.emailCtlr,
      required this.passCtlr});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: nameCtlr,
            onSaved: (name) {
              // Email
            },
            validator: Validator.empty,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Name",
              prefixIcon: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
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
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          TextFormField(
            controller: emailCtlr,
            onSaved: (emal) {
              // Email
            },
            validator: Validator.email,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              hintText: "Email address",
              prefixIcon: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
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
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          TextFormField(
            controller: passCtlr,
            onSaved: (pass) {
              // Password
            },
            validator: Validator.password,
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Password",
              prefixIcon: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: defaultPadding * 0.75),
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
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
