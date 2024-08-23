import "package:flutter/material.dart";

class MyBottomNavigationBar extends StatelessWidget {
  void Function(int) onChangePage;
  final currentIndex;
  MyBottomNavigationBar(
      {super.key, required this.onChangePage, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.blueAccent,
      unselectedItemColor: Colors.blueGrey,
      onTap: onChangePage,
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.add_home),
          label: "Nhập ghi chú",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_month),
          label: "Tổng quát",
        )
      ],
    );
  }
}
