import 'package:flutter/material.dart';
import 'package:seller_management/main.export.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChartDesign extends HookConsumerWidget {
  const PieChartDesign({
    super.key,
    required this.data,
  });

  final Map<String, int> data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<ChartSampleData> chartData = data.entries
        .map(
          (entry) => ChartSampleData(
              x: entry.key, y: entry.value.toDouble(), secondSeriesYValue: 0),
        )
        .toList();

    return AspectRatio(
      aspectRatio: context.onMobile ? 16 / 11 : 16 / 6,
      child: SfCircularChart(
        title: const ChartTitle(
          text: 'Order Overview',
          alignment: ChartAlignment.near,
        ),
        tooltipBehavior: TooltipBehavior(
          enable: true,
          color: context.colors.onPrimaryContainer,
          textStyle: TextStyle(
            color: context.colors.onSurface,
          ),
        ),
        series: _getPieSeries(chartData, context),
      ),
    );
  }

  List<PieSeries<ChartSampleData, String>> _getPieSeries(
      List<ChartSampleData> data, BuildContext context) {
    return <PieSeries<ChartSampleData, String>>[
      PieSeries<ChartSampleData, String>(
        dataSource: data,
        xValueMapper: (ChartSampleData data, _) => data.x,
        yValueMapper: (ChartSampleData data, _) => data.y,
        pointColorMapper: (ChartSampleData data, _) => GraphData.color(data.x),
        dataLabelMapper: (ChartSampleData data, _) =>
            '${data.x}: ${data.y == 0 ? '0' : data.y.toString()}',
        dataLabelSettings: const DataLabelSettings(
          isVisible: true,
          overflowMode: OverflowMode.trim,
          labelPosition: ChartDataLabelPosition.outside,
          connectorLineSettings:
              ConnectorLineSettings(type: ConnectorType.curve),
          showZeroValue: true,
        ),
      ),
    ];
  }
}

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
  });

  final Color color;
  final String text;
  final bool isSquare;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 8),
        Text(text),
      ],
    );
  }
}

class GraphData {
  static Color color(String key) {
    // Logger(key);
    switch (key) {
      case 'placed':
        return Colors.orange;
      case 'confirmed':
        return Colors.pink;
      case 'processing':
        return Colors.cyan;
      case 'shipped':
        return Colors.purple;
      case 'delivered':
        return Colors.green;
      case 'cancel':
        return Colors.red;
      default:
        return Colors.green;
    }
  }
}
