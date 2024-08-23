import 'package:oh_my_money/src/models/difference_amount.dart';

class DifferenceAmountList {
  List<DifferenceAmount> list = [];

  List<DifferenceAmount> getMonthView(String month) {
    return [
      DifferenceAmount(1230, DateTime.now()),
      DifferenceAmount(12300000000, DateTime.now()),
      DifferenceAmount(-1230, DateTime.now()),
      DifferenceAmount(1230, DateTime.now()),
      DifferenceAmount(1230, DateTime.now()),
      DifferenceAmount(1230, DateTime.now()),
      DifferenceAmount(-1230, DateTime.now()),
      DifferenceAmount(1230, DateTime.now()),
      DifferenceAmount(1230, DateTime.now()),
      DifferenceAmount(1230, DateTime.now()),
      DifferenceAmount(1230, DateTime.now()),
      DifferenceAmount(-1230, DateTime.now()),
      DifferenceAmount(1230, DateTime.now()),
      DifferenceAmount(0, DateTime.now()),
      DifferenceAmount(1230, DateTime.now()),
      DifferenceAmount(1230, DateTime.now()),
      DifferenceAmount(1230, DateTime.now()),
      DifferenceAmount(1230, DateTime.now()),
      DifferenceAmount(1230, DateTime.now()),
      DifferenceAmount(-1230, DateTime.now()),
      DifferenceAmount(1230, DateTime.now()),
      DifferenceAmount(1230, DateTime.now()),
      DifferenceAmount(1230, DateTime.now()),
      DifferenceAmount(1230, DateTime.now()),
      DifferenceAmount(1230, DateTime.now()),
      DifferenceAmount(1230, DateTime.now()),
      DifferenceAmount(1230, DateTime.now()),
      DifferenceAmount(1230, DateTime.now()),
      DifferenceAmount(1230, DateTime.now()),
      DifferenceAmount(1230, DateTime.now()),
    ];
  }
}
