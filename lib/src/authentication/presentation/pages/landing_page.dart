import 'package:flutter/material.dart';
import 'package:gemini/core/widgets/widgets/default_button.dart';
import 'package:gemini/src/authentication/presentation/pages/signin_page.dart';
import 'package:gemini/src/authentication/presentation/pages/signup_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          DefaultButton(
            onTap: (){
              Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SigninPage()),
          );
            },
            label: "Signup",
          ),
          DefaultButton(
            onTap: (){
              Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SignupPage()),
          );
            },
            label: "Signin",
          ),
        ],
      ),
    );
  }
}