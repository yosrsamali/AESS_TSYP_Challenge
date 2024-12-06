import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/model_output_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final modelOutputProvider = Provider.of<ModelOutputProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: FutureBuilder(
        future: modelOutputProvider.fetchModelOutput(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final data = modelOutputProvider.modelOutput;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Card(
                    child: ListTile(
                      title: const Text('Double Planter'),
                      subtitle: Text(data!.doublePlanter.toString()),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('Weed Cluster'),
                      subtitle: Text(data.weedCluster.toString()),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: const Text('Standing Water'),
                      subtitle: Text(data.standingWater.toString()),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
