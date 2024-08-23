import 'package:isar/isar.dart';

part 'transaction.g.dart';

@collection
class Transaction {
  Id id = Isar.autoIncrement; // you can also use id = null to auto increment

  late String type;

  late double amount;

  late String note;

  late DateTime createdAt;
}
