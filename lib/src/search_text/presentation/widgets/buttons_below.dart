import 'package:flutter/material.dart';

class ButtonsBelowResult extends StatelessWidget {
  final void Function()? onCopy;
  final void Function()? onRetry;
  const ButtonsBelowResult({super.key, this.onCopy, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment:MainAxisAlignment.center,
      children: [
      IconButton(icon:const Icon(Icons.copy), onPressed: onCopy),
      IconButton(icon:const Icon(Icons.refresh), onPressed: onRetry),
    ]);
  }
}
