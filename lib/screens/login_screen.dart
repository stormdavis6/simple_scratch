import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:simple_scratch/constants.dart';

import '../main.dart';
import 'games_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  //https://www.youtube.com/watch?v=4vKiJZNPhss&ab_channel=HeyFlutter%E2%80%A4com
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 40,
              ),
              TextField(
                controller: emailController,
                cursorColor: kGreenLightColor,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              SizedBox(
                height: 5,
              ),
              TextField(
                controller: passwordController,
                cursorColor: kGreenLightColor,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50),
                ),
                icon: Icon(
                  Icons.lock_open,
                  size: 32,
                ),
                label: Text(
                  'Sign In',
                  style: TextStyle(fontSize: 24),
                ),
                onPressed: () {
                  signIn();
                },
              ),
              SizedBox(
                height: 24,
              ),
              RichText(
                text: TextSpan(
                    style: TextStyle(color: Color(0xff363636), fontSize: 20),
                    text: 'No account?  ',
                    children: [
                      TextSpan(
                          // recognizer: TapGestureRecognizer()..onTap = widget.onClickedSignUp,
                          text: 'Sign Up',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: kGreenLightColor))
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(
          color: kGreenLightColor,
        ),
      ),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      // Navigator.pushNamed(context, '/');
      navigatorKey.currentState?.pushNamed('/');
    } on FirebaseAuthException catch (e) {
      print(e);
      navigatorKey.currentState!.pop();
    }
  }
}