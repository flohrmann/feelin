import 'dart:io';

import 'package:feelin/ui/view/base_view.dart';
import 'package:feelin/ui/view/settings_view.dart';
import 'package:feelin/ui/view/statistic_view.dart';
import 'package:feelin/ui/viewmodel/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  int _angle = 90;
  bool _isRotated = true;

  late AnimationController _controller;
  late Animation<double> _animation;
  late Animation<double> _animation2;

  @override
  void initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );

    _animation = new CurvedAnimation(
      parent: _controller,
      curve: new Interval(0.0, 1.0, curve: Curves.linear),
    );

    _animation2 = new CurvedAnimation(
      parent: _controller,
      curve: new Interval(0.5, 1.0, curve: Curves.linear),
    );

    _controller.reverse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeViewModel>(builder: (context, model, child) {
      return Scaffold(appBar: _buildAppBar(model), body: _buildBody(model), floatingActionButton: _buildAddButton(model));
    });
  }

  AppBar _buildAppBar(HomeViewModel model) {
    var title = Text('Home');

    switch (model.selectedIndex) {
      case 1:
        title = Text('Statistics');
        break;
      case 2:
        title = Text('Settings');
        break;
      default:
        // Default is Home page. Which is also the initial value of our variable
        break;
    }

    return AppBar(
      backgroundColor: Colors.lightGreen,
      title: title,
      actions: [
        PopupMenuButton<int>(
          enabled: true,
          itemBuilder: (context) => [
            PopupMenuItem<int>(child: Text("Home"), onTap: () => model.selectedIndex = 0),
            PopupMenuItem(child: Text('Statistics'), onTap: () => model.selectedIndex = 1),
            PopupMenuItem<int>(child: Text("Settings"), onTap: () => model.selectedIndex = 2),
            PopupMenuItem(
                child: Text('Exit'),
                value: 3,
                onTap: () {
                  //https://stackoverflow.com/questions/45109557/flutter-how-to-programmatically-exit-the-app
                  if (Platform.isAndroid) {
                    SystemNavigator.pop();
                  }
                })
          ],
        )
      ],
    );
  }

  Widget _buildBody(HomeViewModel model) {
    switch (model.selectedIndex) {
      // Show statistics
      case 1:
      return const StatisticView();
      // Show Settings
      case 2:
      return const SettingsView();
      // Show default home page
      default:
        return SfCalendar(
          view: CalendarView.month,
          onTap: (details) => model.selectedDate = details.date!,
          dataSource: model.calendarDataSource,
          monthViewSettings: MonthViewSettings(
              showAgenda: true,
              agendaViewHeight: 300,
              agendaItemHeight: 150,
              agendaStyle: AgendaStyle(
                  backgroundColor: Colors.white54, appointmentTextStyle: TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.black))),
        );
    }
  }

  Widget _buildAddButton(HomeViewModel model) {
    if (model.selectedIndex != 0) {
      return Text('');
    }

    return new Stack(
      children: [
        new Positioned(
          bottom: 144.0,
          right: 24.0,
          child: new Container(
            child: new Row(
              children: [
                new ScaleTransition(
                  scale: _animation2,
                  alignment: FractionalOffset.center,
                  child: new Container(
                    margin: new EdgeInsets.only(right: 16.0),
                    child: new Text(
                        'Create or update entry',
                    style: new TextStyle(
                      fontSize: 13.0,
                      fontFamily: 'Roboto',
                      color: new Color(0xFF9E9E9E),
                      fontWeight: FontWeight.bold
                    )
                    )
                  )
                ),
            new ScaleTransition(
              scale: _animation2,
              alignment: FractionalOffset.center,
              child: new Material(
                  color: new Color(0xFF00BFA5),
                  type: MaterialType.circle,
                  elevation: 6.0,
                  child: new GestureDetector(
                    child: new Container(
                        width: 40.0,
                        height: 40.0,
                        child: new InkWell(
                          onTap: () {
                            if(_angle == 45.0){
                              model.createOrUpdateAppointment(context);
                            }
                          },
                          child: new Center(
                            child: new Icon(
                              Icons.add,
                              color: new Color(0xFFFFFFFF),
                            )
                          )
                        )
                    )
                  )
              )
              ),
              ],
            ),
          )
        ),
        new Positioned(
            bottom: 88.0,
            right: 24.0,
            child: new Container(
              child: new Row(
                children: <Widget>[
                  new ScaleTransition(
                    scale: _animation,
                    alignment: FractionalOffset.center,
                    child: new Container(
                      margin: new EdgeInsets.only(right: 16.0),
                      child: new Text(
                        'Remove existing entry',
                        style: new TextStyle(
                          fontSize: 13.0,
                          fontFamily: 'Roboto',
                          color: new Color(0xFF9E9E9E),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  new ScaleTransition(
                    scale: _animation,
                    alignment: FractionalOffset.center,
                    child: new Material(
                        color: new Color(0xFFE57373),
                        type: MaterialType.circle,
                        elevation: 6.0,
                        child: new GestureDetector(
                          child: new Container(
                              width: 40.0,
                              height: 40.0,
                              child: new InkWell(
                                onTap: (){
                                  if(_angle == 45.0){
                                    model.deleteDiaryEntry();
                                  }
                                },
                                child: new Center(
                                  child: new Icon(
                                    Icons.remove,
                                    color: new Color(0xFFFFFFFF),
                                  ),
                                ),
                              )
                          ),
                        )
                    ),
                  ),
                ],
              ),
            )
        ),
        new Positioned(
          bottom: 16.0,
          right: 16.0,
          child: new Material(
              color: new Color(0xFFE57373),
              type: MaterialType.circle,
              elevation: 6.0,
              child: new GestureDetector(
                child: new Container(
                    width: 56.0,
                    height: 56.00,
                    child: new InkWell(
                      onTap: _rotate,
                      child: new Center(
                          child: new RotationTransition(
                            turns: new AlwaysStoppedAnimation(_angle / 360),
                            child: new Icon(
                              Icons.add,
                              color: new Color(0xFFFFFFFF),
                            ),
                          )
                      ),
                    )
                ),
              )
          ),
        )
      ]
    );
  }

  void _rotate(){
    setState((){
      if(_isRotated) {
        _angle = 45;
        _isRotated = false;
        _controller.forward();
      } else {
        _angle = 90;
        _isRotated = true;
        _controller.reverse();
      }
    });
  }
}
