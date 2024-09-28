// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

class MyIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback pressed;

  const MyIconButton({
    Key? key,
    required this.icon,
    required this.color,
    required this.pressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: color),
      onPressed: pressed,
    );
  }
}
