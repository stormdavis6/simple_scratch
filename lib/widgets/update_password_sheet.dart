import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class UpdatePasswordSheet extends StatefulWidget {
  const UpdatePasswordSheet({super.key});

  @override
  State<UpdatePasswordSheet> createState() => _UpdatePasswordSheetState();
}

class _UpdatePasswordSheetState extends State<UpdatePasswordSheet> {
  final formKey = GlobalKey<FormState>();
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final newPasswordConfirmController = TextEditingController();
  String errorText = '';
  late bool currentPasswordVisible;
  late bool newPasswordVisible;
  late bool newPasswordConfirmVisible;

  @override
  void initState() {
    currentPasswordVisible =
        newPasswordVisible = newPasswordConfirmVisible = false;
    super.initState();
  }

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    newPasswordConfirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = context.read<User?>();
    return Container(
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
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Change Password',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontFamily: 'Montserrat'),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: currentPasswordController,
                        cursorColor: kGreenLightColor,
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                          labelText: 'Current Password',
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kGreenLightColor),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              currentPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey[700],
                            ),
                            onPressed: () {
                              setState(() {
                                currentPasswordVisible =
                                    !currentPasswordVisible;
                              });
                            },
                          ),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => value != null && value.isEmpty
                            ? 'Password is required'
                            : null,
                        obscureText: !currentPasswordVisible,
                      ),
                      SizedBox(
                        height: 5,
                      ),
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
                            borderSide: BorderSide(color: kGreenLightColor),
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) => value != null && value.isEmpty
                            ? 'Password is required'
                            : null,
                        obscureText: !newPasswordVisible,
                      ),
                      TextFormField(
                        controller: newPasswordConfirmController,
                        cursorColor: kGreenLightColor,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          hintText: 'Confirm New Password',
                          labelText: 'New Password',
                          floatingLabelStyle: TextStyle(
                            color: kGreenLightColor,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.grey[600],
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kGreenLightColor),
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value != null && value.isEmpty) {
                            return 'Password is required';
                          } else if (value!.length < 6) {
                            return 'Password must be at least 6 characters';
                          } else if (value !=
                              newPasswordConfirmController.text) {
                            return 'Passwords must match';
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
                      errorText.isNotEmpty
                          ? Center(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                                child: Text(
                                  errorText,
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
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                        onPressed: () async {
                          // await reauthenticateUser(
                          //     authService, user.email!);
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
    );
  }
}
