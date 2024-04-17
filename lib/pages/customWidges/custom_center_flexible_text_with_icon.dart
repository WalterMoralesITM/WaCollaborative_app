import 'package:flutter/material.dart';

class CustomCenterFlexibleTextWithIcon extends StatelessWidget{

  final String textValue;
  final IconData? iconData;
  final double sizeText;

  CustomCenterFlexibleTextWithIcon({
      required this.textValue,
      this.iconData,
     required this.sizeText,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Icon(iconData),
          SizedBox(width: 10), // Espacio entre el icono y el texto
          Flexible(
            child:
            Text(
                textValue,
                style: TextStyle(fontSize: sizeText)
            ),
          ),
        ],
      ),
    );
  }
}