import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oh_my_money/src/models/income_expense_list.dart';
import 'package:oh_my_money/src/utils/utils.dart';
import 'package:provider/provider.dart';

class TotalDifference extends StatelessWidget {
  TotalDifference({Key? key}) : super(key: key);

  NumberFormat _numberFormat = NumberFormat("#,###.00");
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightBlue[800],
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
            vertical: 8.0, horizontal: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Chênh lệch:',
              style: TextStyle(
                fontSize:
                    Theme.of(context).primaryTextTheme.bodyLarge?.fontSize,
                color: Colors.white,
              ),
            ),
            Consumer<IncomeAndExpenseList>(
                builder: (context, list, child) => (Text(
                      formatNumber(list.getIncome() - list.getExpense(), 'vi'),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}
