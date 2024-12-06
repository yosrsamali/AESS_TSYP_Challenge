import 'package:flutter/material.dart';
import 'package:frontend/screens/AboutScreen.dart';
import 'package:frontend/screens/HomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _selectedLanguage = 'en';

  void _changePassword(BuildContext context) async {
    final TextEditingController currentPasswordController =
        TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[100],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: const Text(
            'Change Password',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: currentPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Current Password',
                    labelStyle: TextStyle(color: Colors.blueGrey),
                  ),
                ),
                TextField(
                  controller: newPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'New Password',
                    labelStyle: TextStyle(color: Colors.blueGrey),
                  ),
                ),
                TextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Confirm New Password',
                    labelStyle: TextStyle(color: Colors.blueGrey),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.redAccent),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () async {
                if (newPasswordController.text !=
                    confirmPasswordController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Passwords do not match")),
                  );
                } else {
                  try {
                    await _changePasswordBackend(
                      currentPasswordController.text,
                      newPasswordController.text,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Password changed successfully')),
                    );
                    Navigator.of(context).pop();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: $e')),
                    );
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _changePasswordBackend(
      String currentPassword, String newPassword) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.put(
      Uri.parse('http://localhost:5000/api/profile/change-password'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'currentPassword': currentPassword,
        'newPassword': newPassword,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to change password');
    }
  }

  void _changeLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', _selectedLanguage);

    await _changeLanguageBackend(_selectedLanguage);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Language updated to $_selectedLanguage")),
    );
  }

  Future<void> _changeLanguageBackend(String language) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.put(
      Uri.parse('http://localhost:5000/api/profile/change-language'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'language': language}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update language');
    }
  }

  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    Navigator.of(context).pushReplacementNamed('/signin');
  }

  // New method to show the menu
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
                      onTap: () {},
                    ),
                    ListTile(
                      title: Text(
                        'ABOUT',
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AboutScreen(),
                          ),
                        );
                      },
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              tileColor: Colors.grey[200],
              leading: const Icon(Icons.lock_outline,
                  color: Color.fromARGB(255, 3, 203, 16)),
              title: const Text(
                'Change Password',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              onTap: () => _changePassword(context),
            ),
            const Divider(),
            ListTile(
              tileColor: Colors.grey[200],
              leading: const Icon(Icons.language,
                  color: Color.fromARGB(255, 3, 218, 18)),
              title: const Text(
                'Change Language',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.grey[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      title: const Text(
                        'Select Language',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 4, 199, 14)),
                      ),
                      content: DropdownButton<String>(
                        value: _selectedLanguage,
                        items: const [
                          DropdownMenuItem(child: Text("English"), value: 'en'),
                          DropdownMenuItem(child: Text("French"), value: 'fr'),
                          DropdownMenuItem(child: Text("Arabic"), value: 'ar'),
                        ],
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedLanguage = newValue!;
                          });
                        },
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('Cancel',
                              style: TextStyle(color: Colors.redAccent)),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        TextButton(
                          child: const Text('Save',
                              style: TextStyle(color: Colors.green)),
                          onPressed: () {
                            _changeLanguage();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            const Divider(),
            ListTile(
              tileColor: Colors.grey[200],
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text(
                'Logout',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              onTap: () => _logout(context),
            ),
          ],
        ),
      ),
    );
  }
}
