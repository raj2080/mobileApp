import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LoginButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    double textSize;
    double buttonWidth;
    double buttonHeight;

    if (screenWidth < 360) {
      textSize = 16.0;
      buttonWidth = screenWidth * 0.8;
      buttonHeight = 45;
    } else if (screenWidth < 600) {
      textSize = 18.0;
      buttonWidth = screenWidth * 0.7;
      buttonHeight = 50;
    } else {
      textSize = 20.0;
      buttonWidth = screenWidth * 0.6;
      buttonHeight = 55;
    }

    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0), // Smooth round edges
          ),
          elevation: 6, // Adds a soft shadow effect
        ),
        onPressed: onPressed,
        child: Ink(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF4CAF50), Color(0xFF087F23)], // Green gradient
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'Login',
              style: TextStyle(fontSize: textSize, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
