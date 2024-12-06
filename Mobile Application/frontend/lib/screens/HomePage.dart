import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:frontend/screens/AboutScreen.dart';
import 'package:frontend/screens/ChatbotScreen.dart';
import 'package:frontend/screens/profile_screen.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Variables to store the model output
  double doublePlanter = 0.0;
  double weedCluster = 0.0;
  double standingWater = 0.0;
  double floodProgress = 0.0; // Flood condition progress (0 to 1)

  // Fetch data from the backend
  Future<void> fetchModelOutput() async {
    final url = 'http://localhost:5000/api/model-output';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          doublePlanter = data['double_planter'];
          weedCluster = data['weed_cluster'];
          standingWater = data['standing_water'];
          floodProgress = Random().nextDouble(); // Simulate flood condition
        });

        // Check for out-of-range values
        List<String> messages = [];
        if (doublePlanter == 0.0) messages.add('Double Planter is low');
        if (doublePlanter > 2.0) messages.add('Double Planter is high');
        if (weedCluster == 0.0) messages.add('Weed Cluster is low');
        if (weedCluster > 2.0) messages.add('Weed Cluster is high');
        if (standingWater == 0.0) messages.add('Standing Water is low');
        if (standingWater > 2.0) messages.add('Standing Water is high');

        if (messages.isNotEmpty) {
          _showOutOfRangePopup(context, messages.join('\n'));
        }
      } else {
        throw Exception('Failed to load model output');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchModelOutput();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: _buildAppBar(context),
      body: RefreshIndicator(
        onRefresh: fetchModelOutput,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Statistics Section
                _buildStatisticsSection(),
                const SizedBox(height: 20),
                // Footer Section with Image
                _buildFooterImage(),
                const SizedBox(height: 20),
                // Flood Condition Section
                _buildFloodConditionSection(screenWidth),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                'assets/images/logo.png',
                width: 40,
                height: 40,
              ),
              const SizedBox(width: 10),
              const Text(
                'App Title',
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.teal),
            onPressed: () => _showMenuOptions(context),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticsSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatisticBox('Weed Cluster', weedCluster, Colors.green),
        _buildStatisticBox('Standing Water', standingWater, Colors.blue),
        _buildStatisticBox('Double Planter', doublePlanter, Colors.orange),
      ],
    );
  }

  Widget _buildStatisticBox(String title, double value, Color color) {
    return Expanded(
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: color,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              CircularPercentIndicator(
                radius: 50,
                lineWidth: 10.0,
                percent: (value > 2.0) ? 1.0 : value / 2.0,
                center: Text(
                  value.toStringAsFixed(2),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                progressColor: color,
                backgroundColor: Colors.grey.shade200,
                circularStrokeCap: CircularStrokeCap.round,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooterImage() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Image.asset(
        'assets/images/same.jpg',
        fit: BoxFit.cover,
        width: 500,
        height: 300,
      ),
    );
  }

  Widget _buildFloodConditionSection(double screenWidth) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text(
            'Is there Floods?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 20),
          CircularPercentIndicator(
            radius: screenWidth * 0.25,
            lineWidth: 12.0,
            percent: floodProgress,
            center: Text(
              '${(floodProgress * 100).toStringAsFixed(0)}%',
              style: const TextStyle(fontSize: 20),
            ),
            progressColor: floodProgress > 0.5 ? Colors.red : Colors.green,
            backgroundColor: Colors.grey.shade200,
            circularStrokeCap: CircularStrokeCap.round,
          ),
        ],
      ),
    );
  }

  void _showMenuOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Align(
        alignment: Alignment.topRight,
        child: FractionallySizedBox(
          widthFactor: 0.7,
          child: Material(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.teal.withOpacity(0.9),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 50,
                    ),
                  ),
                  _buildMenuOption(context, 'HOME', () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatbotScreen(),
                      ),
                    );
                  }),
                  _buildMenuOption(context, 'PROFILE', () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileScreen(),
                      ),
                    );
                  }),
                  _buildMenuOption(context, 'ABOUT', () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AboutScreen(),
                      ),
                    );
                  }),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: IconButton(
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuOption(
      BuildContext context, String title, VoidCallback onTap) {
    return ListTile(
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }

  void _showOutOfRangePopup(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 10,
          backgroundColor: Colors.white,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.teal.withOpacity(0.9),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.warning_rounded,
                  color: Colors.yellowAccent,
                  size: 50,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Value Alert',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  message,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'OK',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
