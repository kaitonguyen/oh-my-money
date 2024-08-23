import "package:flutter/material.dart";
import "package:oh_my_money/src/models/income_expense.dart";
import "package:oh_my_money/src/models/income_expense_list.dart";
import 'package:oh_my_money/src/pages/daily_list/widgets/item_tile.dart';
import "package:provider/provider.dart";

class TodayList extends StatefulWidget {
  const TodayList({super.key});

  @override
  State<TodayList> createState() => _TodayListState();
}

class _TodayListState extends State<TodayList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<IncomeAndExpenseList>(
        builder: (context, list, child) => Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Chi Tiết",
                    style: TextStyle(
                        fontSize: Theme.of(context)
                            .primaryTextTheme
                            .headlineSmall
                            ?.fontSize),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: list.getList().length,
                          itemBuilder: (context, index) {
                            IncomeAndExpense item = list.getList()[index];
                            return ItemTile(item: item);
                          })),
                ],
              ),
            ));
  }
}
