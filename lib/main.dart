import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

import 'package:flutter/services.dart'; // For rootBundle
import 'package:json_theme/json_theme.dart';
import 'package:oh_my_money/src/home/widgets/total_income.dart';
import 'dart:convert'; // For jsonDecode

// import 'theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final themeStr = await rootBundle.loadString('assets/themes/theme.json');
  final themeJson = jsonDecode(themeStr);
  final theme = ThemeDecoder.decodeThemeData(themeJson)!;

  runApp(MyApp(theme: theme));
}

class MyApp extends StatelessWidget {
  final ThemeData theme;

  const MyApp({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sổ ghi nhận thu chi",
      // theme: buildShrineTheme(),
      theme: theme,
      supportedLocales: const [
        Locale('en', 'US'), // English
        Locale('vi', 'VN'), // Vietnamese
        // Add other locales if needed
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: const Locale('vi', 'VN'), // Set the default locale
      home: const MyHomePage(),
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
  final TextEditingController _controller = TextEditingController();
  final NumberFormat _numberFormat = NumberFormat("#,###");

  // Function to split text and assign it to the _text variable
  void _splitText(String value) {
    // Check if the input text is empty
    if (value.isEmpty) {
      return;
    }

    // Split the input text by spaces
    List<String> parts = value.split(' ');

    // Check if the first part is "thu" or "chi"
    String command = parts[0];
    if (command.toLowerCase() != "thu" && command.toLowerCase() != "chi") {
      // Show an alert dialog if the condition is not met
      _showAlertDialog(context);
      return;
    }

    // Check if the second part is a number
    String money = parts[1];
    String reason = parts.sublist(2).join(' ');

    setState(() {
      _text = "Đã $command $money ${command == 'thu' ? '' : 'để'} $reason";
    });
  }

  // Function to show an alert dialog
  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Lệnh không hợp lệ"),
          content: const Text('Lệnh bắt buộc là "thu" hoặc "chi".'),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  // Function to format the number as the user types
  void _formatInput(String value) {
    List<String> parts = value.split(' ');

    if (parts.length < 2) {
      return;
    }

    String money = parts[1];

    // Remove all commas
    money = money.replaceAll(',', '');

    // Format the number with thousand separators
    parts[1] = money.isNotEmpty && int.tryParse(money) != null
        ? _numberFormat.format(int.parse(money))
        : money;

    // Join the parts back into a string
    String newValue = parts.join(' ');

    // Update the TextField with the formatted number
    _controller.value = TextEditingValue(
      text: newValue,
      selection: TextSelection.collapsed(offset: newValue.length),
    );
  }

  late TextEditingController _datePickerController;
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    // Initialize the controller with today's date
    _datePickerController = TextEditingController(
      text: DateFormat('dd/MM/yyyy').format(DateTime.now()),
    );
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
        _datePickerController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thu/chi hằng ngày"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // Pushes TextField to bottom
          children: <Widget>[
            Column(children: <Widget>[
              TextField(
                  controller: _datePickerController,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today), //icon of text field
                      labelText: "Ngày" //label text of field
                      ),
                  readOnly: true, // when true user cannot edit text
                  onTap: () async {
                    //when click we have to show the datepicker
                    await _selectDate(context);
                  }),
            ]),
            const TotalIncomeWidget(),
            const SizedBox(height: 20),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text('Cú pháp: [thu/chi] [số tiền] [nội dung]'),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Nhập ghi chú hôm nay",
                    ),
                    onChanged: _formatInput, // Format input as user types
                    onSubmitted: (value) {
                      _splitText(
                          value); // Call the split function when text is submitted
                    },
                  ),
                ])
          ],
        ),
      ),
    );
  }
}
