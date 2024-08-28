import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/login_screen.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.yellow.shade700,
      ),
      body: Container(
        color: Colors.black,
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.logout, color: Colors.yellow.shade700),
              title: Text(
                'Logout',
                style: TextStyle(color: Colors.yellow.shade700),
              ),
              onTap: () {
                _showLogoutConfirmationDialog(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.yellow.shade700,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(30.0),
          ),
          backgroundColor: Colors.black,
          title: Text(
            "Confirm Logout",
            style: TextStyle(color: Colors.yellow.shade700),
          ),
          content: Text(
            "Are you sure you want to logout?",
            style: TextStyle(color: Colors.yellow.shade700),
          ),
          actions: [
            TextButton(
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.yellow.shade700),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                "Logout",
                style: TextStyle(color: Colors.yellow.shade700),
              ),
              onPressed: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                await prefs.setBool('isLoggedIn', false);
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (Route<dynamic> route) => false,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
