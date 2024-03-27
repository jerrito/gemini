import 'package:flutter/material.dart';
import 'package:gemini/core/widgets/spacing/whitspacing.dart';
import 'package:gemini/core/widgets/widgets/default_button.dart';
import 'package:gemini/core/widgets/widgets/default_textfield.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:Column(
       children: [

      
        const DefaultTextfield(
          isTextAndImage: false,
          hintText: "Enter Name",
          label:"UserName"
        ),
        Space().height(context,0.02),
         const DefaultTextfield(
          isTextAndImage: false,
          hintText: "Enter Email",
          label:"UserName"
        ),
            

        Space().height(context,0.02),

         const DefaultTextfield(
          isTextAndImage: false,
          hintText: "Enter Password",
          label:"UserName"
        ),
        
        Space().height(context,0.02),

        DefaultButton(
          onTap:(){},
          label:"Signup"
          
        ),

      ])
    );
  }
}