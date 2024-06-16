import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gemini/core/size/sizes.dart';
import 'package:gemini/core/spacing/whitspacing.dart';
import 'package:gemini/features/search_text/presentation/bloc/search_bloc.dart';
import 'package:gemini/features/search_text/presentation/widgets/buttons_below.dart';
import 'package:share_plus/share_plus.dart';

class DataAdd extends StatelessWidget {
  final String? title, data;
  final List <Uint8List>? images;
  final SearchBloc searchBloc;
  const DataAdd(
      {super.key,
      this.title,
      this.data,
      this.images,
      required this.searchBloc});

  @override
  Widget build(BuildContext context) {
    final theme=Theme.of(context);
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            vertical: Sizes().height(context, .01),
            horizontal: Sizes().width(context, .01)
          ),
        
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes().height(context, 0.01)),
            color:theme.brightness==Brightness.dark?
           const Color.fromRGBO(44, 43, 43, 0.694): 
           const Color.fromRGBO(241, 217, 217, 0.678)
          ),
          child: Text(title ?? "",style:const TextStyle(
             fontSize:17,),)),
             Space().height(context, 0.04),
        if (images?.isNotEmpty  ?? false) 
        Column(
          children: List.generate(images!.length, (index) {
                          return Image.memory(images![index]);
                        }),
        ),
        Text(data ?? ""),
        ButtonsBelowResult(
            onCopy: () async {
              final Map<String, dynamic> params = {
                "text": ((title ?? "") + (data ?? "")),
              };
              searchBloc.copyText(params);
            },
            onRetry: null,
            onShare: () async {
              await Share.share(
                  ((title ?? "") + (data ?? "")));
            }),
      ],
    );
  }
}
