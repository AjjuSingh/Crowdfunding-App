import 'package:crowdfund_app/constants/app_config.dart';
import 'package:flutter/material.dart';

class ValuePercentIndicator extends StatelessWidget {
  final int? value;

  const ValuePercentIndicator({Key? key, this.value}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: 4,
        width: AppConfig.screenWidth! % value!.toDouble(),
        color: Colors.grey,
      ),
    );
  }
}
