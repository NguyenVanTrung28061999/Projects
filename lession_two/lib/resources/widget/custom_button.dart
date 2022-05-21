import 'package:flutter/material.dart';
class CustomButton extends StatelessWidget {
  final onPressed;
  final String textButton;
  const CustomButton({Key? key,required this.onPressed,required this.textButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: 120,
        decoration: const BoxDecoration(
            color: Colors.black26
        ),
        child: Center(
          child: Text(textButton, style: TextStyle(color: Colors.black),),
        ),
      ),
    );
  }
}
