import "package:flutter/material.dart";
import "package:intl/intl.dart";
import "package:month_picker_dialog/month_picker_dialog.dart";
import "package:oh_my_money/src/models/difference_amount.dart";
import "package:oh_my_money/src/models/difference_amount_list.dart";
import "package:oh_my_money/src/utils/ui_const.dart";
import "package:oh_my_money/src/utils/utils.dart";

class YearViewItem extends StatefulWidget {
  const YearViewItem({Key? key}) : super(key: key);

  @override
  State<YearViewItem> createState() => _YearViewItemState();
}

class _YearViewItemState extends State<YearViewItem> {
  final List<DifferenceAmount> _list =
      DifferenceAmountList().getMonthView(DateTime.now().toString());

  Future<void> onTapTile(BuildContext context) => showDialog(
        context: context,
        builder: (BuildContext context) {
          final TextEditingController _yearInputController =
              TextEditingController();
          return Dialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.fromLTRB(25, 25, 25, 5),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: _yearInputController,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child: Text(
                          "Hủy",
                          style: TextStyle(
                            color: Colors.blueAccent,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text(
                          "OK",
                          style: TextStyle(
                            color: Colors.blueAccent,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      );

  String? _selectedMonth;

  @override
  void initState() {
    super.initState();
    // Initialize the controller with today's date
    _selectedMonth = DateFormat('yyyy').format(DateTime.now());
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
          margin: const EdgeInsets.only(bottom: 15),
          padding: const EdgeInsets.only(left: 15),
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
                onPressed: () => onTapTile(context),
                icon: const Icon(Icons.edit_calendar),
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
                    formatCurrency(_list[index].amount, 'vi_VN', "đ"),
                    style: TextStyle(
                        color: _list[index].amount < 0
                            ? Colors.redAccent
                            : Colors.lightGreen,
                        fontSize: Theme.of(context)
                            .primaryTextTheme
                            .titleMedium
                            ?.fontSize),
                  ),
                  onTap: null,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
