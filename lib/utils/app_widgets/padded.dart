import 'package:flutter/material.dart';
import '../dimensions.dart';

class Padded extends StatelessWidget {
  const Padded({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: getScreenWidth(24),
      ),
      child: child,
    );
  }
}
