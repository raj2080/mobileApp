import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        backgroundColor: Colors.pinkAccent, // Blush tone color for branding
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pinkAccent, Colors.white], // Blush gradient background
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.03),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Get in Touch with Blush Store',
                  style: TextStyle(
                    fontSize: screenWidth * 0.08,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink[800],
                    fontFamily: 'Arial', // Elegant font for a clothing brand feel
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildContactInfo(
                        context,
                        icon: Icons.location_on,
                        title: 'Our Store Location',
                        content: 'Blush Store, Fashion Street, New York, USA',
                        color: Colors.pink[600]!,
                      ),
                      _buildDivider(),
                      _buildContactInfo(
                        context,
                        icon: Icons.phone,
                        title: 'Contact Number',
                        content: '+1 234 567 890',
                        color: Colors.green[700]!,
                      ),
                      _buildDivider(),
                      _buildContactInfo(
                        context,
                        icon: Icons.email,
                        title: 'Email Address',
                        content: 'support@blushstore.com',
                        color: Colors.blue[700]!,
                      ),
                      SizedBox(height: screenHeight * 0.03),
                    ],
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Center(
                child: Text(
                  'Follow Us On Social Media',
                  style: TextStyle(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink[800],
                    fontFamily: 'Arial',
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialMediaIcon(context, Icons.facebook, 'https://facebook.com/blushstore'),
                  _buildSocialMediaIcon(context, LucideIcons.instagram, 'https://instagram.com/blushstore'),
                  _buildSocialMediaIcon(context, LucideIcons.twitter, 'https://twitter.com/blushstore'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactInfo(
    BuildContext context, {
    IconData? icon,
    String? title,
    String? content,
    required Color color,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: () async {
        if (title == 'Contact Number') {
          final Uri launch = Uri(scheme: 'tel', path: content);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Launching phone dialer')));
          await launchUrl(launch);
        } else if (title == 'Email Address') {
          String? encodeQueryParameters(Map<String, String> params) {
            return params.entries
                .map((MapEntry<String, String> e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                .join('&');
          }

          final Uri emailLaunchUri = Uri(
            scheme: 'mailto',
            path: content,
            query: encodeQueryParameters(<String, String>{'subject': 'Inquiry about Blush Store Products'}),
          );

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Launching email app')));

          await launchUrl(emailLaunchUri);
        } else if (title == 'Our Store Location') {
          final Uri launch = Uri(scheme: 'geo', path: '0,0', queryParameters: {'q': content});
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Opening map')));
          await launchUrl(launch);
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: color, size: screenWidth * 0.06),
            SizedBox(width: screenWidth * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title!,
                    style: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold, color: color),
                  ),
                  SizedBox(height: 4),
                  Text(content!, style: TextStyle(fontSize: screenWidth * 0.04, color: Colors.grey[700])),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 32, color: Colors.grey[300], thickness: 1);
  }

  Widget _buildSocialMediaIcon(BuildContext context, IconData icon, String url) {
    return GestureDetector(
      onTap: () async {
        final Uri launch = Uri.parse(url);
        if (await canLaunch(launch.toString())) {
          await launchUrl(launch);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Unable to launch $url')));
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.pink[200],
          child: Icon(icon, color: Colors.white, size: 30),
        ),
      ),
    );
  }
}
