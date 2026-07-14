import 'package:flutter/material.dart';

class HospitalDashboard extends StatefulWidget {
  const HospitalDashboard({super.key});

  @override
  State<HospitalDashboard> createState() => _HospitalDashboardState();
}

class _HospitalDashboardState extends State<HospitalDashboard> {
  // Mock data for initial render
  int icuBeds = 12;
  int wardBeds = 45;

  List<Map<String, dynamic>> activeEmergencies = [
    {
      "ambulance": "AMB-001",
      "eta": "8 mins",
      "vitals": "HR 120, O2 88%, Suspected Cardiac",
      "status": "IN_TRANSIT"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Central Triage Dashboard - City Central Hospital'),
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
               // Reload from Spring Boot REST API
               ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Dashboard Refreshed Data')));
            },
          )
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Sidebar: Bed Availability
          Container(
            width: 250,
            padding: const EdgeInsets.all(20),
            color: Colors.blue.shade50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Live Inventory', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.indigo)),
                const Divider(),
                const SizedBox(height: 10),
                _StatCard(title: 'Available ICU', count: icuBeds, color: icuBeds < 5 ? Colors.red : Colors.green),
                const SizedBox(height: 10),
                _StatCard(title: 'Available Ward', count: wardBeds, color: Colors.green),
              ],
            ),
          ),
          
          // Main Body: Inbound Ambulances Feed
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Active Inbound Emergencies', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.red)),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: activeEmergencies.length,
                      itemBuilder: (context, index) {
                        final emergency = activeEmergencies[index];
                        return Card(
                          color: Colors.red.shade50,
                          child: ListTile(
                            leading: const Icon(Icons.warning, color: Colors.red, size: 40),
                            title: Text('Ambulance ${emergency["ambulance"]} | ETA: ${emergency["eta"]}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                            subtitle: Text('Vitals: ${emergency["vitals"]}', style: const TextStyle(fontSize: 16)),
                            trailing: ElevatedButton(
                              onPressed: () {},
                              child: const Text('PREPARE BAY'),
                            ),
                          ),
                        );
                      },
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

class _StatCard extends StatelessWidget {
  final String title;
  final int count;
  final Color color;

  const _StatCard({required this.title, required this.count, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: color, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontSize: 16, color: Colors.black54)),
          Text(count.toString(), style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }
}
