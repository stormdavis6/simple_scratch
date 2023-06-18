import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class RegisterWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const RegisterWidget({Key? key, required this.onClickedSignUp})
      : super(key: key);

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailConfirmController = TextEditingController();
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
    emailConfirmController.dispose();
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome!',
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
                        TextField(
                          controller: emailController,
                          cursorColor: kGreenLightColor,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: kGreenLightColor),
                            ),
                          ),
                          onChanged: (string) {},
                        ),
                        TextField(
                          controller: emailConfirmController,
                          cursorColor: kGreenLightColor,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            hintText: 'Confirm Email',
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: kGreenLightColor),
                            ),
                          ),
                          onChanged: (string) {},
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
                          ),
                          onChanged: (string) {},
                          obscureText: true,
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
                            'Sign Up',
                            style: TextStyle(fontSize: 24, color: Colors.white),
                          ),
                          onPressed: () {},
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
}