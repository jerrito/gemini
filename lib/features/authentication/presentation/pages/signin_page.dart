import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini/core/size/sizes.dart';
import 'package:gemini/core/spacing/whitspacing.dart';
import 'package:gemini/core/widgets/default_button.dart';
import 'package:gemini/core/widgets/default_textfield.dart';
import 'package:gemini/locator.dart';
import 'package:gemini/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:gemini/features/search_text/presentation/widgets/show_error.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/authorization_model.dart';

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
      appBar: AppBar(title: const Text("Signin")),
      bottomSheet:  Padding(
         padding: EdgeInsets.symmetric(
              horizontal: Sizes().height(context, 0.01),
              vertical: Sizes().height(context, 0.02)),
        child: BlocConsumer(
                bloc: userBloc,
                listener: (context, state) {
                  if (state is SigninLoaded) {
                    final user = state.data.user;
                    final authorization = state.data.authorization;
                    userBloc.add(CacheUserDataEvent(
                      params: {
                        "userName": user.userName,
                        "email": user.email,
                      },
                    ));
                    userBloc.add(
                      CacheTokenEvent(
                        authorization: AuthorizationModel.fromJson(authorization.toMap()),
                      ),
                    );
                  }
                  if(state is CacheTokenLoaded){
                    context.goNamed("searchPage");
                  }
                  if(state is CacheTokenError){
                    if(!context.mounted) return;
                    showErrorSnackbar(context, state.errorMessage);
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
                        print(params);
                        userBloc.add(SigninEvent(params: params));
                      },
                      label: "Signin");
                },
              ),
      ),
        body: Padding(
      padding: EdgeInsets.symmetric(horizontal: Sizes().width(context, 0.04)),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             DefaultTextArea(
              controller:emailController,
                hintText: "Enter Name or Email",
                label: "UserName/Email"),
            Space().height(context, 0.02),
            DefaultTextArea(
              controller: passwordController,
                hintText: "Enter Password",
                label: "Password"),
            Space().height(context, 0.02),
           
          ]),
    ));
  }
}
