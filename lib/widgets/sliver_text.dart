import 'package:flutter/material.dart';

class SliverText extends StatelessWidget {
  final Widget? child;

  const SliverText({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: child,
    );
  }
}
