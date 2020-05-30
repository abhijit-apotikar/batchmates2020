import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../class/marksDataObj.dart';

class ChartWidget extends StatelessWidget {
  final List<MarksData> chartData;
  final int sem;
  final int idx;
  final examName = [
    'Theory W17',
    'Theory S18',
    'Theory W18',
    'Theory S19',
    'Theory W19'
  ];
  ChartWidget(this.chartData, this.sem, this.idx);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 2,
            color: Colors.grey,
          ),
        ),
      ),
      height: size.height * 0.65,
      width: size.width,
      child: SfCartesianChart(
        enableSideBySideSeriesPlacement: false,
        primaryXAxis: CategoryAxis(
          title: AxisTitle(text: 'Subjects'),
        ),
        primaryYAxis: NumericAxis(
          minimum: 0,
          maximum: 100,
          title: AxisTitle(text: 'marks'),
          interval: 5,
        ),
        legend: Legend(
          isVisible: true,
          position: LegendPosition.bottom,
          overflowMode: LegendItemOverflowMode.wrap,
          title: LegendTitle(
              text: 'B.Sc. Sem $sem',
              textStyle: ChartTextStyle(
                  color: Colors.red,
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w900)),
        ),
        tooltipBehavior: TooltipBehavior(
          enable: true,
          // format: 'series.name',
        ),
        series: <ChartSeries<MarksData, String>>[
          ColumnSeries<MarksData, String>(
            name: 'OutOf100/75',
            // opacity: 0.9,
            // width: 0.4,
            color: Colors.amber,
            dataSource: chartData,
            xValueMapper: (MarksData sales, _) => sales.sub,
            yValueMapper: (MarksData sales, _) => (sales.tMarks + sales.internal),
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              //  labelAlignment: ChartDataLabelAlignment.middle,
            ),
          ),
          ColumnSeries<MarksData, String>(
            name: '${examName[sem - 1]}',
            width: 0.7,
            color: Colors.deepOrangeAccent,
            dataSource: chartData,
            xValueMapper: (MarksData sales, _) => sales.sub,
            yValueMapper: (MarksData sales, _) => sales.tMarks,
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
            ),
          ),
          ColumnSeries<MarksData, String>(
            name: 'Practical',
            opacity: 0.9,
            width: 0.5,
            color: Colors.cyan,
            dataSource: chartData,
            xValueMapper: (MarksData sales, _) => sales.sub,
            yValueMapper: (MarksData sales, _) => sales.pract,
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.top,
            ),
          ),
          ColumnSeries<MarksData, String>(
            name: 'Internal',
            opacity: 1,
            width: 0.3,
            color: Colors.deepPurpleAccent,
            dataSource: chartData,
            xValueMapper: (MarksData sales, _) => sales.sub,
            yValueMapper: (MarksData sales, _) => sales.internal,
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              labelAlignment: ChartDataLabelAlignment.middle,
            ),
          ),
        ],
      ),
    );
  }
}
