import 'package:flutter/material.dart';

import 'CalenderPage.dart';
import 'months.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TabBarExample(),
    );
  }
}

class TabBarExample extends StatelessWidget {
  const TabBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          // title: const Text('TabBar Sample'),
          toolbarHeight: 0,
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.calendar_month),
              ),
              Tab(
                icon: Icon(Icons.calendar_view_week),
              ),
              Tab(
                icon: Icon(Icons.calendar_view_day),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            MonthView(),
            CalendarPage(),
            Center(
              child: Text("day goes here"),
            ),
          ],
        ),
      ),
    );
  }
}
