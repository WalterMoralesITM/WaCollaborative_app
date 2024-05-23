import 'package:flutter/material.dart';

class CustomIconButtonReturn extends StatelessWidget{
  final VoidCallback? onPressed;

  const CustomIconButtonReturn({
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onPressed,
        icon: const Icon(
            Icons.arrow_back
        )
    );
  }
}