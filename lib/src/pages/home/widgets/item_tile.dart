import "package:flutter/material.dart";
import "package:oh_my_money/src/models/income_expense.dart";

class ItemTile extends StatelessWidget {
  final IncomeAndExpense item;
  const ItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: item.type == "thu" ? Colors.lightGreen : Colors.red,
          width: 1,
        ),
      ),
      child: ListTile(
        leading: item.type == "thu"
            ? Icon(
                Icons.arrow_upward,
                size: 30,
                color: Colors.lightGreen,
              )
            : Icon(
                Icons.arrow_downward,
                size: 30,
                color: Colors.red,
              ),
        title: Text(item.amount.toString()),
        subtitle:
            Text(item.content.isNotEmpty ? item.content : "(Không nội dung)"),
        trailing: const Icon(
          Icons.edit,
          color: Colors.purple,
        ),
      ),
    );
  }
}
