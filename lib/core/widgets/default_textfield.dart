// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:gemini/core/size/sizes.dart';
import 'package:gemini/core/spacing/whitspacing.dart';

class DefaultTextfield extends StatefulWidget {
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final void Function()? onTap;
  final void Function()? onPressed;
  final TextEditingController? controller;
  final String? hintText, initialValue, errorText, label;
  final double? height;
  final bool? enabled;
  final bool isTextAndImage;
  final TextInputType? textInputType;
  const DefaultTextfield({
    super.key,
    this.onChanged,
    this.controller,
    this.hintText,
    this.textInputType,
    this.errorText,
    this.height,
    this.label,
    this.initialValue,
    this.enabled,
    required this.isTextAndImage,
    this.onTap,
    this.onPressed,
    this.validator,
  });

  @override
  State<DefaultTextfield> createState() => _DefaultTextfieldState();
}

class _DefaultTextfieldState extends State<DefaultTextfield> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:widget.label == null? Sizes().height(context, 0.085):
      Sizes().height(context, 0.090),
      child:
      Column(
       // mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(widget.label != null)
          Text(widget.label!),
          Space().height(context, 0.01),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: widget.validator,
            enabled: widget.enabled,
            initialValue: widget.initialValue,
            keyboardType: widget.textInputType,
            controller: widget.controller,
            onChanged: widget.onChanged,
            decoration: InputDecoration(
                    errorStyle:null,
              isDense: true,
              errorText: widget.errorText,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              hintText: widget.hintText,
              hintStyle: const TextStyle(color: Colors.grey),
              //label: Text(label!),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Sizes().height(context, 0.04)),
                borderSide: BorderSide(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Color.fromARGB(255, 233, 225, 225)
                      : Color.fromARGB(255, 18, 17, 17),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Sizes().height(context, 0.04)),
                borderSide: BorderSide(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Sizes().height(context, 0.04)),
                borderSide:  BorderSide(color:Theme.of(context).brightness==Brightness.dark?Colors.white: Colors.black),
              ),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Sizes().height(context, 0.04)),
                borderSide:  BorderSide(color:Theme.of(context).brightness==Brightness.dark?Colors.white: Colors.black),
              ),
            )),
        ],
      ));
  }
}

class DefaultTextArea extends StatelessWidget {
  final void Function(String?)? onChanged;
  final void Function(PointerDownEvent)? onTapOutSide;
  final TextEditingController? controller;
  final String? hintText, initialValue, errorText, label;
  final double? height;
  final TextInputType? textInputType;
  final FocusNode? focusNode;
  const DefaultTextArea({
    super.key,
    this.onChanged,
    this.controller,
    this.hintText,
    this.errorText,
    this.label,
    this.height,
    this.textInputType,
    this.focusNode,
    this.onTapOutSide,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label ?? ""),
        Space().height(context, 0.004),
        SizedBox(
          height: 100,
          width: double.infinity,
          child: TextFormField(
            focusNode: focusNode,
            initialValue: initialValue,
            expands: true,
            maxLines: null,
            minLines: null,
            keyboardType: textInputType,
            controller: controller,
            onChanged: onChanged,
            onTapOutside: onTapOutSide,
            decoration: InputDecoration(
              isDense: true,
              errorText: errorText,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey),
              //label: Text(label!),
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(Sizes().height(context, 0.01)),
                borderSide: const BorderSide(color: Colors.black26),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(Sizes().height(context, 0.01)),
                borderSide: const BorderSide(color: Colors.black26),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(Sizes().height(context, 0.01)),
                borderSide: const BorderSide(color: Colors.red),
              ),
            ),
          ),
        ),
        Space().height(context, 0.02)
      ],
    );
  }
}
