import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  const DefaultTextField(
      {super.key,
        required this.hintText,
        this.prefixIconData,
        this.suffixIcon,
        this.obscureText = false,
        required this.controller,
        this.validator,
        this.enabled= true,
        this.readOnly = false,
        this.onTap
      });

  final String hintText;
  final IconData? prefixIconData;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool enabled;
  final bool readOnly;
  final  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      enabled: enabled,
      readOnly: readOnly,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      controller: controller,
      style: TextStyle(fontSize: 14, color: Colors.black),
      obscureText: obscureText,
      obscuringCharacter: '*',
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Color(0xffCDCDCD), width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Color(0xffCDCDCD), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(color: Color(0xff149954), width: 1),
          ),
          hintText: hintText,
          hintStyle: TextStyle(color: Color(0xff6E6A7C), fontSize: 14),
          prefixIcon: Icon(prefixIconData),
          suffixIcon: suffixIcon),
    );
  }
}
