import 'package:flutter/material.dart';
import 'package:gemini/core/widgets/spacing/whitspacing.dart';
import 'package:gemini/core/widgets/widgets/default_button.dart';
import 'package:gemini/core/widgets/widgets/default_textfield.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:Column(
       children: [

      
        const DefaultTextfield(
          isTextAndImage: false,
          hintText: "Enter Name or Email",
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
          label:"Signin"
          
        ),

      ])
    );
  }
}