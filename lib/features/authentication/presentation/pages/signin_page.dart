import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini/core/size/sizes.dart';
import 'package:gemini/core/widgets/spacing/whitspacing.dart';
import 'package:gemini/core/widgets/default_button.dart';
import 'package:gemini/core/widgets/default_textfield.dart';
import 'package:gemini/locator.dart';
import 'package:gemini/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:gemini/features/search_text/presentation/widgets/show_error.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  final userBloc = sl<AuthenticationBloc>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet:  BlocConsumer(
              bloc: userBloc,
              listener: (context, state) {
                if (state is SigninLoaded) {
                  final user = state.data.user;
                  final token = state.data.token;
                  userBloc.add(CacheUserDataEvent(
                    params: {
                      "userName": user.userName,
                      "email": user.email,
                    },
                  ));
                  userBloc.add(
                    CacheTokenEvent(
                      token: token,
                    ),
                  );
                }
                if (state is SigninError) {
                  if (!context.mounted) return;
                  showErrorSnackbar(context, state.errorMessage);
                }
              },
              builder: (context, state) {
                if (state is SigninLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return DefaultButton(
                    onTap: () {
                      final Map<String, dynamic> params = {
                        "email": emailController.text,
                        "password": passwordController.text
                      };
                      userBloc.add(SigninEvent(params: params));
                    },
                    label: "Signin");
              },
            ),
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes().width(context, 0.04)),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DefaultTextfield(
                isTextAndImage: false,
                hintText: "Enter Name or Email",
                label: "UserName"),
            Space().height(context, 0.02),
            const DefaultTextfield(
                isTextAndImage: false,
                hintText: "Enter Password",
                label: "Password"),
            Space().height(context, 0.02),
           
          ]),
    ));
  }
}
