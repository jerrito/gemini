import 'package:flutter/material.dart';
import 'package:gemini/core/size/sizes.dart';

class SearchTypeWidget extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final Color? color;
  final void Function()? onPressed;
  const SearchTypeWidget({
    super.key,
    this.label,
    this.onPressed,
    this.icon,
    this.color,
  });

  @override
  build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(
        horizontal: Sizes().width(context, 0.05)),
      child: ListTile(
        iconColor: color,
        textColor: color,
        leading:Icon(icon) ,
        onTap: onPressed,
        title:  Text(label ?? ""),
        
      ),
    );
  }
}
