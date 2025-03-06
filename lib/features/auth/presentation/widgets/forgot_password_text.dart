import 'package:flutter/material.dart';

class ForgotPasswordText extends StatelessWidget {
  const ForgotPasswordText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen width
    final screenWidth = MediaQuery.of(context).size.width;

    // Define text size based on screen width
    double textSize;
    if (screenWidth < 360) {
      textSize = 14.0;
    } else if (screenWidth < 600) {
      textSize = 16.0;
    } else {
      textSize = 18.0;
    }

    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {
          // Handle forgot password
        },
        child: Text(
          'Forgot Password?',
          style: TextStyle(
            color: Colors.purple,
            decoration: TextDecoration.underline,
            decorationColor: Colors.purpleAccent,
            fontSize: textSize,
          ),
        ),
      ),
    );
  }
}
