import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:logger/logger.dart';
import 'package:oh_my_money/src/models/transaction/transaction.dart';
import 'package:path_provider/path_provider.dart';

final Logger logger = Logger();

class TransactionService extends ChangeNotifier {
  static late Isar isar;

  // initialize database
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [TransactionSchema],
      directory: dir.path,
    );
  }

  // list of transactions
  final List<Transaction> transactions = [];

  // create
  Future<void> addTransaction(
      String type, double amount, String note, DateTime createdAt) async {
    final newTransaction = Transaction()
      ..type = type
      ..amount = amount
      ..note = note
      ..createdAt = createdAt;

    await isar.writeTxn(() => isar.transactions.put(newTransaction));

    // re-read from database
    fetchTransactions();
  }

  // read
  Future<void> fetchTransactions() async {
    List<Transaction> fetchedTransactions =
        await isar.transactions.where().findAll();
    transactions.clear();
    transactions.addAll(fetchedTransactions);
    notifyListeners();
    logger.d(fetchedTransactions.toString());
  }

  // update
  Future<void> updateTransaction(int id, String type, double amount,
      String note, DateTime createdAt) async {
    final existingTransaction = await isar.transactions.get(id);
    if (existingTransaction != null) {
      existingTransaction.type = type;
      existingTransaction.amount = amount;
      existingTransaction.note = note;
      existingTransaction.createdAt = createdAt;
      await isar.writeTxn(() => isar.transactions.put(existingTransaction));
    }
  }

  // delete
  Future<void> deleteTransaction(int id) async {
    await isar.writeTxn(() => isar.transactions.delete(id));
    fetchTransactions();
  }
}
