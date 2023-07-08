import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../main.dart';
import '../models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import '../services/auth_service.dart';
import '../utils.dart';

class PasswordSheet extends StatefulWidget {
  const PasswordSheet({super.key});

  @override
  State<PasswordSheet> createState() => _PasswordSheetState();
}

class _PasswordSheetState extends State<PasswordSheet> {
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final newEmailController = TextEditingController();
  final emailController = TextEditingController();
  final pageViewController = PageController();
  String errorText1 = '';
  String errorText2 = '';
  late bool passwordVisible;

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
  }

  @override
  void dispose() {
    passwordController.dispose();
    newEmailController.dispose();
    emailController.dispose();
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = context.read<User?>();
    return Container(
      height: MediaQuery.of(context).size.height * .40 - 8,
      child: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageViewController,
        children: [
          Container(
            decoration: BoxDecoration(
              color: kBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      width: 300,
                      child: Form(
                        key: formKey1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'First, we need to verify your password',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontFamily: 'Montserrat'),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              readOnly: true,
                              // canRequestFocus: false,
                              controller: emailController..text = user!.email!,
                              cursorColor: kGreenLightColor,
                              decoration: InputDecoration(
                                labelText: 'Current Email',
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: kGreenLightColor),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              controller: passwordController,
                              // autofocus: true,
                              cursorColor: kGreenLightColor,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                hintText: 'Password',
                                labelText: 'Password',
                                floatingLabelStyle: TextStyle(
                                  color: kGreenLightColor,
                                ),
                                hintStyle: TextStyle(
                                  color: Colors.grey[600],
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: kGreenLightColor),
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
                              validator: (value) =>
                                  value != null && value.isEmpty
                                      ? 'Password is required'
                                      : null,
                              obscureText: !passwordVisible,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            errorText1.isNotEmpty
                                ? Center(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 10),
                                      child: Text(
                                        errorText1,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 14),
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
                                'Confirm Password',
                                style: TextStyle(
                                    fontSize: 24, color: Colors.white),
                              ),
                              onPressed: () async {
                                await reauthenticateUser(
                                    authService, user.email!);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: kBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      width: 300,
                      child: Form(
                        key: formKey2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Now, let\'s update the email associated with your account',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontFamily: 'Montserrat'),
                            ),
                            const SizedBox(height: 30),
                            TextFormField(
                                // autofocus: true,
                                controller: newEmailController,
                                cursorColor: kGreenLightColor,
                                decoration: InputDecoration(
                                  labelText: 'New Email',
                                  hintText: 'New Email',
                                  floatingLabelStyle: TextStyle(
                                    color: kGreenLightColor,
                                  ),
                                  hintStyle: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: kGreenLightColor),
                                  ),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (email) {
                                  if (email != null &&
                                      !EmailValidator.validate(email)) {
                                    return 'Enter a valid email';
                                  } else if (email == user.email) {
                                    return 'New email cannot match the old email';
                                  } else {
                                    return null;
                                  }
                                }),
                            SizedBox(
                              height: 5,
                            ),
                            errorText2.isNotEmpty
                                ? Center(
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 0, 0, 10),
                                      child: Text(
                                        errorText2,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 14),
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
                                'Update Email',
                                style: TextStyle(
                                    fontSize: 24, color: Colors.white),
                              ),
                              onPressed: () async {
                                await updateEmail(authService);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future reauthenticateUser(AuthService authService, String email) async {
    final isValid = formKey1.currentState!.validate();
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
      User? user = await authService.reauthenticateUser(
          email, passwordController.text.trim());
      pageViewController.animateToPage(pageViewController.page!.toInt() + 1,
          duration: Duration(milliseconds: 400), curve: Curves.easeIn);
      navigatorKey.currentState!.pop();
    } on auth.FirebaseAuthException catch (e) {
      String exCode = e.code.toString();
      setState(() {
        if (exCode == 'invalid-email' ||
            exCode == 'wrong-password' ||
            exCode == 'user-not-found') {
          errorText1 = 'Password is invalid';
        }
      });
      navigatorKey.currentState!.pop();
    }
  }

  Future updateEmail(AuthService authService) async {
    final isValid = formKey2.currentState!.validate();
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
      await authService.updateEmail(newEmailController.text.trim());
      navigatorKey.currentState!.pop();
      Utils.showSnackBar('Successfully updated email!', context);
    } on auth.FirebaseAuthException catch (e) {
      String exCode = e.code.toString();
      setState(() {
        if (exCode == 'invalid-email') {
          errorText2 = 'Email is invalid';
        } else if (exCode == 'email-already-in-use') {
          errorText2 = 'Email address is already in use by another account';
        }
      });
      navigatorKey.currentState!.pop();
    }
  }
}
