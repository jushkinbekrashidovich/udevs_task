import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udevs_task/presentation/pages/calendar_page.dart';

import 'presentation/blocs/calendar_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Udevs Task',
      theme: ThemeData(
        // Set your app's theme here
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
        create: (context) => CalendarBloc()..add(FetchCalendarEvent()),
        child: CalendarPage(),
      ),
    );
  }
}
