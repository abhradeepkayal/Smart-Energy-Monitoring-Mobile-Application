import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'graph_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Power Monitor',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, dynamic>> appliances = const [
    {
      "name": "LED Bulb",
      "icon": Icons.lightbulb_outline,
      "voltage": 230.0,
      "current": 0.04,
      "power": 7.0,
      "pf": 0.75,
      "relay": true,
      "ml": "Normal",
      "health": "96%",
      "diagnosis": "Stable Operation",
      "alert": "No Maintenance Needed",
      "rated": "7W | 230V | 0.039A",
    },

    {
      "name": "Incandescent Bulb",
      "icon": Icons.lightbulb,
      "voltage": 231.0,
      "current": 0.425,
      "power": 96.0,
      "pf": 0.98,
      "relay": false,
      "ml": "Warning",
      "health": "72%",
      "diagnosis": "Mild Power Fluctuation",
      "alert": "Check Filament Condition",
      "rated": "100W | 230V",
    },

    {
      "name": "Fan",
      "icon": Icons.air,
      "voltage": 225.6,
      "current": 0.37,
      "power": 52.0,
      "pf": 0.64,
      "relay": true,
      "ml": "Normal",
      "health": "90%",
      "diagnosis": "Inductive Load Stable",
      "alert": "No Maintenance Needed",
      "rated": "45W | 0.36A | 2800RPM",
    },

    {
      "name": "Heater",
      "icon": Icons.local_fire_department,
      "voltage": 226.0,
      "current": 0.593,
      "power": 111.0,
      "pf": 0.83,
      "relay": false,
      "ml": "Warning",
      "health": "63%",
      "diagnosis": "Thermal Overload Risk",
      "alert": "Inspect Heating Coil",
      "rated": "110W | 230V",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Smart Power Monitor",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 20, 16, 10),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome 👋",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  SizedBox(height: 4),

                  Text(
                    "Monitor your appliances in real-time",
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: appliances.length,

                itemBuilder: (context, index) {
                  final d = appliances[index];

                  return ApplianceCard(
                    name: d["name"],
                    icon: d["icon"],
                    voltage: d["voltage"],
                    current: d["current"],
                    power: d["power"],
                    pf: d["pf"],
                    relay: d["relay"],
                    ml: d["ml"],
                    rated: d["rated"],
                    health: d["health"],
                    diagnosis: d["diagnosis"],
                    alert: d["alert"],

                    onGraphTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => GraphScreen(applianceName: d["name"]),
                        ),
                      );
                    },
                  ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ApplianceCard extends StatelessWidget {
  final String name;
  final IconData icon;

  final double voltage;
  final double current;
  final double power;
  final double pf;

  final bool relay;

  final String ml;
  final String rated;

  final String health;
  final String diagnosis;
  final String alert;

  final VoidCallback onGraphTap;

  const ApplianceCard({
    super.key,
    required this.name,
    required this.icon,
    required this.voltage,
    required this.current,
    required this.power,
    required this.pf,
    required this.relay,
    required this.ml,
    required this.rated,
    required this.health,
    required this.diagnosis,
    required this.alert,
    required this.onGraphTap,
  });

  Color getColor() {
    switch (ml) {
      case "Normal":
        return Colors.greenAccent;

      case "Warning":
        return Colors.orangeAccent;

      case "Fault":
        return Colors.redAccent;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = getColor();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.04),

        borderRadius: BorderRadius.circular(22),

        border: Border.all(color: Colors.white.withOpacity(0.08)),

        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.2),
            blurRadius: 20,
            spreadRadius: 1,
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),

                    decoration: BoxDecoration(
                      color: color.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),

                    child: Icon(icon, color: color, size: 22),
                  ),

                  const SizedBox(width: 10),

                  Text(
                    name,

                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),

              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.show_chart, color: Colors.white),

                    onPressed: onGraphTap,
                  ),

                  Icon(
                    relay ? Icons.toggle_on : Icons.toggle_off,

                    color: relay ? Colors.green : Colors.red,

                    size: 34,
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 6),
          Text(
            "Rated: $rated",

            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              buildValue("V", voltage),

              buildValue("I", current),

              buildValue("P", power),
            ],
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              CircularPercentIndicator(
                radius: 42,

                lineWidth: 8,

                percent: pf.clamp(0, 1),

                progressColor: color,

                backgroundColor: Colors.grey.shade800,

                center: Text(
                  "PF\n${pf.toStringAsFixed(2)}",

                  textAlign: TextAlign.center,

                  style: const TextStyle(color: Colors.white),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),

                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),

                  borderRadius: BorderRadius.circular(30),

                  border: Border.all(color: color.withOpacity(0.5)),
                ),

                child: Row(
                  children: [
                    Icon(Icons.circle, size: 10, color: color),

                    const SizedBox(width: 6),

                    Text(
                      ml,

                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),
          Container(
            width: double.infinity,

            padding: const EdgeInsets.all(12),

            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.04),

              borderRadius: BorderRadius.circular(16),
            ),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  "ML Analysis",

                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "Health Score: $health",

                  style: const TextStyle(color: Colors.white),
                ),

                const SizedBox(height: 4),

                Text(
                  "Diagnosis: $diagnosis",

                  style: const TextStyle(color: Colors.white70),
                ),

                const SizedBox(height: 4),

                Text(
                  "Alert: $alert",

                  style: const TextStyle(color: Colors.orangeAccent),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildValue(String label, double value) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.white70)),

        Text(
          value.toStringAsFixed(2),

          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
