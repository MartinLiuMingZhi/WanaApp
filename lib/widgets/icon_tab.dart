import 'package:flutter/material.dart';

class IconTab extends StatelessWidget {
  const IconTab({super.key, this.icon, this.text});

  final Widget? icon;
  final String? text;
  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Tab(icon: icon!,),
        Text(text!),
      ],
    );
  }
}
