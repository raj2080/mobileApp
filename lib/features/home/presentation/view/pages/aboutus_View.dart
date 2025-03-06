import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text('About Us', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(
                'assets/image/logo.png',
                width: screenWidth * 0.6,
                height: screenHeight * 0.2,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Welcome to Blush Store!',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.pinkAccent),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            const Text(
              'Blush Store is more than just a clothing brand; it’s a statement of confidence, elegance, and style. We bring you the latest fashion trends with a touch of sophistication and comfort, ensuring you always look and feel your best.',
              style: TextStyle(fontSize: 16, height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.pinkAccent),
            const SizedBox(height: 20),
            const Text(
              'Our Vision',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.pinkAccent),
            ),
            const SizedBox(height: 10),
            const Text(
              'To redefine fashion with pieces that inspire confidence and individuality while being affordable and high-quality.',
              style: TextStyle(fontSize: 16, height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.pinkAccent),
            const SizedBox(height: 20),
            const Text(
              'Get in Touch',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.pinkAccent),
            ),
            const SizedBox(height: 10),
            const Text(
              '📧 Email: support@blushstore.com\n📞 Phone: +1 234 567 890\n📍 Address: 456 Fashion Avenue, Trendy City, USA',
              style: TextStyle(fontSize: 16, height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Text(
              '© 2025 Blush Store',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
