import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:month_picker_dialog/month_picker_dialog.dart";
import "package:oh_my_money/src/models/difference_amount.dart";
import "package:oh_my_money/src/models/difference_amount_list.dart";
import "package:oh_my_money/src/utils/ui_const.dart";
import "package:oh_my_money/src/utils/utils.dart";

class MonthViewItem extends StatefulWidget {
  const MonthViewItem({Key? key}) : super(key: key);

  @override
  _MonthViewItemState createState() => _MonthViewItemState();
}

class _MonthViewItemState extends State<MonthViewItem> {
  final List<DifferenceAmount> _list =
      DifferenceAmountList().getMonthView(DateTime.now().toString());

  void onTapTile(context, int id) async => await showDialog(
        context: context,
        builder: (BuildContext context) => Dialog(
          child: Text(
            "Clicked " + id.toString(),
          ),
        ),
      );

  String? _selectedMonth;

  @override
  void initState() {
    super.initState();
    // Initialize the controller with today's date
    _selectedMonth = DateFormat('MM/yyyy').format(DateTime.now());
  }

  Future<void> _selectMonth(BuildContext context) async {
    final DateTime? picked = await showMonthPicker(
      context: context,
      initialDate: DateTime.now(), // Current date
      firstDate: DateTime(2000), // Earliest date
      lastDate: DateTime(2101), // Latest date
      backgroundColor: Colors.white,
      headerColor: Colors.blueAccent,
    );
    if (picked != null) {
      setState(() {
        // Update the text field with the selected date
        _selectedMonth = DateFormat('MM/yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(UIConst.borderRadius),
          ),
          margin: EdgeInsets.only(bottom: 15),
          padding: EdgeInsets.only(left: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                _selectedMonth.toString(),
                style: TextStyle(
                    fontSize: Theme.of(context)
                        .primaryTextTheme
                        .headlineSmall
                        ?.fontSize),
              ),
              IconButton(
                onPressed: () async {
                  //when click we have to show the datepicker
                  await _selectMonth(context);
                },
                icon: Icon(Icons.edit_calendar),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(UIConst.borderRadius)),
            child: ListView.builder(
              itemCount: _list.length,
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  border: BorderDirectional(
                    bottom: BorderSide(color: Theme.of(context).dividerColor),
                  ),
                ),
                child: ListTile(
                    leading: Text(
                      DateFormat("dd").format(_list[index].dateTime),
                      style: const TextStyle(fontSize: 32),
                    ),
                    title: Text(
                      DateFormat("MMM", 'vi').format(_list[index].dateTime),
                    ),
                    subtitle: Text(
                      DateFormat("yyyy").format(_list[index].dateTime),
                    ),
                    trailing: Text(
                      formatCurrency(_list[index].amount, 'vi_VN', "\đ"),
                      style: TextStyle(
                          color: _list[index].amount < 0
                              ? Colors.redAccent
                              : Colors.lightGreen,
                          fontSize: Theme.of(context)
                              .primaryTextTheme
                              .titleMedium
                              ?.fontSize),
                    ),
                    onTap: () => onTapTile(context, index)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
