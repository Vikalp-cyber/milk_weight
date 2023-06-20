import 'dart:math';

import 'package:demoui/quantities.dart';
import 'package:demoui/utils/colors.dart';
import 'package:flutter/material.dart';

class QuantityDetails extends StatelessWidget {
  final int index;
  QuantityDetails({super.key, required this.index});
  late double randomValue;
  Stream<double> _getQuantityStream() {
    final random = Random();
    final sortedValues = WeightList.value[index].toList()
      ..sort(); // Sort the values
    int currentIndex = 0;

    return Stream<double>.periodic(const Duration(seconds: 5), (count) {
      final randomValue = sortedValues[currentIndex];
      currentIndex =
          (currentIndex + 1) % sortedValues.length; // Move to the next index
      return randomValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<double>(
        stream: _getQuantityStream(),
        builder: (context, snapshot) {
          final double quantity = snapshot.data ?? 0.0;
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            color: Mycolors.primarycolor,
            elevation: 5,
            child: Text(
              "$quantity L",
              style: MyTextStyle.heading1,
            ),
          );
        });
  }
}
