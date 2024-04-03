import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini/core/size/sizes.dart';
import 'package:gemini/core/widgets/spacing/whitspacing.dart';
import 'package:gemini/core/widgets/widgets/default_button.dart';
import 'package:gemini/core/widgets/widgets/default_textfield.dart';
import 'package:gemini/locator.dart';
import 'package:gemini/src/authentication/presentation/bloc/user_bloc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final userBloc = sl<UserBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding:  EdgeInsets.symmetric(
          horizontal: Sizes().width(context, 0.04)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
                const DefaultTextfield(
            isTextAndImage: false, hintText: "Enter Name", label: "UserName"),
                Space().height(context, 0.02),
                const DefaultTextfield(
            isTextAndImage: false, hintText: "Enter Email", label: "UserName"),
                Space().height(context, 0.02),
                const DefaultTextfield(
            isTextAndImage: false, hintText: "Enter Password", label: "UserName"),
                Space().height(context, 0.02),
                BlocConsumer(
          bloc: userBloc,
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return DefaultButton(onTap: () {}, label: "Signup");
          },
                ),
              ]),
        ));
  }
}
