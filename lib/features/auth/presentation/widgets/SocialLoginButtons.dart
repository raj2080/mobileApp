import 'package:flutter/material.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen width
    final screenWidth = MediaQuery.of(context).size.width;

    // Define responsive values
    double iconSize;
    double fontSize;
    EdgeInsetsGeometry padding;

    if (screenWidth < 360) {
      iconSize = 20.0;
      fontSize = 14.0;
      padding = const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0);
    } else if (screenWidth < 600) {
      iconSize = 24.0;
      fontSize = 16.0;
      padding = const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0);
    } else {
      iconSize = 28.0;
      fontSize = 18.0;
      padding = const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0);
    }

    return Column(
      children: [
        _buildSocialLoginButton(
          onPressed: () {
            // Handle Google login
          },
          assetPath: 'assets/icon/google.png',
          text: 'Sign in with Google',
          iconSize: iconSize,
          fontSize: fontSize,
          padding: padding,
        ),
        const SizedBox(height: 8.0),
        _buildSocialLoginButton(
          onPressed: () {
            // Handle Apple ID login
          },
          assetPath: 'assets/icon/apple.png',
          text: 'Sign in with Apple ID',
          iconSize: iconSize,
          fontSize: fontSize,
          padding: padding,
        ),
        const SizedBox(height: 8.0),
        _buildSocialLoginButton(
          onPressed: () {
            // Handle Facebook login
          },
          assetPath: 'assets/icon/facebook.png',
          text: 'Sign in with Facebook',
          iconSize: iconSize,
          fontSize: fontSize,
          padding: padding,
        ),
      ],
    );
  }

  Widget _buildSocialLoginButton({
    required VoidCallback onPressed,
    required String assetPath,
    required String text,
    required double iconSize,
    required double fontSize,
    required EdgeInsetsGeometry padding,
  }) {
    return SizedBox(
      width: double.infinity,
      child: TextButton.icon(
        onPressed: onPressed,
        icon: Image.asset(assetPath, height: iconSize, width: iconSize),
        label: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            color: Colors.black,
          ),
        ),
        style: TextButton.styleFrom(
          padding: padding,
          backgroundColor: Colors.grey[200],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}
