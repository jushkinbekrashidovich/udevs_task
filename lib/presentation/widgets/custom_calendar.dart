import 'package:flutter/material.dart';

class CustomCalendar extends StatelessWidget {
  final List<DateTime> events; // List of events to display on the calendar
  final DateTime selectedDate; // Currently selected date
  final Function(DateTime selectedDate) onDateSelected;

  const CustomCalendar({
    Key? key,
    required this.events,
    required this.selectedDate,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<TableRow> rows = _buildCalendarRows();
    return Table(
      children: rows,
    );
  }

  List<TableRow> _buildCalendarRows() {
    final List<TableRow> rows = [];
    final DateTime currentDate =
        DateTime(selectedDate.year, selectedDate.month, 1);
    final DateTime endDate =
        DateTime(selectedDate.year, selectedDate.month + 1, 0);
    final int daysInMonth = endDate.day;
    final int firstWeekday = currentDate.weekday;

    int currentDay = 1 - firstWeekday;
    while (currentDay <= daysInMonth) {
      List<Widget> rowChildren = [];
      for (int i = 0; i < 7; i++) {
        final DateTime day = currentDate.add(Duration(days: currentDay));
        final bool isCurrentMonth = day.month == selectedDate.month;
        final bool isSelected = _isSelectedDate(day);

        rowChildren.add(_buildCalendarCell(day, isSelected, isCurrentMonth));
        currentDay++;
      }

      rows.add(TableRow(children: rowChildren));
    }

    return rows;
  }

  Widget _buildCalendarCell(
      DateTime day, bool isSelected, bool isCurrentMonth) {
    // Customize the appearance of each cell here
    final Color cellColor = isSelected
        ? Colors.blue
        : (isCurrentMonth ? Colors.transparent : Colors.grey);
    final Color textColor = isSelected ? Colors.white : Colors.black;
    return GestureDetector(
      onTap: () => _onDateTap(day),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: cellColor,
          shape: _isSelectedDate(day)
              ? BoxShape.circle
              : BoxShape.rectangle, // Set shape to circle for selected date
          border: _isSelectedDate(day)
              ? Border.all(color: Colors.blue, width: 2)
              : Border.all(
                  color: Colors.transparent), // Set border for selected date
        ),
        child: Text(
          '${day.day}',
          style: TextStyle(fontSize: 16, color: textColor),
        ),
      ),
    );
  }

  bool _isSelectedDate(DateTime day) {
    return selectedDate.year == day.year &&
        selectedDate.month == day.month &&
        selectedDate.day == day.day;
  }

  void _onDateTap(DateTime selectedDate) {
    onDateSelected(selectedDate);
  }
}
