import 'package:flutter/material.dart';

class DefaultFlagImage extends StatelessWidget {
  const DefaultFlagImage({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      child: Image.asset(
        'assets/images/flag.png',
        height: MediaQuery.of(context).size.height * 0.37,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
