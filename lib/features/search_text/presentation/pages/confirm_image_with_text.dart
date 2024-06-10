import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:gemini/core/size/sizes.dart';
import 'package:gemini/core/widgets/spacing/whitspacing.dart';
import 'package:gemini/core/widgets/widgets/bottom_sheet.dart';
import 'package:gemini/locator.dart';
import 'package:gemini/features/search_text/presentation/bloc/search_bloc.dart';

class ConfirmImageWithTextPage extends StatefulWidget {
  final List<Uint8List> all;
  final String? textData;
  const ConfirmImageWithTextPage({super.key, required this.all, this.textData});

  @override
  State<ConfirmImageWithTextPage> createState() =>
      _ConfirmImageWithTextPageState();
}

class _ConfirmImageWithTextPageState extends State<ConfirmImageWithTextPage> {
  final controller = TextEditingController();
  final searchBloc = sl<SearchBloc>();
  final form = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controller.text = widget.textData ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  key: form,
      bottomSheet: Form(
        key:form,
        child: BottomSheetTextfield(
            controller: controller,
            hintText: "Add a caption",
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return "";
              }
              return null;
            },
            onTap: () {},
            onPressed: () {
              if (form.currentState?.validate() == true) {
                Map<String, dynamic> paramsWithImage = {
                  "text": controller.text,
                  "images": widget.all
                };
                Navigator.pop(context, paramsWithImage);
              }
            },
            isTextAndImage: false),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      icon: const Icon(Icons.cancel),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ],
              ),
              Space().height(context, 0.02),
              if (widget.all.isNotEmpty)
                Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(widget.all.length, (index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: Sizes().height(context, 0.02)),
                        child: Image.memory(
                          widget.all[index],
                          height: Sizes().height(context, 0.6),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      );
                    })),
            ],
          ),
        ),
      ),
    );
  }
}
