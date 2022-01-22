import 'package:feelin/ui/view/base_view.dart';
import 'package:feelin/ui/viewmodel/statistic_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class StatisticView extends StatefulWidget {
  const StatisticView({Key? key}) : super(key: key);

  @override
  _StatisticViewState createState() => _StatisticViewState();
}

class _StatisticViewState extends State<StatisticView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<StatisticViewModel>(builder: (context, model, child) {
      return Center(
          child: Column(children: [
        new CircularPercentIndicator(
          radius: 130.0,
          animation: true,
          animationDuration: 1200,
          lineWidth: 15.0,
          percent: model.calculateDaysRegistered(),
          center: new Text(
            model.totalDaysRegistered,
            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            textAlign: TextAlign.center,
          ),
          circularStrokeCap: CircularStrokeCap.butt,
          backgroundColor: Colors.grey,
          progressColor: Colors.blueAccent,
        ),
        Divider(color: Colors.grey, thickness: 3),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text('Overall mood', style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0), textAlign: TextAlign.center),
                Text(model.calculateAverageMood(), style: new TextStyle(fontWeight: FontWeight.normal, fontSize: 14.0), textAlign: TextAlign.center)
              ],
            ),
            VerticalDivider(color: Colors.grey, width: 10, thickness: 3, indent: 10, endIndent: 10),
            Column(
              children: [
                Text('Most common symptom', style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0), textAlign: TextAlign.center),
                Text(model.calculateMostCommonlyUsedSymptom(),
                    style: new TextStyle(fontWeight: FontWeight.normal, fontSize: 14.0), textAlign: TextAlign.center)
              ],
            )
          ],
        ),
        Divider(color: Colors.grey, thickness: 3)
      ]));
    });
  }
}
