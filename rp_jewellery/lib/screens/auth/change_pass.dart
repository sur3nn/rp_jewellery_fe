import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rp_jewellery/business_logic/change_pass_bloc/change_pass_bloc.dart';
import 'package:rp_jewellery/constants/constants.dart';
import 'package:rp_jewellery/screens/auth/login.dart';
import 'package:rp_jewellery/validations/validator.dart';

class ChangePassword extends StatelessWidget {
  final String email;
  const ChangePassword({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final TextEditingController passctlr = TextEditingController();
    return BlocListener<ChangePassBloc, ChangePassState>(
      listener: (context, state) {
        if (state is ChangePassSucess) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.data.message ?? "Something Went Wrong")));
        } else if (state is ChangePassFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.data.message ?? "Something Went Wrong")));
        }
      },
      child: Scaffold(
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
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: passctlr,
                      onSaved: (pass) {
                        // Password
                      },
                      validator: Validator.password,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "New password",
                        prefixIcon: Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: 16 * 0.75),
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
                      validator: (value) {
                        return Validator.confirmPass(passctlr.text, value);
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "New password again",
                        prefixIcon: Padding(
                          padding:
                              const EdgeInsets.symmetric(vertical: 16 * 0.75),
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
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState?.validate() == true) {
                      context.read<ChangePassBloc>().add(
                          ChangeUserPass(email: email, pass: passctlr.text));
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Login(),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    }
                  },
                  child: const Text("Change Password"))
            ],
          ),
        ),
      ),
    );
  }
}
