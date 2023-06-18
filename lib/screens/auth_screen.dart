import 'package:flutter/material.dart';
import 'package:simple_scratch/widgets/login_widget.dart';

import '../widgets/register_widget.dart';

class AuthScreen extends StatefulWidget {
  final bool isLogin;
  const AuthScreen({Key? key, required this.isLogin}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late bool isLogin;

  @override
  void initState() {
    isLogin = widget.isLogin;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLogin
        ? LoginWidget(onClickedSignUp: toggle)
        : RegisterWidget(onClickedSignUp: toggle);
  }

  void toggle() => setState(() => isLogin = !isLogin);
}
