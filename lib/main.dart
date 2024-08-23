import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oh_my_money/src/models/date_time.dart';
import 'package:oh_my_money/src/models/transaction/transaction_service.dart';
import 'package:oh_my_money/src/pages/general/general.dart';
import 'package:oh_my_money/src/pages/home/home.dart';
import 'package:oh_my_money/src/utils/ui_const.dart';
import "package:provider/provider.dart";

// import 'theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TransactionService.initialize();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => TransactionService(),
        ),
        ChangeNotifierProvider(
          create: (context) => DateTimeProvider(DateTime.now()),
        ),
      ],
      child: const MyApp(),
      // builder: (context, child) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sổ ghi nhận thu chi",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        highlightColor: Colors.blue,
        indicatorColor: Colors.blue,
        scaffoldBackgroundColor: Colors.grey.shade100,
        dividerColor: Colors.grey.shade300,
        appBarTheme: const AppBarTheme(
            color: Colors.blueAccent, foregroundColor: Colors.white),
        dialogTheme: DialogTheme(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(UIConst.borderRadius),
          ),
        ),
        dialogBackgroundColor: Colors.white,
        datePickerTheme: DatePickerThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(UIConst.borderRadius),
          ),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          headerBackgroundColor: Colors.blueAccent,
          headerForegroundColor: Colors.white,
          inputDecorationTheme: const InputDecorationTheme(
            labelStyle: TextStyle(
              color: Colors.black,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
              ),
            ),
          ),
          todayBackgroundColor: MaterialStateColor.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.blueAccent;
            }
            return Colors.white;
          }),
          todayForegroundColor: MaterialStateColor.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return Colors.white;
            }
            return Colors.blueAccent;
          }),
          dayForegroundColor: MaterialStateColor.resolveWith(
            (states) {
              if (states.contains(MaterialState.selected)) {
                return Colors.white;
              }
              return Colors.black;
            },
          ),
          dayBackgroundColor: MaterialStateColor.resolveWith(
            (states) {
              if (states.contains(MaterialState.selected)) {
                return Colors.blueAccent;
              }
              return Colors.transparent;
            },
          ),
          confirmButtonStyle: ButtonStyle(
            foregroundColor: MaterialStateColor.resolveWith(
              (states) {
                return Colors.blueAccent;
              },
            ),
          ),
          cancelButtonStyle: ButtonStyle(
            foregroundColor: MaterialStateColor.resolveWith(
              (states) {
                return Colors.blueAccent;
              },
            ),
          ),
        ),
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
      locale: const Locale('vi', 'VN'), // Set the default locale
      // home: const MyHomePage(),
      routes: {
        "/": (context) => const MyHomePage(),
        "/general": (context) => GeneralPage()
      },
    );
  }
}
