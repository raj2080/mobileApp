import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Define responsive sizes
    double imageHeight;
    double titleFontSize;
    double subtitleFontSize;
    double descriptionFontSize;

    if (screenWidth < 360) {
      imageHeight = 120;
      titleFontSize = 24.0;
      subtitleFontSize = 18.0;
      descriptionFontSize = 14.0;
    } else if (screenWidth < 600) {
      imageHeight = 150;
      titleFontSize = 28.0;
      subtitleFontSize = 22.0;
      descriptionFontSize = 16.0;
    } else {
      imageHeight = 180;
      titleFontSize = 32.0;
      subtitleFontSize = 24.0;
      descriptionFontSize = 18.0;
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0), // Add padding to avoid edge issues
        child: Column(
          mainAxisSize: MainAxisSize.min, // Minimize column size to prevent overflow
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center, // Center content horizontally
          children: <Widget>[
            Image.asset(
              'assets/image/logo.png',
              height: imageHeight,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                // Placeholder image if the asset is not found
                return Icon(Icons.error, size: imageHeight, color: Colors.red);
              },
            ),
            SizedBox(height: screenHeight * 0.03), // Dynamic spacing
            Text(
              'Blush Store',
              style: TextStyle(
                fontFamily: "OpenSans-Bold",
                fontSize: titleFontSize,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: screenHeight * 0.01), // Dynamic spacing
            Text(
              'Hello! User',
              style: TextStyle(fontSize: subtitleFontSize, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: screenHeight * 0.01), // Dynamic spacing
            Text(
              'Please login with your account to continue.',
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: descriptionFontSize, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
