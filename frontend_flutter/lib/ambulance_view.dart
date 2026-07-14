import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AmbulanceView extends StatefulWidget {
  const AmbulanceView({super.key});

  @override
  State<AmbulanceView> createState() => _AmbulanceViewState();
}

class _AmbulanceViewState extends State<AmbulanceView> {
  final TextEditingController _vitalsController = TextEditingController();
  int eta = 15;
  String routingStatus = "Route: Calculating...";

  // Dummy action to simulate calling AI route prediction
  Future<void> _recalculateRoute() async {
    setState(() { routingStatus = "Route: Fetching from AI..."; });
    // In real app, call Python FastAPI: http://localhost:8000/predict_route
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      eta = 8;
      routingStatus = "Optimized Route via 5th Ave (High Traffic Avoided)";
    });
  }

  // Dummy action to trigger alert to hospital
  Future<void> _sendVitals() async {
     ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vitals sent to Hospital Dashboard!')),
     );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ambulance Terminal - AMB-001'),
        backgroundColor: Colors.red.shade700,
        foregroundColor: Colors.white,
      ),
      body: Row(
        children: [
          // Left Side: Mock Map and Navigation
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey.shade900,
              child: Stack(
                children: [
                  Center(
                    child: Icon(Icons.map, size: 200, color: Colors.grey.shade700),
                  ),
                  Positioned(
                    top: 20,
                    left: 20,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(8)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(routingStatus, style: const TextStyle(color: Colors.greenAccent, fontSize: 18, fontWeight: FontWeight.bold)),
                          Text('ETA: $eta mins to City Central Hospital', style: const TextStyle(color: Colors.white, fontSize: 24)),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.refresh),
                      label: const Text('Recalculate AI Route'),
                      onPressed: _recalculateRoute,
                    ),
                  )
                ],
              ),
            ),
          ),
          // Right Side: High-contrast Vitals form
          Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Quick Patient Vitals', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _vitalsController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Observations (Heart rate, O2, etc.)',
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: _sendVitals,
                      child: const Text('TRANSMIT TO HOSPITAL', style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
