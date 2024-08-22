import 'package:flutter/material.dart';
import 'package:oh_my_money/src/models/income_expense_list.dart';
import 'package:provider/provider.dart';

class TotalIncomeWidget extends StatelessWidget {
  const TotalIncomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green[800],
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
            vertical: 8.0, horizontal: 25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              'Total income:',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            Consumer<IncomeAndExpenseList>(
                builder: (context, list, child) => (Text(
                      list.getIncome().toString(),
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
