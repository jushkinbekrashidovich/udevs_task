import 'package:flutter_bloc/flutter_bloc.dart';

// Define the state for the calendar
abstract class CalendarState {}

class CalendarLoadingState extends CalendarState {}

class CalendarLoadedState extends CalendarState {
  final List<DateTime> events; // List of events to display on the calendar
  final DateTime selectedDate; // Currently selected date

  CalendarLoadedState({
    required this.events,
    required this.selectedDate,
  });
}

// Define the events for the calendar
abstract class CalendarEvent {}

class FetchCalendarEvent extends CalendarEvent {}

class SelectDateEvent extends CalendarEvent {
  final DateTime selectedDate;

  SelectDateEvent(this.selectedDate);
}

class NextMonthEvent extends CalendarEvent {}

class PreviousMonthEvent extends CalendarEvent {}

// Define the CalendarBloc
class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  late DateTime _currentMonth;

  CalendarBloc() : super(CalendarLoadingState()) {
    _currentMonth = DateTime.now();
    on<FetchCalendarEvent>(_fetchCalendar);
    on<SelectDateEvent>(_selectDate);
    on<NextMonthEvent>(_navigateToNextMonth);
    on<PreviousMonthEvent>(_navigateToPreviousMonth);
  }

  void _fetchCalendar(FetchCalendarEvent event, Emitter<CalendarState> emit) {
    // Here, you can fetch the list of events for the calendar
    // Replace this with your logic to fetch events from the repository
    final List<DateTime> events = []; // Replace this with the actual events

    // Start with the current date as the selected date
    final DateTime selectedDate = DateTime.now();

    emit(CalendarLoadedState(events: events, selectedDate: selectedDate));
  }

  void _selectDate(SelectDateEvent event, Emitter<CalendarState> emit) {
    // Handle the event when a date is selected
    emit(CalendarLoadedState(
      events: (state as CalendarLoadedState).events,
      selectedDate: event.selectedDate,
    ));
  }

  void _navigateToNextMonth(NextMonthEvent event, Emitter<CalendarState> emit) {
    _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
    emit(CalendarLoadedState(
      events: (state as CalendarLoadedState).events,
      selectedDate: (state as CalendarLoadedState).selectedDate,
    ));
  }

  void _navigateToPreviousMonth(
      PreviousMonthEvent event, Emitter<CalendarState> emit) {
    _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
    emit(CalendarLoadedState(
      events: (state as CalendarLoadedState).events,
      selectedDate: (state as CalendarLoadedState).selectedDate,
    ));
  }
}
