import 'package:flutter/material.dart';
import 'package:gemini/core/size/sizes.dart';
import 'package:gemini/core/widgets/widgets/default_textfield.dart';


Widget bottomSheetTextfield({
  required BuildContext context,
  required void Function()? onTap,
  required void Function()? onPressed,
   void Function(String?)? onChanged,
   String? Function(String?)? validator,
  TextEditingController? controller, 
  String? hintText,
  String? errorText,
required  bool isTextAndImage
}) {
  return Container(
    color: Colors.white,
    padding: EdgeInsets.symmetric(
     // horizontal: Sizes().width(context, 0.02),
      vertical: Sizes().width(context, 0.02),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: Sizes().width(context, 0.75),
          child: DefaultTextfield(
            validator: validator,
            errorText:errorText ,
            onChanged: onChanged,
            controller: controller,
            hintText:hintText ?? "Message Jerrito Gemini powered AI",
           onTap: onTap,
            isTextAndImage: isTextAndImage,

          ),
        ),

        IconButton(
          onPressed:onPressed,
         icon:const Icon( Icons.send))
      ],
    ),
  );
}
