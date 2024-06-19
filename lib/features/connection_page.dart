import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini/locator.dart';
import 'package:gemini/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:gemini/features/authentication/presentation/pages/landing_page.dart';
import 'package:gemini/features/authentication/presentation/provider/user_provider.dart';
import 'package:gemini/features/search_text/presentation/pages/search_page.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({super.key});

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  final userBloc = sl<AuthenticationBloc>();
  @override
  void initState() {
    super.initState();
    userBloc.add(
      GetTokenEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer(
      bloc: userBloc,
      listener: (context, state) {
        if (state is GetTokenLoaded) {
          final Map<String, dynamic> params = {"token": state.token.accessToken};
          userBloc.add(
            GetUserEvent(params: params),
          );
        }
        if (state is GetUserLoaded) {
          final user=state.user;

          final Map<String, dynamic> params = {
            "userName": user.userName,
            "email":user.email};
          userBloc.add(CacheUserDataEvent(params: params));
        }
        if (state is CacheUserDataLoaded) {
          context.goNamed("searchPage");
        }
        if(state is GetUserError){
          context.goNamed("signin"); 
        }
        if ( state is GetTokenError) {
          context.goNamed("landing");
        }
        if (state is GetUserCacheDataError) {
          context.goNamed("signin");
        }
      },
      builder: (BuildContext context, Object? state) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }
}
