import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini/core/size/sizes.dart';
import 'package:gemini/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:gemini/features/search_text/presentation/widgets/show_snack.dart';
import 'package:gemini/locator.dart';
import 'package:go_router/go_router.dart';

class UserProfile extends StatefulWidget {
  
  const UserProfile({super.key,});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final authBloc=sl<AuthenticationBloc>();
   String? token, successMessage;
@override
void initState(){
  super.initState();
    authBloc.add(GetTokenEvent());
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: BlocListener(
        bloc:authBloc,
        listener: (context, state) {
          if(state is LogoutLoaded){
            final data=state.successMessage;
            successMessage=data;
            setState((){});
            final Map<String,dynamic> params={
              "token":null,
              "refreshToken":null
            };
            authBloc.add(CacheTokenEvent(authorization: params,),);
            }
            if(state is CacheTokenError){
               if(!context.mounted)return;
              showSnackbar(context: context,message: state.errorMessage);
            }
            if(state is CacheTokenLoaded){             
             if(!context.mounted)return;
              showSnackbar(isSuccessMessage: true, context: context,message: successMessage!);
            
            context.goNamed("landing");
            }
            if(state is GetTokenLoaded){
              token=state.authorization["token"];
              print(token);
              setState((){});
            }
            if(state is GetTokenError){
              if(!context.mounted)return;
              showSnackbar(context: context,message: state.errorMessage);

            }
            if(state is LogoutError){
               if(!context.mounted)return;
              showSnackbar(context: context,message: state.errorMessage);
            }
        },
        child: Column(
          mainAxisAlignment:MainAxisAlignment.center,
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