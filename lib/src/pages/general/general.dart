import "package:flutter/material.dart";
import "package:oh_my_money/src/pages/general/widgets/month_view.dart";
import "package:oh_my_money/src/pages/general/widgets/year_view.dart";
import "package:oh_my_money/src/utils/ui_const.dart";

class GeneralPage extends StatelessWidget {
  GeneralPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(UIConst.borderRadius),
              ),
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: const TabBar(
                  unselectedLabelColor: Colors.white,
                  labelColor: Colors.white,
                  indicatorColor: Colors.white,
                  tabs: [
                    Tab(
                      icon: Icon(Icons.calendar_month),
                      text: "Tháng",
                      iconMargin: EdgeInsets.only(bottom: 5.0),
                    ),
                    Tab(
                      icon: Icon(Icons.calendar_view_month),
                      text: "Năm",
                      iconMargin: EdgeInsets.only(bottom: 5.0),
                    )
                  ]),
            ),
            const Expanded(
              child: TabBarView(children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: MonthViewItem(),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: YearViewItem(),
                ),
              ]),
            )
          ],
        ));
  }
}
