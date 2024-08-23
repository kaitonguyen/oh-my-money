import "package:flutter/material.dart";
import "package:oh_my_money/src/models/transaction/transaction.dart";
import "package:oh_my_money/src/models/transaction/transaction_service.dart";
import "package:oh_my_money/src/utils/ui_const.dart";
import "package:oh_my_money/src/utils/utils.dart";
import "package:provider/provider.dart";

class ItemTile extends StatelessWidget {
  final Transaction item;
  const ItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    // delete transaction
    void deleteTransaction(int id) {
      context.read<TransactionService>().deleteTransaction(id);
    }

    return Container(
      margin: const EdgeInsets.only(top: 5),
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
        title: Text(formatCurrency(item.amount, 'vi_VN', 'đ')),
        subtitle: Text(item.note.isNotEmpty ? item.note : "(Không nội dung)"),
        trailing: IconButton(
          icon: const Icon(
            Icons.delete,
            color: Colors.redAccent,
          ),
          onPressed: () => deleteTransaction(item.id),
        ),
      ),
    );
  }
}
