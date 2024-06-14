import 'package:flutter/widgets.dart';
import 'package:gemini/features/search_text/presentation/bloc/search_bloc.dart';
import 'package:gemini/features/search_text/presentation/widgets/buttons_below.dart';
import 'package:share_plus/share_plus.dart';

class DataAdd extends StatelessWidget {
  final String? title, data, images;
  final SearchBloc searchBloc;
  const DataAdd(
      {super.key,
      this.title,
      this.data,
      this.images,
      required this.searchBloc});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            // color: Color( Colors.)
          ),
          child: Text(title ?? "")),
        if (images != null) Image.asset(images!),
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
