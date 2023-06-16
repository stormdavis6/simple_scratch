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
  bool submitted = false;
  bool validLogin = true;

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Center(
                  child: SizedBox(
                    width: 300,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome back',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontFamily: 'Montserrat'),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Sign in to your account',
                          style: TextStyle(
                              fontSize: 23,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Montserrat'),
                        ),
                        const SizedBox(height: 30),
                        TextField(
                          controller: emailController,
                          cursorColor: kGreenLightColor,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              hintText: 'Email',
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: kGreenLightColor),
                              ),
                              errorText: submitted ? _emailErrorText : null),
                          onChanged: (string) {
                            setState(() {
                              submitted = false;
                              validLogin = true;
                            });
                          },
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        TextField(
                          controller: passwordController,
                          cursorColor: kGreenLightColor,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                              hintText: 'Password',
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: kGreenLightColor),
                              ),
                              errorText: submitted ? _passwordErrorText : null),
                          onChanged: (string) {
                            setState(() {
                              submitted = false;
                              validLogin = true;
                            });
                          },
                          obscureText: true,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        validLogin
                            ? SizedBox(
                                height: 0,
                                width: 0,
                              )
                            : Center(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                  child: Text(
                                    'Invalid email or password',
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 14),
                                  ),
                                ),
                              ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                                text: TextSpan(
                              // recognizer: TapGestureRecognizer()..onTap = widget.onClickedSignUp,
                              text: 'Forgot Password?',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: kGreenLightColor),
                            )),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: Size.fromHeight(40),
                              foregroundColor: kGreenDarkColor,
                              backgroundColor: kGreenLightColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 5),
                          child: Text(
                            'Sign In',
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                          onPressed: () {
                            setState(() {
                              submitted = true;
                            });
                            signIn();
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RichText(
                              text: TextSpan(
                                  style: TextStyle(
                                      color: Color(0xff363636), fontSize: 16),
                                  text: 'Don\'t have an account?  ',
                                  children: [
                                    TextSpan(
                                        // recognizer: TapGestureRecognizer()..onTap = widget.onClickedSignUp,
                                        text: 'Sign Up',
                                        style: TextStyle(
                                            fontSize: 20,
                                            decoration:
                                                TextDecoration.underline,
                                            color: kGreenLightColor))
                                  ]),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? get _emailErrorText {
    // at any time, we can get the text from _controller.value.text
    final text = emailController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Email can\'t be empty';
    }
    if (!text.contains('@')) {
      return 'Not a valid email';
    }
    // return null if the text is valid
    return null;
  }

  String? get _passwordErrorText {
    // at any time, we can get the text from _controller.value.text
    final text = passwordController.value.text;
    // Note: you can do your own custom validation here
    // Move this logic this outside the widget for more testable code
    if (text.isEmpty) {
      return 'Password can\'t be empty';
    }
    // return null if the text is valid
    return null;
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
      navigatorKey.currentState?.popUntil((route) => route.isFirst);
      navigatorKey.currentState?.pop();
      var snackBar = SnackBar(
        content: Text(
          'Welcome, ${FirebaseAuth.instance.currentUser?.email!}',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Color(0xff363636),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(29.5),
        ),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.fromLTRB(50, 0, 50, 5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } on FirebaseAuthException catch (e) {
      print(e);
      navigatorKey.currentState!.pop();
      setState(() {
        if (_emailErrorText == null && _passwordErrorText == null) {
          validLogin = false;
        }
      });
    }
  }
}
