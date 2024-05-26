import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini/core/size/sizes.dart';
import 'package:gemini/core/widgets/spacing/whitspacing.dart';
import 'package:gemini/core/widgets/widgets/default_button.dart';
import 'package:gemini/core/widgets/widgets/default_textfield.dart';
import 'package:gemini/locator.dart';
import 'package:gemini/src/authentication/presentation/bloc/user_bloc.dart';
import 'package:gemini/src/search_text/presentation/widgets/show_error.dart';
import 'package:go_router/go_router.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final userBloc = sl<UserBloc>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Signup")),
        bottomSheet: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Sizes().height(context, 0.01),
              vertical: Sizes().height(context, 0.02)),
          child: BlocConsumer(
            bloc: userBloc,
            listener: (context, state) {
              if (state is SignupError) {
                if (!context.mounted) return;
                showErrorSnackbar(context, state.errorMessage);
              }

              if (state is CacheUserDataError) {
                if (!context.mounted) return;
                showErrorSnackbar(context, state.errorMessage);
              }
              if (state is CacheUserDataLoaded) {
                context.goNamed("searchPage");
              }
              if (state is SignupLoaded) {
                userBloc.add(
                  CacheUserDataEvent(
                    params: {
                      "userName": nameController.text,
                      "email": emailController.text,
                      "password": null,
                    },
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is SignupLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return DefaultButton(
                  onTap: () {
                    final Map<String, dynamic> params = {
                      "email": emailController.text,
                      "password": passwordController.text,
                      "userName": nameController.text,
                    };
                    userBloc.add(
                        CreateUserWithEmailAndPasswordEvent(params: params));
                  },
                  label: "Signup");
            },
          ),
        ),
        body: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: Sizes().width(context, 0.04)),
          child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Space().height(context, 0.03),
                DefaultTextfield(
                  controller: nameController,
                  isTextAndImage: false,
                  hintText: "Enter Username",
                  label: "UserName",
                ),
                Space().height(context, 0.02),
                DefaultTextfield(
                  controller: emailController,
                  isTextAndImage: false,
                  hintText: "Enter Email",
                  label: "Email",
                ),
                Space().height(context, 0.02),
                DefaultTextfield(
                  controller: passwordController,
                  isTextAndImage: false,
                  hintText: "Enter Password",
                  label: "Password",
                ),
                Space().height(context, 0.02),
              ]),
        ));
  }
}
