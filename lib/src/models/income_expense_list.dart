import "package:flutter/material.dart";
import "package:oh_my_money/src/models/income_expense.dart";

class IncomeAndExpenseList extends ChangeNotifier {
  double income = 0;
  double expense = 0;

  List<IncomeAndExpense> list = [];

  List<IncomeAndExpense> getList() {
    return list;
  }

  void addToList(IncomeAndExpense item) {
    list.add(item);
    if (item.type == "thu") {
      income += item.amount;
    } else {
      expense += item.amount;
    }
    notifyListeners();
  }

  void removeFromList(IncomeAndExpense item) {
    list.remove(item);
    if (item.type == "thu") {
      income -= item.amount;
    } else {
      expense -= item.amount;
    }
    notifyListeners();
  }

  double getIncome() {
    return income;
  }

  double getExpense() {
    return expense;
  }
}
