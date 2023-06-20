import 'dart:math';

import 'package:demoui/quantities.dart';
import 'package:demoui/utils/colors.dart';
import 'package:flutter/material.dart';

import 'package:sizer/sizer.dart';

class QuantityContainer extends StatefulWidget {
  final int index;

  const QuantityContainer(this.index, {super.key});

  @override
  State<QuantityContainer> createState() => _QuantityContainerState();
}

class _QuantityContainerState extends State<QuantityContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fillAnimation;
  late Animation<double> _bounceAnimation;

  Stream<double> _getQuantityStream() {
    final random = Random();
    final sortedValues = WeightList.value[widget.index].toList()
      ..sort(); // Sort the values
    int currentIndex = 0;

    return Stream<double>.periodic(const Duration(seconds: 2), (count) {
      final randomValue = sortedValues[currentIndex];
      currentIndex =
          (currentIndex + 1) % sortedValues.length; // Move to the next index
      return randomValue;
    });
  }

  Color _getColorFromQuantity(double quantity) {
    return Mycolors.primarycolor.withOpacity(quantity / 100);
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fillAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);

    _bounceAnimation = Tween<double>(
      begin: 0.0,
      end: 20.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves
            .easeInOutBack, // Use Curves.easeInOutBack for bouncing effect
        reverseCurve: Curves
            .easeInOutBack, // Use Curves.easeInOutBack for reverse bouncing effect
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant QuantityContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<double>(
      stream: _getQuantityStream(),
      initialData: 0.0,
      builder: (context, snapshot) {
        final double quantity = snapshot.data ?? 0.0;

        _animationController.animateTo(quantity / 100);
        return Stack(
          children: [
            // Water Tank Image
            Container(
              height: 23.h,
              width: 35.w,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/container.png"),
                ),
              ),
            ),
            // Animated Water Filling
            AnimatedBuilder(
              animation: _fillAnimation,
              builder: (context, child) {
                // final bounceValue = _bounceAnimation.value.clamp(0.0, 1.0);
                return Positioned(
                  bottom: 1.5.h,
                  left: 4.w,
                  right: 4.5.w,
                  height: _fillAnimation.value * 13.h,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        gradient: LinearGradient(colors: [
                          Colors.white.withOpacity(0.5),
                          Colors.white
                        ])),
                  ),
                );
              },
            ),
            Wrap(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 15.h, left: 7.w),
                  child: Text("$quantity", style: MyTextStyle.body),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16.h, left: 1.w),
                  child: const Text("Ltr"),
                )
              ],
            )
          ],
        );
      },
    );
  }
}
