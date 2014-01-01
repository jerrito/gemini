import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini/locator.dart';
import 'package:gemini/src/authentication/presentation/bloc/user_bloc.dart';
import 'package:gemini/src/authentication/presentation/pages/landing_page.dart';
import 'package:gemini/src/authentication/presentation/provider/user_provider.dart';
import 'package:gemini/src/search_text/presentation/pages/search_page.dart';
import 'package:provider/provider.dart';

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({super.key});

  @override
  State<ConnectionPage> createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  final userBloc = sl<UserBloc>();
  @override
  void initState() {
    super.initState();
    userBloc.add(
      ConfirmTokenEvent(params: {}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer(
      bloc: userBloc,
      listener: (context, state) {
        if (state is ConfirmTokenLoaded) {
          print(state.confirm);
          userBloc.add(GetUserFromTokenEvent(params: {}));
        }
        if (state is ConfirmTokenError) {
          print(state.errorMessage);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SearchTextPage()),
          );
        }
        if (state is GetUserFromTokenError) {
          print(state.errorMessage);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LandingPage()),
          );
        }
        if (state is GetUserFromTokenLoaded) {
          if (!context.mounted) return;
          var userProvider = Provider.of<UserProvider>(context, listen: false);
          userProvider.setUser(state.user);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SearchTextPage()),
          );
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
