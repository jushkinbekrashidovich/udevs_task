import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:intl/intl.dart'; // Import the intl package for date formatting

import '../blocs/calendar_bloc.dart';
import '../widgets/custom_calendar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  String formatMonthYear(DateTime date) {
    final List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    String month = months[date.month - 1];
    String year = date.year.toString();
    return '$month $year';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CalendarBloc, CalendarState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 15),
                    DropdownButton<String>(
  items: ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December']
      .map((String value) {
    return DropdownMenuItem<String>(
      value: value,
      child: Text(
        value.substring(0, 3), // Display the first three characters as the abbreviated month name
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ),
    );
  }).toList(),
  onChanged: (String? newValue) {
    // Replace with your logic to handle dropdown selection
    print('Selected: $newValue');
  },
  value: 'August', // Replace with the selected value
),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocBuilder<CalendarBloc, CalendarState>(
                      builder: (context, state) {
                        if (state is CalendarLoadedState) {
                          return Text(
                            formatMonthYear(
                                (state as CalendarLoadedState)
                                    .selectedDate), // Display current month and year
                            style: TextStyle(fontSize: 18),
                          );
                        } else {
                          return Text(
                            'Calendar',
                            style: TextStyle(fontSize: 18),
                          );
                        }
                      },
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            context.read<CalendarBloc>().add(PreviousMonthEvent());
                          },
                          icon: Icon(Icons.arrow_back),
                        ),
                        IconButton(
                          onPressed: () {
                            context.read<CalendarBloc>().add(NextMonthEvent());
                          },
                          icon: Icon(Icons.arrow_forward),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Mon',
                      style: TextStyle(fontSize: 16),
                    ), // Replace with week day names (e.g., Mon, Tue, etc.)
                    Text(
                      'Tue',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Wed',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Thu',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Fri',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Sat',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Sun',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<CalendarBloc, CalendarState>(
                  builder: (context, state) {
                    if (state is CalendarLoadedState) {
                      return CustomCalendar(
                        events: state
                            .events, // Pass the list of events from the BloC state
                        selectedDate: state
                            .selectedDate, // Pass the selected date from the BloC state
                        onDateSelected: (selectedDate) {
                          // Dispatch the event to the Bloc when a date is selected
                          context
                              .read<CalendarBloc>()
                              .add(SelectDateEvent(selectedDate));
                        },
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
