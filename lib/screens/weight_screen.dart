import 'dart:math';

import 'package:demoui/quantities.dart';
import 'package:demoui/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:sizer/sizer.dart';

class WeightScreen extends StatefulWidget {
  final int index;

  const WeightScreen({super.key, required this.index});

  @override
  _WeightScreenState createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

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

  List<DataRow> generateDataRows() {
    final List<String> cities = WeightList.cities;
    final List<String> weights = WeightList.weight;
    final List<double> quantities = WeightList.value[widget.index].toList();

    final List<DataRow> rows = [];

    for (int i = 0; i < cities.length; i++) {
      final String cityName = cities[i];
      final String weightName = weights[i];
      final double quantity = quantities[i];

      final DataRow row = DataRow(
        cells: [
          DataCell(Text(DateFormat('hh:mm a')
              .format(selectedDate.add(Duration(minutes: i * 5))))),
          DataCell(Text(quantity.toString())),
          DataCell(Text(cityName)),
          DataCell(Text(weightName)),
        ],
      );

      rows.add(row);
    }

    return rows;
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormat('MMM dd, yyyy').format(selectedDate);
    final formattedTime = DateFormat('hh:mm a').format(selectedDate);
    final cityName = WeightList.cities[widget.index];
    final weightName = WeightList.weight[widget.index];

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0.9),
      appBar: AppBar(
        title: const Text("Today's Milk Collection"),
        backgroundColor: Mycolors.primarycolor,
        centerTitle: true,
      ),
      body: StreamBuilder<double>(
          stream: _getQuantityStream(),
          builder: (context, snapshot) {
            final double quantity = snapshot.data ?? 0.0;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 2.h, left: 2.w),
                      child: Text(
                        "Date : $formattedDate",
                        style: MyTextStyle.body,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: Container(
                        margin: EdgeInsets.only(top: 2.h, left: 4.w),
                        height: 4.h,
                        width: 25.w,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Center(child: Text("Select Date")),
                      ),
                    )
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(
                    thickness: 2,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(columns: const [
                    DataColumn(label: Text("Time")),
                    DataColumn(label: Text("Weight(Ltr)")),
                    DataColumn(label: Text("City")),
                    DataColumn(label: Text("Machine"))
                  ], rows: generateDataRows()),
                )
              ],
            );
          }),
    );
  }
}
