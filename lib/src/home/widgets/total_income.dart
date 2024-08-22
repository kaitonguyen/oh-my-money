import 'package:flutter/material.dart';

class TotalIncomeWidget extends StatelessWidget {
  const TotalIncomeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardTheme.color,
      child: const SizedBox(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Text('Total Income: '),
              Text('100.00'),
            ])
          ],
        ),
      ),
    );
  }
}
