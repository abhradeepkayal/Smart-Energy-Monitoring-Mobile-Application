import 'package:flutter/material.dart';
import 'dart:async';
import 'package:fl_chart/fl_chart.dart';

class GraphScreen extends StatefulWidget {
  final String applianceName;

  const GraphScreen({super.key, required this.applianceName});

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  List<FlSpot> voltageSpots = [];
  List<FlSpot> currentSpots = [];
  List<FlSpot> powerSpots = [];

  Timer? timer;

  int index = 0;

  List<double> voltage = [];
  List<double> current = [];
  List<double> power = [];

  @override
  void initState() {
    super.initState();

    loadData();
    startGraph();
  }

  void loadData() {
    if (widget.applianceName == "LED Bulb") {
      voltage = [
        228.6,
        229.8,
        230.4,
        231.1,
        229.5,
        230.2,
        231.0,
        229.9,
        230.7,
        231.2,
        229.4,
        230.6,
        231.5,
        230.9,
        229.8,
        230.3,
        231.4,
        229.7,
        230.8,
        231.0,
      ];

      current = [
        0.0401,
        0.0402,
        0.0400,
        0.0399,
        0.0401,
        0.0403,
        0.0400,
        0.0398,
        0.0402,
        0.0401,
        0.0400,
        0.0399,
        0.0402,
        0.0400,
        0.0401,
        0.0402,
        0.0400,
        0.0399,
        0.0401,
        0.0402,
      ];

      power = [
        6.74,
        6.85,
        7.02,
        7.15,
        6.92,
        7.01,
        7.12,
        6.88,
        7.03,
        7.18,
        6.79,
        7.00,
        7.21,
        7.05,
        6.95,
        7.01,
        7.20,
        6.90,
        7.08,
        7.16,
      ];
    } else if (widget.applianceName == "Incandescent Bulb") {
      voltage = [
        229.2,
        231.7,
        230.2,
        231.0,
        231.1,
        230.5,
        229.4,
        230.8,
        230.8,
        230.6,
        231.5,
        230.7,
        229.9,
        229.2,
        230.4,
        232.0,
        230.9,
        229.5,
        230.4,
        231.9,
      ];

      current = [
        0.4247,
        0.4248,
        0.4255,
        0.4254,
        0.4250,
        0.4251,
        0.4255,
        0.4248,
        0.4250,
        0.4251,
        0.4247,
        0.4252,
        0.4255,
        0.4251,
        0.4250,
        0.4246,
        0.4250,
        0.4254,
        0.4256,
        0.4253,
      ];

      power = [
        94.15,
        99.83,
        95.74,
        95.91,
        95.31,
        95.02,
        94.73,
        96.24,
        96.40,
        95.97,
        96.58,
        96.57,
        96.16,
        94.20,
        93.84,
        96.32,
        97.39,
        95.59,
        94.89,
        96.69,
      ];
    } else if (widget.applianceName == "Fan") {
      voltage = [
        225.6,
        240.1,
        241.4,
        241.5,
        240.3,
        240.0,
        240.3,
        240.9,
        240.4,
        240.7,
        240.8,
        240.0,
        240.7,
        240.5,
        239.4,
        239.6,
        241.2,
        241.7,
        240.3,
        240.4,
      ];

      current = [
        0.3763,
        0.4014,
        0.3971,
        0.3937,
        0.3936,
        0.3921,
        0.3908,
        0.3902,
        0.3899,
        0.3902,
        0.3896,
        0.3882,
        0.3876,
        0.3873,
        0.3871,
        0.3865,
        0.3863,
        0.3854,
        0.3857,
        0.3833,
      ];

      power = [
        51.34,
        61.78,
        62.08,
        61.33,
        60.67,
        60.50,
        60.68,
        60.52,
        60.15,
        60.08,
        59.53,
        59.17,
        59.56,
        58.97,
        58.89,
        59.36,
        59.96,
        59.86,
        59.34,
        58.18,
      ];
    } else if (widget.applianceName == "Heater") {
      voltage = [
        224.3,
        224.9,
        226.1,
        226.6,
        225.4,
        226.3,
        226.5,
        225.5,
        226.1,
        226.8,
        225.5,
        226.2,
        226.8,
        225.0,
        226.8,
        225.7,
        226.0,
        228.8,
        227.8,
        225.3,
      ];

      current = [
        0.5607,
        0.5948,
        0.5933,
        0.5925,
        0.5932,
        0.5945,
        0.5930,
        0.5927,
        0.5930,
        0.5931,
        0.5927,
        0.5937,
        0.5927,
        0.5934,
        0.5931,
        0.5934,
        0.5937,
        0.5931,
        0.5935,
        0.5930,
      ];

      power = [
        99.57,
        110.20,
        111.42,
        111.32,
        110.86,
        111.57,
        111.56,
        111.30,
        110.20,
        111.43,
        111.30,
        110.86,
        111.58,
        109.62,
        111.55,
        109.41,
        113.16,
        113.42,
        110.95,
        109.19,
      ];
    }
  }

  double getMinY() {
    final allValues = [...voltage, ...power, ...current.map((e) => e * 100)];

    double min = allValues.reduce((a, b) => a < b ? a : b);

    return ((min - 20) ~/ 10) * 10;
  }

  double getMaxY() {
    final allValues = [...voltage, ...power, ...current.map((e) => e * 100)];

    double max = allValues.reduce((a, b) => a > b ? a : b);

    return (((max + 20) ~/ 10) + 1) * 10;
  }

  void startGraph() {
    timer = Timer.periodic(const Duration(milliseconds: 700), (timer) {
      if (!mounted) return;

      if (index >= voltage.length) {
        index = 0;

        voltageSpots.clear();
        currentSpots.clear();
        powerSpots.clear();
      }

      setState(() {
        voltageSpots.add(FlSpot(index.toDouble(), voltage[index]));

        currentSpots.add(FlSpot(index.toDouble(), current[index] * 100));

        powerSpots.add(FlSpot(index.toDouble(), power[index]));

        index++;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Widget buildLegend(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,

          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),

        const SizedBox(width: 6),

        Text(text, style: const TextStyle(color: Colors.white, fontSize: 13)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        centerTitle: true,

        title: Text("${widget.applianceName} Graph"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                buildLegend(Colors.blue, "Voltage"),

                buildLegend(Colors.orange, "Current"),

                buildLegend(Colors.greenAccent, "Power"),
              ],
            ),

            const SizedBox(height: 25),

            Expanded(
              child: LineChart(
                LineChartData(
                  minY: getMinY(),
                  maxY: getMaxY(),

                  backgroundColor: Colors.black,

                  gridData: FlGridData(show: true, drawVerticalLine: true),

                  borderData: FlBorderData(
                    show: true,

                    border: Border.all(color: Colors.white24),
                  ),

                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 42,
                        interval: 50,
                      ),
                    ),

                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 28,
                        interval: 2,
                      ),
                    ),

                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),

                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),

                  lineBarsData: [
                    LineChartBarData(
                      spots: voltageSpots,

                      isCurved: true,

                      color: Colors.blue,

                      barWidth: 3,

                      dotData: const FlDotData(show: false),
                    ),

                    LineChartBarData(
                      spots: currentSpots,

                      isCurved: true,

                      color: Colors.orange,

                      barWidth: 3,

                      dotData: const FlDotData(show: false),
                    ),

                    LineChartBarData(
                      spots: powerSpots,

                      isCurved: true,

                      color: Colors.greenAccent,

                      barWidth: 3,

                      dotData: const FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
