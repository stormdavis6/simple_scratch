import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:provider/provider.dart';
import 'package:simple_scratch/constants.dart';
import 'package:simple_scratch/models/user.dart';
import 'package:simple_scratch/screens/forgot_password_screen.dart';
import 'package:simple_scratch/services/auth_service.dart';
import 'package:simple_scratch/utils.dart';

import '../main.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const LoginWidget({super.key, required this.onClickedSignUp});

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String errorText = '';
  late bool passwordVisible;

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
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
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    Stack(
                      children: [
                        Positioned.directional(
                          textDirection: TextDirection.rtl,
                          child: Text(
                            'Simple Scratch',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 2
                                      ..color = kGreenOliveColor,
                                    fontFamily: 'Pacifico'),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          'Simple Scratch',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: kYellowLightColor,
                                    fontFamily: 'Pacifico',
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 48,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    width: 300,
                    child: Form(
                      key: formKey,
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
                          TextFormField(
                            controller: emailController,
                            cursorColor: kGreenLightColor,
                            textInputAction: TextInputAction.next,
                            decoration: InputDecoration(
                              hintText: 'Email',
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: kGreenLightColor),
                              ),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (email) =>
                                email != null && !EmailValidator.validate(email)
                                    ? 'Enter a valid email'
                                    : null,
                            onChanged: (string) {},
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            controller: passwordController,
                            cursorColor: kGreenLightColor,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: kGreenLightColor),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  passwordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey[700],
                                ),
                                onPressed: () {
                                  setState(() {
                                    passwordVisible = !passwordVisible;
                                  });
                                },
                              ),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) => value != null && value.isEmpty
                                ? 'Password is required'
                                : null,
                            onChanged: (string) {},
                            obscureText: !passwordVisible,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          errorText.isNotEmpty
                              ? Center(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                    child: Text(
                                      errorText,
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 14),
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height: 0,
                                  width: 0,
                                ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                child: RichText(
                                  text: TextSpan(
                                    text: 'Forgot Password?',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: kGreenLightColor),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ForgotPasswordScreen();
                                  }));
                                },
                              ),
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
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white),
                            ),
                            onPressed: () async {
                              signIn(authService);
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: SignInButton(
                              Buttons.Google,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              onPressed: () {
                                signInWithGoogle(authService);
                              },
                            ),
                          ),
                          // Center(
                          //   child: SignInButton(
                          //     Buttons.FacebookNew,
                          //     onPressed: () {
                          //       signInWithFacebook();
                          //     },
                          //   ),
                          // ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        color: kBlackLightColor, fontSize: 16),
                                    text: 'Don\'t have an account?  ',
                                    children: [
                                      TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = widget.onClickedSignUp,
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

  Future signIn(AuthService authService) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

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
      User? user = await authService.signInWithEmailAndPassword(
          emailController.text.trim(), passwordController.text.trim());
      navigatorKey.currentState?.pushNamed('/');
      Utils.showSnackBar('Welcome, ${user?.email}', context);
      //print(user?.lastSignInTime.toString());
    } on auth.FirebaseAuthException catch (e) {
      String exCode = e.code.toString();
      setState(() {
        if (exCode == 'invalid-email' ||
            exCode == 'wrong-password' ||
            exCode == 'user-not-found') {
          errorText = 'Email or password is invalid';
        }
      });
      navigatorKey.currentState!.pop();
    }
  }

  Future signInWithGoogle(AuthService authService) async {
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
      User? user = await authService.signInWithGoogle();
      navigatorKey.currentState
        ?..popUntil((route) => route.isFirst)
        ..pop();
      Utils.showSnackBar('Welcome, ${user?.email}', context);
    } on auth.FirebaseAuthException catch (e) {
      String exCode = e.code.toString();
      setState(() {
        if (exCode == 'invalid-email' ||
            exCode == 'wrong-password' ||
            exCode == 'user-not-found') {
          errorText = 'Email or password is invalid';
        }
      });
      navigatorKey.currentState!.pop();
    }
  }
}