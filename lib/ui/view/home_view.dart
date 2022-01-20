import 'package:flutter/material.dart';
import 'package:myflutterapp/datasource/MeetingDataSource.dart';
import 'package:myflutterapp/dialog/appointment_creator.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
{
  CalendarDataSource _calendarDataSource;
  DateTime _dateTime;

  @override
  void initState() {
    super.initState();

    _calendarDataSource = MeetingDataSource(getAppointments());
    _dateTime = null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green,
            title: Text("Feelin"),
            actions: [
              PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text("Home"),
                      value: 1,
                    ),
                    PopupMenuItem(
                      child: Text("Settings"),
                      value: 2,
                    )
                  ]
              )
            ],
          ),
          body: SfCalendar(
              view: CalendarView.month,
              onTap: calendarTapped,
              dataSource: _calendarDataSource,
              monthViewSettings: MonthViewSettings(
                  showAgenda: true, // creates agenda below calendar
                  agendaViewHeight: 300, //sets height of agenda below calendar
                  agendaItemHeight: 70, //size of agenda items

                  agendaStyle: AgendaStyle(
                      backgroundColor: Colors.white54,
                      appointmentTextStyle: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
                          color: Colors.black)
                  ),

                  appointmentDisplayMode: MonthAppointmentDisplayMode.indicator
              )),
          floatingActionButton: FloatingActionButton(
            onPressed: addButtonPressed,
            child: Text ('+'),
            backgroundColor: Colors.red[600],
          ),
        )
    );
  }

  List<Appointment> getAppointments() {
    List<Appointment> meetings = <Appointment>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
    DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));

    meetings.add(Appointment(
        startTime: startTime,
        endTime: endTime,
        subject: 'Board Meeting',
        color: Colors.orangeAccent,
        recurrenceRule: 'FREQ=DAILY;COUNT=10',
        isAllDay: false));

    return meetings;
  }

  void calendarTapped(CalendarTapDetails calendarTapDetails) {
    setState(() {
      _dateTime = calendarTapDetails.date;
    });
  }

  void addButtonPressed() {
    AppointmentCreator d = new AppointmentCreator();
    d.showAppointmentDialog(context, _calendarDataSource, _dateTime);
  }
}