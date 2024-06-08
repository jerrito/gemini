import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini/locator.dart';
import 'package:gemini/src/authentication/presentation/bloc/auth_bloc.dart';
import 'package:gemini/src/authentication/presentation/pages/landing_page.dart';
import 'package:gemini/src/authentication/presentation/provider/user_provider.dart';
import 'package:gemini/src/search_text/presentation/pages/search_page.dart';
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
          print(state.token);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const SearchTextPage()),
          // );
          final Map<String, dynamic> params = {"token": state.token};
          userBloc.add(
            GetUserEvent(params: params),
          );
        }
        if (state is GetUserLoaded) {
          final Map<String, dynamic> params = {"user": state.user};
          userBloc.add(CacheUserDataEvent(params: params));
        }
        if (state is CacheUserDataLoaded) {
          context.goNamed("home");
        }
        if ( state is GetTokenError) {
          print(state.errorMessage);
          context.goNamed("landing");
        }
        if (state is GetUserCacheDataError) {
          print(state.errorMessage);
          context.goNamed("signin");
        }

        // if (state is GetUserFromTokenLoaded) {
        //   if (!context.mounted) return;
        //   var userProvider = Provider.of<UserProvider>(context, listen: false);
        //   userProvider.setUser(state.user);
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(builder: (context) => const SearchTextPage()),
        //   );
        // }
      },
      builder: (BuildContext context, Object? state) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    ));
  }
}
