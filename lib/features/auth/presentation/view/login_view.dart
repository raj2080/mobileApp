import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../home/presentation/view/home_view.dart';
import '../viewmodel/auth_view_model.dart';
import '../widgets/LoginButton.dart';
import '../widgets/LoginForm.dart';
import '../widgets/LoginHeader.dart';
import '../widgets/SocialLoginButtons.dart';
import '../widgets/forgot_password_text.dart';
import '../widgets/sign_up_text.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final List<StreamSubscription<dynamic>> _streamSubscriptions = [];
  @override
  void initState() {
    super.initState();
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final success = await ref
          .read(authViewModelProvider.notifier)
          .loginUser(_emailController.text, _passwordController.text);
      print('Login success: $success');

      if (success) {
        print('Navigating to HomeView');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeView()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    double headerHeight;
    double buttonWidth;
    EdgeInsetsGeometry padding;
    double formSpacing;
    double textSpacing;

    if (screenWidth < 360) {
      headerHeight = 120.0;
      buttonWidth = screenWidth * 0.8;
      padding = const EdgeInsets.all(12.0);
      formSpacing = 12.0;
      textSpacing = 12.0;
    } else if (screenWidth < 600) {
      headerHeight = 300.0;
      buttonWidth = screenWidth * 0.8;
      padding = const EdgeInsets.all(16.0);
      formSpacing = 16.0;
      textSpacing = 16.0;
    } else {
      headerHeight = 180.0;
      buttonWidth = screenWidth * 0.6;
      padding = const EdgeInsets.all(24.0);
      formSpacing = 20.0;
      textSpacing = 20.0;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: padding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: screenHeight * 0.03),
              SizedBox(height: headerHeight, child: const LoginHeader()),
              SizedBox(height: screenHeight * 0.02),
              LoginForm(emailController: _emailController, passwordController: _passwordController, formKey: _formKey),
              SizedBox(height: textSpacing),
              SizedBox(width: buttonWidth, child: LoginButton(onPressed: _login)),
              SizedBox(height: screenHeight * 0.01),
              const ForgotPasswordText(),
              SizedBox(height: textSpacing),
              const SocialLoginButtons(),
              SizedBox(height: textSpacing),
              const SignUpText(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }
}
