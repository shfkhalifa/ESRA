import 'package:division/division.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/prediction.dart';

enum PredictionPeriod { WEEK, MONTH, YEAR }

class ChildChart extends StatefulWidget {
  final List<Prediction> data;

  /// 0: week
  /// 1: month
  /// 2: year
  final int period;
  ChildChart({Key key, @required this.data, this.period = 0}) : super(key: key);

  @override
  _ChildChartState createState() => _ChildChartState();
}

class _ChildChartState extends State<ChildChart> {
  List<Prediction> get _predictionData => widget.data;
  int get _period => widget.period;
  List<BarChartGroupData> _chartGpData = [];
  // chart vars
  final Duration animDuration = const Duration(milliseconds: 250);

  @override
  void initState() {
    super.initState();
    // _generateCharBars();
  }

  @override
  Widget build(BuildContext context) {
    return Parent(
      style: ParentStyle()
        ..width(MediaQuery.of(context).size.width * .8)
        ..height(250)
        ..padding(vertical: 24, horizontal: 0),
      child: BarChart(
        BarChartData(
          maxY: 100,
          borderData: FlBorderData(show: false),
          axisTitleData: FlAxisTitleData(show: false),
          titlesData: _generateTitleData(),
          barGroups: _generateCharBars(),
        ),
        swapAnimationDuration: animDuration,
      ),
    );
  }

  List<BarChartGroupData> _generateCharBars() {
    switch (_period) {

      ///
      /// Show weekly data
      ///
      case 0:
        Map<String, double> weeklyData = {};
        int lastPredictionIndex = _predictionData.length - 1;
        int dayOfYear = int.parse(
            DateFormat("D").format(_predictionData[lastPredictionIndex].date));
        int lastPredictionWeek = ((dayOfYear -
                    _predictionData[lastPredictionIndex].date.weekday +
                    10) /
                7)
            .floor();
        List<int> daysFound = [];
        for (int i = 0; i < _predictionData.length; i++) {
          int dayOfYearI =
              int.parse(DateFormat("D").format(_predictionData[i].date));
          int predictionWeek =
              ((dayOfYearI - _predictionData[i].date.weekday + 10) / 7).floor();
          String dayLabel = DateFormat("EEEE").format(_predictionData[i].date);
          // TODO Add a week selector
          if (predictionWeek == lastPredictionWeek) {
            double score = _predictionData[i].score;
            if (_predictionData[i].label == "negative") {
              score = 100 - _predictionData[i].score;
              if (score == 0) score = 1;
            }
            if (daysFound.contains(dayOfYearI)) {
              weeklyData[dayLabel] = (weeklyData[dayLabel] + score) / 2;
            } else {
              weeklyData[dayLabel] = _predictionData[i].score;
            }
          }
          daysFound.add(dayOfYearI);
        }
        // Monday through Sunday
        List<String> daysLabelList = [
          "Monday",
          "Tuesday",
          "Wednesday",
          "Thursday",
          "Friday",
          "Saturday",
          "Sunday"
        ];
        _chartGpData.clear();
        for (int i = 0; i < 7; i++) {
          _chartGpData.add(BarChartGroupData(x: i, barRods: [
            BarChartRodData(
              y: weeklyData.containsKey(daysLabelList[i])
                  ? weeklyData[daysLabelList[i]]
                  : 0.0,
              width: 18,
              color: (weeklyData.containsKey(daysLabelList[i]) &&
                      weeklyData[daysLabelList[i]] <= 50.0)
                  ? Colors.red
                  : Colors.green,
              backDrawRodData: BackgroundBarChartRodData(
                show: true,
                y: 100,
                color: Colors.black12,
              ),
            ),
          ]));
        }
        return _chartGpData;
        break;

      ///
      /// Show monthly data
      ///
      case 1:
        Map<String, double> monthlyData = {};
        int lastPredictionIndex = _predictionData.length - 1;
        int lastPredictionYear = int.parse(
            DateFormat("y").format(_predictionData[lastPredictionIndex].date));

        for (int i = 0; i < _predictionData.length; i++) {
          print(_predictionData[i]);
          int predictionMonth =
              int.parse(DateFormat("M").format(_predictionData[i].date));
          int predictionYear =
              int.parse(DateFormat("y").format(_predictionData[i].date));
          if (predictionYear == lastPredictionYear) {
            double score = _predictionData[i].score;
            if (_predictionData[i].label == "negative") {
              score = 100 - _predictionData[i].score;
              if (score == 0) score = 1;
            }

            if (monthlyData.containsKey((predictionMonth - 1).toString())) {
              monthlyData[(predictionMonth - 1).toString()] =
                  (monthlyData[(predictionMonth - 1).toString()] + score) / 2;
            } else {
              monthlyData[(predictionMonth - 1).toString()] = score;
            }
          }
        }

        _chartGpData.clear();

        for (int i = 0; i < 12; i++) {
          _chartGpData.add(BarChartGroupData(x: i, barRods: [
            BarChartRodData(
              y: monthlyData.containsKey(i.toString())
                  ? monthlyData[i.toString()]
                  : 0.0,
              width: 14,
              color: (monthlyData.containsKey(i.toString()) &&
                      monthlyData[i.toString()] <= 50.0)
                  ? Colors.red
                  : Colors.green,
              backDrawRodData: BackgroundBarChartRodData(
                show: true,
                y: 100,
                color: Colors.black12,
              ),
            ),
          ]));
        }
        return _chartGpData;
        break;

      ///
      /// Show yearly Data
      ///
      case 2:
        Map<String, double> yearlyData = {};
        for (int i = 0; i < _predictionData.length; i++) {
          int predictionYear =
              int.parse(DateFormat("y").format(_predictionData[i].date));
          if (predictionYear >= 2020 && predictionYear < 2027) {
            double score = _predictionData[i].score;
            if (_predictionData[i].label == "negative") {
              score = 100 - _predictionData[i].score;
              if (score == 0) score = 1;
            }
            if (yearlyData.containsKey(predictionYear.toString())) {
              yearlyData[(predictionYear).toString()] =
                  (yearlyData[(predictionYear).toString()] + score) / 2;
            } else {
              yearlyData[(predictionYear).toString()] = score;
            }
          }
        }
        _chartGpData.clear();
        for (int i = 2020; i < 2027; i++) {
          _chartGpData.add(BarChartGroupData(x: i, barRods: [
            BarChartRodData(
              y: yearlyData.containsKey(i.toString())
                  ? yearlyData[i.toString()]
                  : 0.0,
              width: 18,
              color: (yearlyData.containsKey(i.toString()) &&
                      yearlyData[i.toString()] <= 50.0)
                  ? Colors.red
                  : Colors.green,
              backDrawRodData: BackgroundBarChartRodData(
                show: true,
                y: 100,
                color: Colors.black12,
              ),
            ),
          ]));
        }
        return _chartGpData;
        break;
      default:
    }
  }

