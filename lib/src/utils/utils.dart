import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:oh_my_money/src/utils/ui_const.dart';

String formatNumber(double number, String locale) {
  NumberFormat numberFormat = NumberFormat(UIConst.numberFormatString, locale);
  return numberFormat.format(number);
}

String formatCurrency(double number, String locale, String symbol) {
  NumberFormat numberFormat = NumberFormat.compactCurrency(
      locale: locale, symbol: symbol, decimalDigits: 2);
  return numberFormat.format(number);
}
