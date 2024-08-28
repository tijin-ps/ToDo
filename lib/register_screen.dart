import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String? gender;
  DateTime? dob;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != dob) {
      setState(() {
        dob = picked;
      });
    }
  }

  Future<void> _saveData() async {
    if (_validateFields()) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', nameController.text);
      await prefs.setString('email', emailController.text);
      await prefs.setString('password', passwordController.text);
      await prefs.setString('gender', gender ?? '');
      await prefs.setString('dob', dob != null ? dob!.toIso8601String() : '');
      Navigator.pop(context);
    }
  }

  bool _validateFields() {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty ||
        gender == null ||
        dob == null) {
      _showErrorDialog('All fields are required.');
      return false;
    }

    if (!emailRegex.hasMatch(emailController.text)) {
      _showErrorDialog('Please enter a valid email address.');
      return false;
    }

    if (passwordController.text != confirmPasswordController.text) {
      _showErrorDialog('Passwords do not match.');
      return false;
    }

    return true;
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade700,
        title: Text("Sign up"),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          color: Colors.black,
          padding: const EdgeInsets.all(16.0),
          height: 700,
          width: 500,
          child: ListView(
            children: [
              SizedBox(height: 10),
              Center(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      TextField(
                        style: TextStyle(color: Colors.white),
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(color: Colors.yellow.shade700),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.yellow.shade700),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.yellow.shade700),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.yellow.shade700),
                          ),
                          prefixIcon:
                              Icon(Icons.person, color: Colors.yellow.shade700),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Gender:",
                              style: TextStyle(color: Colors.yellow.shade700)),
                          SizedBox(width: 5),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ListTile(
                                    title: const Text('Male',
                                        style: TextStyle(color: Colors.yellow)),
                                    leading: Radio<String>(
                                      value: 'Male',
                                      groupValue: gender,
                                      onChanged: (String? value) {
                                        setState(() {
                                          gender = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: ListTile(
                                    title: const Text('Female',
                                        style: TextStyle(color: Colors.yellow)),
                                    leading: Radio<String>(
                                      value: 'Female',
                                      groupValue: gender,
                                      onChanged: (String? value) {
                                        setState(() {
                                          gender = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      TextField(
                        style: TextStyle(color: Colors.white),
                        controller: TextEditingController(
                          text: dob == null
                              ? ''
                              : '${dob!.day}/${dob!.month}/${dob!.year}',
                        ),
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Date of Brith',
                          labelStyle: TextStyle(color: Colors.yellow.shade700),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.yellow.shade700),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.yellow.shade700),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.yellow.shade700),
                          ),
                          prefixIcon: Icon(Icons.calendar_month,
                              color: Colors.yellow.shade700),
                        ),
                        onTap: () => _selectDate(context),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        style: TextStyle(color: Colors.white),
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.yellow.shade700),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.yellow.shade700),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.yellow.shade700),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.yellow.shade700),
                          ),
                          prefixIcon:
                              Icon(Icons.email, color: Colors.yellow.shade700),
                        ),
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(height: 16),
                      TextField(
                        style: TextStyle(color: Colors.white),
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.yellow.shade700),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.yellow.shade700),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.yellow.shade700),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.yellow.shade700),
                          ),
                          prefixIcon: Icon(Icons.password,
                              color: Colors.yellow.shade700),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        style: TextStyle(color: Colors.white),
                        controller: confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Confirm Password',
                          labelStyle: TextStyle(color: Colors.yellow.shade700),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.yellow.shade700),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.yellow.shade700),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.yellow.shade700),
                          ),
                          prefixIcon: Icon(Icons.password,
                              color: Colors.yellow.shade700),
                        ),
                      ),
                      SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: () async {
                          await _saveData();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 247, 222, 2),
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          minimumSize: Size(double.infinity, 50),
                        ),
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
