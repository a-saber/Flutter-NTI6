import 'package:flutter/material.dart';

class DefaultBtn extends StatelessWidget {
  const DefaultBtn({super.key, required this.onTap, required this.text});

  final void Function()? onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Color(0xff149954),
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                  color: Color(0xff149954),
                  offset: Offset(0, 5),
                  blurRadius: 10,
                  spreadRadius: 0)
            ]),
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
