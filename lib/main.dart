// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:oh_my_money/src/models/income_expense_list.dart';
import 'package:oh_my_money/src/pages/home/widgets/item_tile.dart';
import 'package:oh_my_money/src/pages/home/widgets/list.dart';
import 'package:oh_my_money/src/pages/home/widgets/user_input.dart';
import "package:provider/provider.dart";

import 'package:flutter/services.dart'; // For rootBundle
import 'package:json_theme/json_theme.dart';
import 'package:oh_my_money/src/pages/home/widgets/total_income.dart';
import 'dart:convert';

import 'package:oh_my_money/src/pages/home/widgets/total_spend.dart'; // For jsonDecode

// import 'theme/theme.dart';

void main() async {
  runApp(ChangeNotifierProvider(
    create: (context) => IncomeAndExpenseList(),
    builder: (context, child) => const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sổ ghi nhận thu chi",
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            color: Colors.green[600], foregroundColor: Colors.white),
      ),
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('vi', 'VN'), // Vietnamese
        // Add other locales if needed
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: Locale('vi', 'VN'), // Set the default locale
      home: MyHomePage(),
    );
  }
}

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thu/chi hàng ngày"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    _selectedDate.toString(),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        //when click we have to show the datepicker
                        await _selectDate(context);
                      },
                      icon: const Icon(Icons.calendar_today))
                ]),
            const SizedBox(height: 25),
            const TotalIncomeWidget(),
            const SizedBox(height: 15),
            const TotalExpend(),
            const SizedBox(height: 15),
            const TodayList(),
            const SizedBox(height: 25),
            const UserInput()
          ],
        ),
      ),
    );
  }
}
