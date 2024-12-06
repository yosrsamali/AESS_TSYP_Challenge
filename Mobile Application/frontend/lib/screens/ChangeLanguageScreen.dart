import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({super.key});

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  String _selectedLanguage = 'en';

  void _changeLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', _selectedLanguage);

    // Call backend to save the language preference
    // You can use your authProvider to update the language in the backend

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Language updated to $_selectedLanguage")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Language')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: _selectedLanguage,
              items: [
                DropdownMenuItem(child: Text("English"), value: 'en'),
                DropdownMenuItem(child: Text("French"), value: 'fr'),
                DropdownMenuItem(child: Text("Arabic"), value: 'ar'),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value!;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _changeLanguage,
              child: const Text('Change Language'),
            ),
          ],
        ),
      ),
    );
  }
}
