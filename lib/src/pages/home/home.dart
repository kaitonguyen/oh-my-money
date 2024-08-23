import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:oh_my_money/src/components/bottom_nav_bar.dart";
import 'package:oh_my_money/src/pages/daily_list/daily_list.dart';
import '../general/general.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _text = "";

  double _totalIncome = 0;
  double _totalExpend = 0;

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

  int _currentIndex = 0;
  void onChangePage(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final List<Widget> _pages = [const MyDailyListPage(), GeneralPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Nhật ký thu chi"),
        ),
        bottomNavigationBar: MyBottomNavigationBar(
          onChangePage: (index) => onChangePage(index),
          currentIndex: _currentIndex,
        ),
        body: _pages[_currentIndex]);
  }
}
