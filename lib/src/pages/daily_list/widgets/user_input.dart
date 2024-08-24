import "package:flutter/material.dart";
import "package:oh_my_money/src/models/date_time.dart";
import "package:oh_my_money/src/models/transaction/transaction_service.dart";
import "package:provider/provider.dart";

class UserInput extends StatefulWidget {
  const UserInput({super.key});

  @override
  State<UserInput> createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  final TextEditingController _controller = TextEditingController();

  // Function to show an alert dialog
  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Cú pháp không hợp lệ"),
          content: const Text('Bắt đầu bắt buộc là "thu" hoặc "chi".'),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Cú pháp: [thu/chi] [số tiền] [nội dung]'),
        const SizedBox(height: 15),
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
            labelText: "Nhập ghi chú hôm nay",
            floatingLabelStyle: TextStyle(color: Colors.black),
            filled: true,
            fillColor: Colors.white,
          ),
          onSubmitted: (value) {
            if (value.isEmpty) {
              return;
            }

            List<String> parts = value.split(' ');

            // Check if the first part is "thu" or "chi"
            String command = parts[0];
            if (command.toLowerCase() != "thu" &&
                command.toLowerCase() != "chi") {
              // Show an alert dialog if the condition is not met
              _showAlertDialog(context);
              return;
            }

            // Check if the second part is a number
            String money = parts[1];
            String reason = parts.sublist(2).join(' ');

            if (command.isNotEmpty && money.isNotEmpty) {
              context.read<TransactionService>().addTransaction(
                  command,
                  double.parse(money),
                  reason,
                  context.read<DateTimeProvider>().selectedDateTime);
            }
            _controller.clear(); // Clear the text field
          },
        ),
      ],
    );
  }
}
