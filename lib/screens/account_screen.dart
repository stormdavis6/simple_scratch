import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as date;
import 'package:provider/provider.dart';
import 'package:simple_scratch/constants.dart';
import 'package:simple_scratch/widgets/update_email_sheet.dart';
import 'package:simple_scratch/widgets/update_password_sheet.dart';

import '../models/user.dart';
import '../services/auth_service.dart';
import '../utils.dart';

class AccountScreen extends StatefulWidget {
  final bool isPremium;
  AccountScreen({super.key, required this.isPremium});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final newEmailController = TextEditingController();
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final formatter = date.DateFormat('yMMMMd');

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    newEmailController.dispose();
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
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                        Center(
                          child: SizedBox(
                            width: 250,
                            child: TextFormField(
                              readOnly: true,
                              focusNode: AlwaysDisabledFocusNode(),
                              // canRequestFocus: false,
                              controller: emailController..text = user!.email!,
                              decoration: InputDecoration(
                                labelText: 'Email',
                                prefixIcon: user.providerId == 'password'
                                    ? IconButton(
                                        onPressed: () async {
                                          if (user.providerId == 'password') {
                                            await showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    kBackgroundColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(8),
                                                    topRight:
                                                        Radius.circular(8),
                                                  ),
                                                ),
                                                context: context,
                                                builder: (context) => Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: MediaQuery.of(
                                                                  context)
                                                              .viewInsets
                                                              .bottom),
                                                      child: UpdateEmailSheet(),
                                                    ));
                                          }
                                          // setState(() {});
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: kGreenLightColor,
                                        ),
                                      )
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            width: 250,
                            child: TextFormField(
                              obscureText: true,
                              readOnly: true,
                              focusNode: AlwaysDisabledFocusNode(),
                              initialValue: '********',
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: user.providerId == 'password'
                                    ? IconButton(
                                        onPressed: () async {
                                          if (user.providerId == 'password') {
                                            await showModalBottomSheet(
                                                isScrollControlled: true,
                                                backgroundColor:
                                                    kBackgroundColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(8),
                                                    topRight:
                                                        Radius.circular(8),
                                                  ),
                                                ),
                                                context: context,
                                                builder: (context) => Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: MediaQuery.of(
                                                                  context)
                                                              .viewInsets
                                                              .bottom),
                                                      child:
                                                          UpdatePasswordSheet(),
                                                    ));
                                          }
                                          // setState(() {});
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: kGreenLightColor,
                                        ),
                                      )
                                    : null,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            width: 250,
                            child: TextFormField(
                              readOnly: true,
                              focusNode: AlwaysDisabledFocusNode(),
                              initialValue:
                                  widget.isPremium ? 'Premium' : 'Non-Premium',
                              decoration: InputDecoration(
                                labelText: 'Subscription',
                                prefixIcon: IconButton(
                                  onPressed: () async {
                                    // setState(() {});
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: kGreenLightColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            width: 250,
                            child: TextFormField(
                              readOnly: true,
                              focusNode: AlwaysDisabledFocusNode(),
                              initialValue: user.creationTime != null
                                  ? formatter.format(user.creationTime!)
                                  : 'Date not found',
                              decoration: InputDecoration(
                                labelText: 'User Since',
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: SizedBox(
                            width: 250,
                            child: TextFormField(
                              readOnly: true,
                              focusNode: AlwaysDisabledFocusNode(),
                              initialValue: user.lastSignInTime != null
                                  ? formatter.format(user.creationTime!)
                                  : 'Date not found',
                              decoration: InputDecoration(
                                labelText: 'Last Sign In',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}