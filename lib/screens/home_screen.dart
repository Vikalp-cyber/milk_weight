import 'package:demoui/provider/selecting_index_provider.dart';
import 'package:demoui/quantities.dart';
import 'package:demoui/utils/colors.dart';
import 'package:demoui/widgets/quantity_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sizer/sizer.dart';

import 'weight_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;
  final int _currentIndex = 0;

  void _navigateToDetailScreen(BuildContext context, int index) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 500),
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: WeightScreen(index: index),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(_animationController);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 5.h, left: 1.w, right: 1.w),
              child: SizedBox(
                width: double.infinity,
                height: 20.h,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  color: Mycolors.primarycolor,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 2.h, left: 2.w),
                              child: Text(
                                "Welcome,",
                                style: MyTextStyle.heading1,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 1.h, left: 2.w),
                              child: Text(
                                "Pawan Meena",
                                style: MyTextStyle.heading2,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 4.w, top: 5.h),
                          child: CircleAvatar(
                            backgroundColor: Mycolors.secondarycolor,
                            backgroundImage:
                                const AssetImage("assets/images/amul.png"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Divider(
                thickness: 2,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5.w),
              child: Text(
                "Here is the List of Your Containers..",
                style: MyTextStyle.body,
              ),
            ),
            Wrap(
              children: [
                for (int i = 0; i < WeightList.weight.length; i++)
                  Padding(
                    padding: EdgeInsets.only(top: 2.h, left: 5.w, right: 10.w),
                    child: GestureDetector(
                      onTap: () => _navigateToDetailScreen(context, i),
                      child: Column(
                        children: [
                          QuantityContainer(i),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 0.5.h, left: 1.w),
                                  child: Text(
                                    WeightList.weight[i],
                                    style: MyTextStyle.body3,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: 0.5.h, left: 1.w),
                                  child: Text(
                                    WeightList.cities[i],
                                    style: MyTextStyle.body3,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar:
          Consumer<SelectIndex>(builder: (context, selectingIndex, _) {
        return BottomNavigationBar(
          currentIndex: selectingIndex.currentIndex,
          onTap: (value) {
            selectingIndex.OnselectingIndex(value);
          },
          selectedItemColor: Mycolors.primarycolor,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
          ],
        );
      }),
    );
  }
}
