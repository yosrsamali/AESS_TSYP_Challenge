import 'package:flutter/material.dart';
import 'package:frontend/screens/HomePage.dart';
import 'package:frontend/screens/profile_screen.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});
  void _showMenuOptions(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.7), // Background dimming
      builder: (context) => Align(
        alignment: Alignment.topRight,
        child: FractionallySizedBox(
          widthFactor: 0.7, // Adjust width of the menu
          child: Material(
            color: Colors.transparent, // Transparent material
            child: Stack(
              children: [
                // Semi-transparent menu background
                Container(
                  decoration: BoxDecoration(
                    color: Colors.teal.withOpacity(0.9), // Adjust opacity here
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                ),
                // Menu content
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    ListTile(
                      title: Text(
                        'HOME',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      title: Text(
                        'PROFILE',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileScreen(),
                            ));
                      },
                    ),
                    ListTile(
                      title: Text(
                        'ABOUT',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {},
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  width: 40, // Adjust the width to make it small
                  height: 40, // Adjust the height to make it small
                ),
                SizedBox(width: 10), // Add spacing between the logo and text
                Text(
                  'App Title', // Add your app title here
                  style: TextStyle(
                    color: Colors.teal,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            IconButton(
              icon: Icon(
                Icons.menu,
                color: Colors.teal,
              ),
              onPressed: () {
                _showMenuOptions(context); // Trigger menu options
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'About us content goes here.',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
