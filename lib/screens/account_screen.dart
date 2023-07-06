import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_scratch/constants.dart';

import '../models/user.dart';
import '../services/auth_service.dart';

class AccountScreen extends StatefulWidget {
  final bool isPremium;
  const AccountScreen({super.key, required this.isPremium});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    emailController.text = auth.FirebaseAuth.instance.currentUser!.email!;
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final user = context.watch<User?>();
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
                            'Account Settings',
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
                          'Account Settings',
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
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Welcome, ${user?.email}',
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                fontFamily: 'Montserrat'),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Update your account information',
                            style: TextStyle(
                                fontSize: 23,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Montserrat'),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  readOnly: true,
                                  controller: emailController,
                                  cursorColor: kGreenLightColor,
                                  textInputAction: TextInputAction.next,
                                  decoration: InputDecoration(
                                    hintText: 'Email',
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: kGreenLightColor),
                                    ),
                                  ),
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  validator: (email) => email != null &&
                                          !EmailValidator.validate(email)
                                      ? 'Enter a valid email'
                                      : null,
                                  onChanged: (string) {},
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              RichText(
                                text: TextSpan(
                                    style: TextStyle(
                                        color: kBlackLightColor, fontSize: 16),
                                    children: [
                                      TextSpan(
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {},
                                          text: 'Edit',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: kGreenLightColor))
                                    ]),
                              ),
                            ],
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
      ),
    );
  }
}