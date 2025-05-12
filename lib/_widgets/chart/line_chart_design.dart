import 'package:flutter/material.dart';
import 'package:seller_management/main.export.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartSampleData {
  ChartSampleData({
    required this.x,
    required this.y,
    required this.secondSeriesYValue,
  });
  final String x;
  final double y;
  final double secondSeriesYValue;
}

class LineChartDesign extends HookConsumerWidget {
  const LineChartDesign({
    super.key,
    required this.data,
  });

  final Map<String, YearlyData> data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<ChartSampleData> chartData = data.entries.map((entry) {
      return ChartSampleData(
        x: entry.key,
        y: entry.value.total.toDouble(),
        secondSeriesYValue: entry.value.digital.toDouble(),
      );
    }).toList();

    return AspectRatio(
      aspectRatio: 16 / 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: SfCartesianChart(
              title: const ChartTitle(text: 'Order Overview'),
              legend: const Legend(isVisible: true),
              plotAreaBorderWidth: 0,
              primaryXAxis: const CategoryAxis(
                majorGridLines: MajorGridLines(width: 0),
                edgeLabelPlacement: EdgeLabelPlacement.shift,
              ),
              primaryYAxis: const NumericAxis(
                minimum: 0,
                majorGridLines: MajorGridLines(width: 0),
              ),
              series: <CartesianSeries>[
                LineSeries<ChartSampleData, String>(
                  dataSource: chartData,
                  xValueMapper: (ChartSampleData data, _) => data.x,
                  yValueMapper: (ChartSampleData data, _) => data.y,
                  name: 'Physical',
                  markerSettings: const MarkerSettings(isVisible: true),
                ),
                LineSeries<ChartSampleData, String>(
                  dataSource: chartData,
                  xValueMapper: (ChartSampleData data, _) => data.x,
                  yValueMapper: (ChartSampleData data, _) =>
                      data.secondSeriesYValue,
                  name: 'Digital',
                  markerSettings: const MarkerSettings(isVisible: true),
                ),
              ],
              tooltipBehavior: TooltipBehavior(
                enable: true,
                color: context.colors.onPrimaryContainer,
                textStyle: TextStyle(
                  color: context.colors.onSurface,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
