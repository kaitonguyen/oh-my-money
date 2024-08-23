import 'package:flutter/material.dart';

class DateTimeProvider extends ChangeNotifier {
  final DateTime selectedDateTime;

  DateTimeProvider(this.selectedDateTime);
}
