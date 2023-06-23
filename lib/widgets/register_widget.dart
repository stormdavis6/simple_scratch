import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:simple_scratch/utils.dart';

import '../constants.dart';
import '../main.dart';

class RegisterWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const RegisterWidget({Key? key, required this.onClickedSignUp})
      : super(key: key);

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  String errorText = '';
  late bool passwordVisible;
  late bool passwordConfirmVisible;

  @override
  void initState() {
    passwordVisible = false;
    passwordConfirmVisible = false;
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                            'Welcome',
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontFamily: 'Montserrat'),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Create an account',
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
                            textInputAction: TextInputAction.next,
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
                                  setState(
                                    () {
                                      passwordVisible = !passwordVisible;
                                    },
                                  );
                                },
                              ),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'Password is required';
                              } else if (value!.length < 6) {
                                return 'Password must be at least 6 characters';
                              } else {
                                return null;
                              }
                            },
                            onChanged: (string) {},
                            onFieldSubmitted: (string) {
                              // Move the focus to the next node explicitly.
                              FocusScope.of(context).nextFocus();
                            },
                            obscureText: !passwordVisible,
                          ),
                          TextFormField(
                            controller: passwordConfirmController,
                            cursorColor: kGreenLightColor,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              hintText: 'Confirm Password',
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: kGreenLightColor),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  passwordConfirmVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.grey[700],
                                ),
                                onPressed: () {
                                  setState(() {
                                    passwordConfirmVisible =
                                        !passwordConfirmVisible;
                                  });
                                },
                              ),
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value != null && value.isEmpty) {
                                return 'Password is required';
                              } else if (value!.length < 6) {
                                return 'Password must be at least 6 characters';
                              } else if (value != passwordController.text) {
                                return 'Passwords must match';
                              } else {
                                return null;
                              }
                            },
                            onChanged: (string) {},
                            obscureText: !passwordConfirmVisible,
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
                                        color: Colors.red,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(
                                  height: 0,
                                  width: 0,
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
                              'Sign Up',
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white),
                            ),
                            onPressed: () {
                              signUp();
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
                                signUpWithGoogle();
                              },
                            ),
                          ),
                          // Center(
                          //   child: SignInButton(
                          //     Buttons.FacebookNew,
                          //     onPressed: () {},
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
                                    text: 'Alredy have an account?  ',
                                    children: [
                                      TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = widget.onClickedSignUp,
                                          text: 'Sign In',
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

  Future signUp() async {
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
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      navigatorKey.currentState
        ?..popUntil((route) => route.isFirst)
        ..pop();
      Utils.showSnackBar(
          'Welcome, ${FirebaseAuth.instance.currentUser?.email!}');
    } on FirebaseAuthException catch (e) {
      String exCode = e.code.toString();
      setState(() {
        if (exCode == 'invalid-email') {
          errorText = 'Email is invalid';
        } else if (exCode == 'email-already-in-use') {
          errorText = 'Email address is already in use by another account';
        }
      });
      navigatorKey.currentState!.pop();
    }
  }

  Future signUpWithGoogle() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(
          color: kGreenLightColor,
        ),
      ),
    );

    final googleSignIn = GoogleSignIn();

    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      await FirebaseAuth.instance.signInWithCredential(credential);

      navigatorKey.currentState
        ?..popUntil((route) => route.isFirst)
        ..pop();
      Utils.showSnackBar(
          'Welcome, ${FirebaseAuth.instance.currentUser?.email!}');
    } on FirebaseAuthException catch (e) {
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