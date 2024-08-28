import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> _changePassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String storedPassword = prefs.getString('password') ?? '';

    if (currentPasswordController.text != storedPassword) {
      const snackBar = SnackBar(
        content: Text("Current password is incorrect!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    if (newPasswordController.text != confirmPasswordController.text) {
      const snackBar = SnackBar(
        content: Text("Passwords do not match!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }

    await prefs.setString('password', newPasswordController.text);
    const snackBar = SnackBar(
      content: Text("Password updated successfully!"),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SizedBox(height: 16),
          TextField(
            controller: currentPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Current Password',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.lock, color: Colors.blueAccent),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: newPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'New Password',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.lock, color: Colors.blueAccent),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            controller: confirmPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Confirm New Password',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.lock, color: Colors.blueAccent),
            ),
          ),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: _changePassword,
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 247, 222, 2),
              minimumSize: Size(double.infinity, 50),
            ),
            child: const Text(
              "Change Password",
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
