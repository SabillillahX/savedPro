import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:main/components/my_button.dart';
import 'package:main/components/my_textfield.dart';
import 'package:main/components/square_tile.dart';
import 'package:main/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    // Dispose controllers when the widget is disposed
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Sign in user method
  Future<void> signUserIn() async {
    // Show loading circle
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dialog from closing
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // Try sign in
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // Dismiss loading circle after successful login
      if (Navigator.canPop(context)) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // Dismiss the loading circle before showing error
      if (Navigator.canPop(context)) Navigator.pop(context);
      showErrorMessage(e.code);
    }
  }

  // Pop up to show error message
  void showErrorMessage(String errorCode) {
    String message;
    switch (errorCode) {
      case 'user-not-found':
        message = "Email not found!";
        break;
      case 'wrong-password':
        message = "Wrong password!";
        break;
      case 'invalid-email':
        message = "Invalid email format!";
        break;
      default:
        message = "An error occurred. Please try again.";
    }

    showDialog(
      context: context,
      barrierDismissible: true, // Dialog bisa ditutup dengan mengklik di luar
      builder: (context) {
        return Align(
          alignment: Alignment.topCenter, // Menentukan posisi dialog di atas
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10), // Mengatur posisi dari atas
            child: Material(
              color: Colors.transparent,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9, // Lebar dialog
                child: AlertDialog(
                  backgroundColor: Colors.red[300],
                  insetPadding: const EdgeInsets.symmetric(horizontal: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(10), // Mengatur kelengkungan tepi
                  ),
                  title: Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Tutup dialog
                      },
                      child: const Text(
                        'OK',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 196, 196, 196),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                const Icon(
                  Icons.lock,
                  size: 100,
                ),

                // Say Hello
                const SizedBox(height: 50),
                const Text(
                  "Welcome back, you've been missed!",
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),

                // Username textfield
                const SizedBox(height: 70),
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obsecureText: false,
                ),

                // Password textfield
                const SizedBox(height: 30),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obsecureText: true,
                ),

                // Forgot password
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forgot password?",
                        style: TextStyle(
                            color: Color.fromARGB(255, 112, 112, 112)),
                      ),
                    ],
                  ),
                ),

                // Sign in button
                const SizedBox(height: 20),
                MyButton(
                  text: "Sign In",
                  onTap: signUserIn, // Use the method signUserIn
                ),

                // Or continue with
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Color.fromARGB(255, 98, 97, 97),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: Text("Or continue with"),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1,
                          color: Color.fromARGB(255, 112, 112, 112),
                        ),
                      )
                    ],
                  ),
                ),

                // Google sign-in button
                const SizedBox(height: 20),
                SquareTile(
                  imagePath: 'assets/images/google.png',
                  onTap: () => AuthService().signInWithGoogle(),
                ),

                // Register
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Not a member?",
                      style:
                          TextStyle(color: Color.fromARGB(255, 112, 112, 112)),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        "Register Now",
                        style:
                            TextStyle(color: Color.fromARGB(255, 39, 112, 246)),
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
}
