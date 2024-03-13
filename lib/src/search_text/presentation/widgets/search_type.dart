import 'package:flutter/material.dart';

class SearchTypeWidget extends StatelessWidget {
  final String? label;
  final void Function()? onPressed;
  const SearchTypeWidget({
    super.key,
    this.label,
    this.onPressed,
  });

  @override
  build(BuildContext context) {
    return TextButton(
      onPressed:onPressed,
      child: Text(label ?? ""),
    );
  }
}
