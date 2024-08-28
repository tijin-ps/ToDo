import 'package:flutter/material.dart';
import 'package:my_app/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:my_app/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> _login() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String storedUsername = prefs.getString('email') ?? '';
    final String storedPassword = prefs.getString('password') ?? '';

    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      const snackBar = SnackBar(
        content: Text("Please enter both email and password!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
    if (emailController.text == storedUsername &&
        passwordController.text == storedPassword) {
      await prefs.setBool('isLoggedIn', true);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    } else {
      const snackBar = SnackBar(
        content: Text("Invalid credentials!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Colors.black,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            SizedBox(height: 10),
            Center(
              child: Container(
                width: 400,
                height: 550,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.yellow.shade700,
                    width: 1.0,
                  ),
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
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Image.asset(
                        "assets/todo.png",
                        height: 180,
                        width: 180,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "ToDo",
                      style: TextStyle(
                        color: Colors.yellow.shade700,
                        fontWeight: FontWeight.w600,
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: emailController,
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
                        prefixIcon:
                            Icon(Icons.email, color: Colors.yellow.shade700),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: passwordController,
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
                        prefixIcon:
                            Icon(Icons.lock, color: Colors.yellow.shade700),
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 247, 222, 2),
                        minimumSize: Size(double.infinity, 50),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterScreen()),
                        );
                      },
                      child: Text(
                        "Don't have an account? Sign up",
                        style: TextStyle(color: Colors.yellow.shade700),
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
