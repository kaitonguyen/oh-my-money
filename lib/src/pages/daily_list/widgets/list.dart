import "package:flutter/material.dart";
import "package:logger/logger.dart";
import "package:oh_my_money/src/models/transaction/transaction.dart";
import "package:oh_my_money/src/models/transaction/transaction_service.dart";
import 'package:oh_my_money/src/pages/daily_list/widgets/item_tile.dart';
import "package:provider/provider.dart";

final Logger logger = Logger();

class TodayList extends StatefulWidget {
  const TodayList({super.key});

  @override
  State<TodayList> createState() => _TodayListState();
}

class _TodayListState extends State<TodayList> {
  // read transactions
  void readTransactions() {
    context.read<TransactionService>().fetchTransactions();
  }

  @override
  void initState() {
    super.initState();

    readTransactions();
  }

  @override
  Widget build(BuildContext context) {
    final transactionService = context.watch<TransactionService>();
    List<Transaction> currentTransactions = transactionService.transactions;
    logger.d(currentTransactions.toString());

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Chi Tiết",
            style: TextStyle(
                fontSize:
                    Theme.of(context).primaryTextTheme.headlineSmall?.fontSize),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: currentTransactions.length,
              itemBuilder: (context, index) {
                final transaction = currentTransactions[index];
                return ItemTile(
                  item: transaction,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
