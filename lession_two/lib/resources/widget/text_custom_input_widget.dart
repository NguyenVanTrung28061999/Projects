import 'package:flutter/material.dart';
class TextCustomInputWidget extends StatelessWidget {
  final controller;
  final focusNode;
  const TextCustomInputWidget({Key? key,required this.controller,required this.focusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.cyan),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.cyan),
        ),
      ),
      controller: controller,
    );
  }
}
