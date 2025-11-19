import 'package:Bynona/core/config/app_colors.dart';
import 'package:Bynona/features/auth/presentation/widgets/auth_header.dart';
import 'package:Bynona/features/auth/presentation/widgets/login_form.dart';
import 'package:Bynona/features/auth/presentation/widgets/signup_form.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  final bool startWithLogin;

  const AuthScreen({super.key, this.startWithLogin = true});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late bool isLogin;

  @override
  void initState() {
    super.initState();
    isLogin = widget.startWithLogin;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          YellowHeader(
            isLogin: isLogin,
            onTabChanged: (value) {
              setState(() {
                isLogin = value;
              });
            },
          ),
          Expanded(child: isLogin ? const LoginForm() : const SignupForm()),
        ],
      ),
    );
  }
}
