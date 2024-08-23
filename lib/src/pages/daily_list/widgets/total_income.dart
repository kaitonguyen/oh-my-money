import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oh_my_money/src/models/income_expense_list.dart';
import 'package:oh_my_money/src/utils/utils.dart';
import 'package:provider/provider.dart';

class TotalIncomeWidget extends StatelessWidget {
  TotalIncomeWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.lightGreenAccent,
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
            vertical: 8.0, horizontal: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Tổng thu:',
              style: TextStyle(
                fontSize:
                    Theme.of(context).primaryTextTheme.bodyLarge?.fontSize,
                color: Colors.black,
              ),
            ),
            Consumer<IncomeAndExpenseList>(
                builder: (context, list, child) => (Text(
                      formatNumber(list.getIncome(), 'vi'),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ))),
          ],
        ),
      ),
    );
  }
}
