import 'package:flutter/material.dart';
import 'package:gemini/core/size/sizes.dart';
import 'package:gemini/core/widgets/default_textfield.dart';

class BottomSheetTextfield extends StatefulWidget {
  final void Function()? onTap;
  final void Function()? onPressed;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String? hintText;
  final String? errorText;
  final bool isTextAndImage;
  const BottomSheetTextfield({
    super.key,
    this.onTap,
    this.onPressed,
    this.onChanged,
    this.validator,
    this.controller,
    this.hintText,
    this.errorText,
    required this.isTextAndImage,
  });

  @override
  State<BottomSheetTextfield> createState() => _BottomSheetTextFieldState();
}

class _BottomSheetTextFieldState extends State<BottomSheetTextfield> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).brightness != Brightness.dark
          ? Colors.white
          : Colors.black,
      padding: EdgeInsets.symmetric(
        horizontal: Sizes().width(context, 0.02),
        vertical: Sizes().height(context, 0.025),
      ),
      child: SizedBox(
        width: double.infinity,
        child: DefaultTextfield(
          validator: widget.validator,
          errorText: widget.errorText,
          onChanged: widget.onChanged,
          controller: widget.controller,
          hintText: widget.hintText ?? "Message Jerrito  AI",
          onTap: widget.onTap,
          isTextAndImage: widget.isTextAndImage,
          onPressed: widget.onPressed,
        ),
      ),
    );
  }
}
