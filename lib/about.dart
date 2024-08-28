import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
        backgroundColor: Colors.yellow.shade700,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Team Members:',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow.shade800),
              ),
              SizedBox(height: 10),
              _buildMember('BLESSIN THOMAS'),
              _buildMember('TIJIN P S'),
              _buildMember('EVIN JACOB'),
              _buildMember('ANTONY JOE'),
              _buildMember('SOJU YOHANNAN'),
              SizedBox(height: 20),
              Text(
                'Institution:',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow.shade800),
              ),
              SizedBox(height: 10),
              Text(
                'SB College',
                style: TextStyle(fontSize: 18, color: Colors.yellow.shade200),
              ),
              SizedBox(height: 10),
              Text(
                'Department:Computer Science',
                style: TextStyle(fontSize: 18, color: Colors.yellow.shade200),
              ),
              SizedBox(height: 10),
              Text(
                'Course:BCA (3rd Year)',
                style: TextStyle(fontSize: 18, color: Colors.yellow.shade200),
              ),
              SizedBox(height: 20),
              Text(
                'Project Description:',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow.shade800),
              ),
              SizedBox(height: 10),
              Text(
                'This app was developed as a project for our internship at DUK using Flutter.',
                style: TextStyle(fontSize: 16, color: Colors.yellow.shade200),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMember(String name) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        name,
        style: TextStyle(fontSize: 18, color: Colors.yellow.shade200),
      ),
    );
  }
}
