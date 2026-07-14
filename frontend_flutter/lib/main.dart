import 'package:flutter/material.dart';
import 'ambulance_view.dart';
import 'hospital_dashboard.dart';

void main() {
  runApp(const SmartAmbulanceApp());
}

class SmartAmbulanceApp extends StatelessWidget {
  const SmartAmbulanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Ambulance System',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const RoleSelectionScreen(),
        '/ambulance': (context) => const AmbulanceView(),
        '/hospital': (context) => const HospitalDashboard(),
      },
    );
  }
}

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Smart Emergency Response')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.emergency),
              label: const Text('Ambulance Tablet Navigation (Paramedic)'),
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(20), textStyle: const TextStyle(fontSize: 18)),
              onPressed: () => Navigator.pushNamed(context, '/ambulance'),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              icon: const Icon(Icons.local_hospital),
              label: const Text('Hospital Triage Dashboard (Admin)'),
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(20), textStyle: const TextStyle(fontSize: 18)),
              onPressed: () => Navigator.pushNamed(context, '/hospital'),
            ),
          ],
        ),
      ),
    );
  }
}