  FlTitlesData _generateTitleData() {
    switch (_period) {
      case 0:
        return FlTitlesData(
          leftTitles: SideTitles(showTitles: false),
          bottomTitles: SideTitles(
            showTitles: true,
            getTitles: (double value) {
              switch (value.toInt()) {
                case 0:
                  return 'M';
                case 1:
                  return 'T';
                case 2:
                  return 'W';
                case 3:
                  return 'T';
                case 4:
                  return 'F';
                case 5:
                  return 'S';
                case 6:
                  return 'S';
                default:
                  return '';
              }
            },
          ),
        );

      case 1:
        return FlTitlesData(
          leftTitles: SideTitles(showTitles: false),
          bottomTitles: SideTitles(
            showTitles: true,
            getTitles: (double value) {
              switch (value.toInt()) {
                case 0:
                  return 'J';
                case 1:
                  return 'F';
                case 2:
                  return 'M';
                case 3:
                  return 'A';
                case 4:
                  return 'M';
                case 5:
                  return 'J';
                case 6:
                  return 'J';
                case 7:
                  return 'A';
                case 8:
                  return 'S';
                case 9:
                  return 'O';
                case 10:
                  return 'N';
                case 11:
                  return 'D';
                default:
                  return '';
              }
            },
          ),
        );

      case 2:
        return FlTitlesData(
          leftTitles: SideTitles(showTitles: false),
          bottomTitles: SideTitles(
            showTitles: true,
            getTitles: (double value) {
              switch (value.toInt()) {
                case 0:
                  return '2020';
                case 1:
                  return '2021';
                case 2:
                  return '2022';
                case 3:
                  return '2023';
                case 4:
                  return '2024';
                case 5:
                  return '2025';
                case 6:
                  return '2026';

                default:
                  return '';
              }
            },
          ),
        );
      default:
    }
  }
}
