import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For date formatting

void main() {
  runApp(const MyApp());
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CalendarPage(),
    );
  }
}

class _CalendarPageState extends State<CalendarPage> {
  final PageController _pageController = PageController();
  final List<String> dayLabels = [
    'Sun',
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemBuilder: (context, index) {
          DateTime month =
              DateTime(DateTime.now().year, DateTime.now().month + index);
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  DateFormat.yMMM().format(month),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: dayLabels
                    .map((label) => Expanded(child: Center(child: Text(label))))
                    .toList(),
              ),
              Expanded(child: _buildMonthView(month, context)),
            ],
          );
        },
      ),
    );
  }

  // Function to generate a grid view for a given month
  Widget _buildMonthView(DateTime month, BuildContext context) {
    int daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    int firstWeekday = DateTime(month.year, month.month, 1).weekday;
    int previousMonthDays = DateTime(month.year, month.month, 0).day;
    int totalCells = (daysInMonth + firstWeekday - 1 + 6) ~/ 7 * 7;

    // Calculate the aspect ratio to fill the screen vertically
    double appBarHeight = AppBar().preferredSize.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height -
        appBarHeight -
        statusBarHeight -
        100;
    int numRows = (totalCells / 7).ceil();
    double rowHeight = screenHeight / numRows;
    double cellWidth = screenWidth / 7;
    double childAspectRatio = cellWidth / rowHeight;

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: childAspectRatio,
      ),
      itemCount: totalCells,
      itemBuilder: (context, index) {
        if (index < firstWeekday - 1) {
          // Days from the previous month
          return Center(
            child: Text("${previousMonthDays - firstWeekday + index + 2}",
                style: const TextStyle(color: Colors.grey)),
          );
        } else if (index < daysInMonth + firstWeekday - 1) {
          // Days of the current month
          int day = index - firstWeekday + 2;
          return Center(
            child: Text("$day"),
          );
        } else {
          // Days from the next month
          return Center(
            child: Text("${index - daysInMonth - firstWeekday + 2}",
                style: const TextStyle(color: Colors.grey)),
          );
        }
      },
    );
  }
}
