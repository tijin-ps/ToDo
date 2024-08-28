import 'package:flutter/material.dart';
import 'about.dart';
import 'privacy_policy.dart';
import 'settings.dart';
import 'edit_screen.dart';

class MyDrawer extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;

  MyDrawer({required this.nameController, required this.emailController});

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage('assets/todo.png'),
                  ),
                  SizedBox(height: 10),
                  Text(widget.nameController.text),
                  SizedBox(height: 5),
                  Text(widget.emailController.text),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.yellow.shade700,
              ),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text(
                "Edit Profile",
              ),
              textColor: Colors.yellow.shade700,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditScreen()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Settings"),
              textColor: Colors.yellow.shade700,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Settings()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.lock),
              title: Text("Privacy"),
              textColor: Colors.yellow.shade700,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PrivacyPolicy()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text("About"),
              textColor: Colors.yellow.shade700,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => About()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
