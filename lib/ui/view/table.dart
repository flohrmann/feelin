/*import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TableView extends StatefulWidget {
  TableView({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _TableViewState createState() => _TableViewState();
}

class _TableViewState extends State<TableView>
{
  //enables tooltip
  TooltipBehavior _tooltipBehavior;
  @override
  void initState() {
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text("Data Page"),
      ),
      body: new Container(
        color:Colors.white70,
        //height: 600,
        alignment: Alignment.center ,
        child: new Stack(
          children:[
            new Container( //mood table
               //height: 400,
              //padding: EdgeInsets.all(10),
               child:SfCartesianChart(
                  title: ChartTitle(text: 'Average Mood per Month'),
                  //legend: Legend(isVisible: true),
                  tooltipBehavior: _tooltipBehavior,
                  primaryXAxis: CategoryAxis(),
                  series: <LineSeries<MoodData, String>>[
                    LineSeries<MoodData, String>(
                        dataSource: <MoodData>[
                          MoodData('oct', 6),
                          MoodData('nov', 5),
                          MoodData('dec', 3),
                          MoodData('jan', 4),
                          MoodData('feb', 7)
                        ],
                        xValueMapper: (MoodData mood, _) => mood.year,
                        yValueMapper: (MoodData mood, _) => mood.mood,
                        //labels each datapoint
                        dataLabelSettings: DataLabelSettings(isVisible: true)
                    )
                   ],
                  )
            ),
            new Container(
              //child: new Text('Add another graph into this container')
            )
      ]),
      )
    );
  }
}

class MoodData {
  MoodData(this.year, this.mood);
  final String year;
  final double mood;
}
 */