import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  String? gender;
  DateTime? dob;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nameController.text = prefs.getString('name') ?? '';
      emailController.text = prefs.getString('email') ?? '';
      passwordController.text = prefs.getString('password') ?? '';
      gender = prefs.getString('gender');
      String? dobString = prefs.getString('dob');
      if (dobString != null && dobString.isNotEmpty) {
        dob = DateTime.parse(dobString);
      }
    });
  }

  Future<void> _saveData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', nameController.text);
    await prefs.setString('email', emailController.text);
    await prefs.setString('password', passwordController.text);
    await prefs.setString('gender', gender ?? '');
    await prefs.setString('dob', dob != null ? dob!.toIso8601String() : '');
  }

  void _showUpdateConfirmationDialog() {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: Text(
            'Confirm Update',
            style: TextStyle(
              color: Colors.yellow.shade700,
            ),
          ),
          content: Text(
            'Are you sure you want to update this data?',
            style: TextStyle(
              color: Colors.yellow.shade700,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.yellow.shade700,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(
                  color: Colors.yellow.shade700,
                ),
              ),
              onPressed: () async {
                if (_validateForm()) {
                  await _saveData();
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                      'Data updated successfully',
                      style: TextStyle(
                        color: Colors.yellow.shade700,
                      ),
                    )),
                  );
                  Navigator.pop(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  bool _validateForm() {
    if (nameController.text.isEmpty) {
      _showAlert(
        'Name is required',
      );
      return false;
    }
    if (!_isValidEmail(emailController.text)) {
      _showAlert('Invalid email address');
      return false;
    }
    if (passwordController.text.isEmpty) {
      _showAlert('Password is required');
      return false;
    }
    if (passwordController.text != confirmPasswordController.text) {
      _showAlert('Passwords do not match');
      return false;
    }
    return true;
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegex.hasMatch(email);
  }

  void _showAlert(String message) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.yellow.shade700,
          title: Text(
            'Validation Error',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditProfileDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: Container(
            height: 800,
            width: 600,
            child: EditDetailsScreen(
              nameController: nameController,
              emailController: emailController,
              passwordController: passwordController,
              confirmPasswordController: confirmPasswordController,
              gender: gender,
              dob: dob,
              onUpdate: _showUpdateConfirmationDialog,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade700,
        title: Text("Edit Profile"),
      ),
      body: Container(
        color: Colors.black,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            SizedBox(height: 10),
            Center(
              child: Container(
                width: 600,
                height: 600,
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
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    SizedBox(height: 10),
                    TextField(
                      style: TextStyle(color: Colors.white),
                      controller: nameController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(color: Colors.yellow.shade700),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow.shade700),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow.shade700),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow.shade700),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Gender:",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: ListTile(
                            title: const Text(
                              'Male',
                              style: TextStyle(color: Colors.yellow),
                            ),
                            leading: Radio<String>(
                              value: 'Male',
                              groupValue: gender,
                              onChanged: (String? value) {
                                setState(() {
                                  gender = value;
                                });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListTile(
                            title: const Text(
                              'Female',
                              style: TextStyle(color: Colors.white),
                            ),
                            leading: Radio<String>(
                              value: 'Female',
                              groupValue: gender,
                              onChanged: (String? value) {
                                setState(() {
                                  gender = value;
                                });
                              },
                            ),
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
                          borderSide: BorderSide(color: Colors.yellow.shade700),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow.shade700),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow.shade700),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      style: TextStyle(color: Colors.white),
                      controller: emailController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(color: Colors.yellow.shade700),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow.shade700),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow.shade700),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow.shade700),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      style: TextStyle(color: Colors.white),
                      controller: passwordController,
                      readOnly: true,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.yellow.shade700),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow.shade700),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow.shade700),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow.shade700),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      style: TextStyle(color: Colors.white),
                      controller: confirmPasswordController,
                      obscureText: true,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'confirm password',
                        labelStyle: TextStyle(color: Colors.yellow.shade700),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow.shade700),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow.shade700),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.yellow.shade700),
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: _showEditProfileDialog,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 247, 222, 2),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: const Text(
                        "Edit Profile",
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditDetailsScreen extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final String? gender;
  final DateTime? dob;
  final Function onUpdate;

  EditDetailsScreen({
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.gender,
    required this.dob,
    required this.onUpdate,
  });

  @override
  _EditDetailsScreenState createState() => _EditDetailsScreenState();
}

class _EditDetailsScreenState extends State<EditDetailsScreen> {
  String? gender;
  DateTime? dob;

  @override
  void initState() {
    super.initState();
    gender = widget.gender;
    dob = widget.dob;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dob ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != dob) {
      setState(() {
        dob = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          SizedBox(height: 10),
          TextField(
            style: TextStyle(color: Colors.white),
            controller: widget.nameController,
            decoration: InputDecoration(
              labelText: 'Name',
              labelStyle: TextStyle(color: Colors.yellow.shade700),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow.shade700),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow.shade700),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow.shade700),
              ),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Gender:",
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(width: 20),
              Expanded(
                child: ListTile(
                  title: const Text(
                    'Male',
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Radio<String>(
                    value: 'Male',
                    groupValue: gender,
                    onChanged: (String? value) {
                      setState(() {
                        gender = value;
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                child: ListTile(
                  title: const Text(
                    'Female',
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: Radio<String>(
                    value: 'Female',
                    groupValue: gender,
                    onChanged: (String? value) {
                      setState(() {
                        gender = value;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          TextField(
            style: TextStyle(color: Colors.white),
            controller: TextEditingController(
              text: dob == null ? '' : '${dob!.day}/${dob!.month}/${dob!.year}',
            ),
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Date of Brith',
              labelStyle: TextStyle(color: Colors.yellow.shade700),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow.shade700),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow.shade700),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow.shade700),
              ),
            ),
            onTap: () => _selectDate(context),
          ),
          SizedBox(height: 16),
          TextField(
            style: TextStyle(color: Colors.white),
            controller: widget.emailController,
            decoration: InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(color: Colors.yellow.shade700),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow.shade700),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow.shade700),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow.shade700),
              ),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            style: TextStyle(color: Colors.white),
            controller: widget.passwordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: TextStyle(color: Colors.yellow.shade700),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow.shade700),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow.shade700),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow.shade700),
              ),
            ),
          ),
          SizedBox(height: 16),
          TextField(
            style: TextStyle(color: Colors.white),
            controller: widget.confirmPasswordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              labelStyle: TextStyle(color: Colors.yellow.shade700),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow.shade700),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow.shade700),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow.shade700),
              ),
            ),
          ),
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              widget.onUpdate();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 247, 222, 2),
              minimumSize: Size(double.infinity, 50),
            ),
            child: const Text(
              "Update",
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
