import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:oh_my_money/src/components/bottom_nav_bar.dart";
import 'package:oh_my_money/src/pages/daily_list/widgets/total_difference.dart';
import "package:oh_my_money/src/pages/general/general.dart";

import "widgets/list.dart";
import "widgets/total_income.dart";
import "widgets/total_spend.dart";
import "widgets/user_input.dart";

class MyDailyListPage extends StatefulWidget {
  const MyDailyListPage({Key? key}) : super(key: key);

  @override
  _MyDailyListPageState createState() => _MyDailyListPageState();
}

class _MyDailyListPageState extends State<MyDailyListPage> {
  String? _selectedDate;

  @override
  void initState() {
    super.initState();
    // Initialize the controller with today's date
    _selectedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Current date
      firstDate: DateTime(2000), // Earliest date
      lastDate: DateTime(2101), // Latest date
    );
    if (picked != null) {
      setState(() {
        // Update the text field with the selected date
        _selectedDate = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  _selectedDate.toString(),
                  style: TextStyle(
                      fontSize: Theme.of(context)
                          .primaryTextTheme
                          .headlineSmall
                          ?.fontSize),
                ),
                IconButton(
                    onPressed: () async {
                      //when click we have to show the datepicker
                      await _selectDate(context);
                    },
                    icon: const Icon(Icons.edit_calendar))
              ]),
          TotalIncomeWidget(),
          TotalExpend(),
          TotalDifference(),
          const SizedBox(height: 15),
          TodayList(),
          const UserInput()
        ],
      ),
    );
  }
}
