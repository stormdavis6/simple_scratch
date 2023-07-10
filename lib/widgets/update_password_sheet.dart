import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import '../constants.dart';
import '../main.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import '../utils.dart';

class UpdatePasswordSheet extends StatefulWidget {
  const UpdatePasswordSheet({super.key});

  @override
  State<UpdatePasswordSheet> createState() => _UpdatePasswordSheetState();
}

class _UpdatePasswordSheetState extends State<UpdatePasswordSheet> {
  final formKey1 = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final newPasswordConfirmController = TextEditingController();
  final emailController = TextEditingController();
  final pageViewController = PageController();
  String errorText1 = '';
  String errorText2 = '';
  late bool passwordVisible;
  late bool newPasswordVisible;
  late bool newPasswordConfirmVisible;

  @override
  void initState() {
    passwordVisible = newPasswordVisible = newPasswordConfirmVisible = false;
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    newPasswordController.dispose();
    newPasswordConfirmController.dispose();
    emailController.dispose();
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = context.read<User?>();
    return SizedBox(
      height: MediaQuery.of(context).size.height * .40 - 8,
      child: PageView(
        physics: const NeverScrollableScrollPhysics(),
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
                              'First, we need to verify your current password',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontFamily: 'Montserrat'),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              readOnly: true,
                              canRequestFocus: false,
                              controller: emailController..text = user!.email!,
                              cursorColor: kGreenLightColor,
                              decoration: InputDecoration(
                                labelText: 'Email',
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
                              'Now, set a new password',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontFamily: 'Montserrat'),
                            ),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: newPasswordController,
                              cursorColor: kGreenLightColor,
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                hintText: 'New Password',
                                labelText: 'New Password',
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
                                    newPasswordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey[700],
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      newPasswordVisible = !newPasswordVisible;
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
                                } else if (value == passwordController.text) {
                                  return 'New password cannot match the old password';
                                } else {
                                  return null;
                                }
                              },
                              obscureText: !newPasswordVisible,
                            ),
                            TextFormField(
                              controller: newPasswordConfirmController,
                              cursorColor: kGreenLightColor,
                              textInputAction: TextInputAction.done,
                              decoration: InputDecoration(
                                hintText: 'Confirm New Password',
                                labelText: 'Confirm New Password',
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
                                    newPasswordConfirmVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.grey[700],
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      newPasswordConfirmVisible =
                                          !newPasswordConfirmVisible;
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
                                } else if (value !=
                                    newPasswordConfirmController.text) {
                                  return 'Passwords must match';
                                } else if (value == passwordController.text) {
                                  return 'New password cannot match the old password';
                                } else {
                                  return null;
                                }
                              },
                              onChanged: (string) {},
                              obscureText: !newPasswordConfirmVisible,
                            ),
                            SizedBox(
                              height: 20,
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
                                'Update Password',
                                style: TextStyle(
                                    fontSize: 24, color: Colors.white),
                              ),
                              onPressed: () async {
                                await updatePassword(authService);
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
            exCode == 'user-not-found' ||
            exCode == 'user-mismatch' ||
            exCode == 'invalid-credential') {
          errorText1 = 'Password is invalid';
        } else if (e.code == 'too-many-requests') {
          errorText1 =
              'Access to this account has been temporarily disabled due to many failed login attempts. You can immediately restore it by resetting your password or you can try again later.';
        } else {
          errorText1 = 'Something went wrong, please try again later';
        }
      });
      navigatorKey.currentState!.pop();
    }
  }

  Future updatePassword(AuthService authService) async {
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
      await authService.updatePassword(newPasswordController.text.trim());
      navigatorKey.currentState!.pop();
      navigatorKey.currentState!.pop();
      Utils.showSnackBar('Successfully updated password!', context);
    } on auth.FirebaseAuthException catch (e) {
      String exCode = e.code.toString();
      setState(() {
        if (exCode == 'weak-password') {
          errorText2 = 'New password is too weak';
        } else {
          errorText2 = 'Something went wrong, please try again later';
        }
      });
      navigatorKey.currentState!.pop();
    }
  }
}