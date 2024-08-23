import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:oh_my_money/src/models/income_expense.dart";
import "package:oh_my_money/src/models/income_expense_list.dart";
import "package:oh_my_money/src/utils/ui_const.dart";
import "package:provider/provider.dart";

class ItemTile extends StatelessWidget {
  final IncomeAndExpense item;
  const ItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    NumberFormat _numberFormat = NumberFormat("#,###.00");
    return Container(
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: item.type == "thu" ? Colors.greenAccent : Colors.redAccent,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(UIConst.borderRadius)),
      child: ListTile(
        leading: item.type == "thu"
            ? const Icon(
                Icons.arrow_upward,
                size: 30,
                color: Colors.greenAccent,
              )
            : const Icon(
                Icons.arrow_downward,
                size: 30,
                color: Colors.redAccent,
              ),
        title: Text(_numberFormat.format(item.amount)),
        subtitle:
            Text(item.content.isNotEmpty ? item.content : "(Không nội dung)"),
        trailing: IconButton(
          icon: const Icon(
            Icons.delete,
            color: Colors.redAccent,
          ),
          onPressed: () =>
              Provider.of<IncomeAndExpenseList>(context, listen: false)
                  .removeFromList(item),
        ),
      ),
    );
  }
}
