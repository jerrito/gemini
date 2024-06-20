import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini/core/size/sizes.dart';
import 'package:gemini/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:gemini/features/search_text/presentation/widgets/show_error.dart';
import 'package:gemini/locator.dart';
import 'package:go_router/go_router.dart';

class UserProfile extends StatefulWidget {
  
  const UserProfile({super.key,});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final authBloc=sl<AuthenticationBloc>();
   String? token;

  @override
  Widget build(BuildContext context) {
    authBloc.add(GetTokenEvent());
    return Scaffold(
      
      body: BlocListener(
        bloc:authBloc,
        listener: (context, state) {
          if(state is LogoutLoaded){
            final data=jsonDecode(state.successMessage);

             if(!context.mounted)return;
              showSnackbar(isSuccessMessage: true, context: context,message: data["message"]);
            context.goNamed("landing");
            }
            if(state is GetTokenLoaded){
              token=state.authorization["token"];
              setState((){});
            }
            if(state is GetTokenError){

            }
            if(state is LogoutError){
              if(!context.mounted)return;
              showSnackbar(context: context,message: state.errorMessage);
            }
        },
        child: Column(
              children: [

                CircleAvatar(
                  backgroundImage:Image.network("").image ,
                  radius: Sizes().height(context, 0.08),
                ),
            
                GestureDetector(
                  onTap:(){
                    final Map<String, dynamic> params={
                      "token":token
                    };
                 authBloc.add(LogoutEvent(params: params));
                  },
                  child: const Text("Logout"),
                )
              ],
            ),
      ),
    );
  }
}