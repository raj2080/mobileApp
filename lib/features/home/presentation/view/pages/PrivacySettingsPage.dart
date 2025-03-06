import 'package:flutter/material.dart';

class PrivacySettingsPage extends StatefulWidget {
  const PrivacySettingsPage({super.key});

  @override
  _PrivacySettingsPageState createState() => _PrivacySettingsPageState();
}

class _PrivacySettingsPageState extends State<PrivacySettingsPage> {
  // State variables for each switch
  bool _shareLocation = true;
  bool _shareActivity = false;
  bool _dataUsage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Privacy Settings', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Privacy Preferences',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
            const SizedBox(height: 20),
            _buildPrivacyOption(
              title: 'Share Location',
              description: 'Allow the app to access your location for better personalized recommendations.',
              value: _shareLocation,
              onChanged: (bool value) {
                setState(() {
                  _shareLocation = value;
                });
              },
            ),
            const Divider(),
            _buildPrivacyOption(
              title: 'Share Activity',
              description: 'Allow the app to track your activity for personalized offers and rewards.',
              value: _shareActivity,
              onChanged: (bool value) {
                setState(() {
                  _shareActivity = value;
                });
              },
            ),
            const Divider(),
            _buildPrivacyOption(
              title: 'Data Usage',
              description: 'Allow the app to use data in the background to keep content up to date.',
              value: _dataUsage,
              onChanged: (bool value) {
                setState(() {
                  _dataUsage = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrivacyOption({
    required String title,
    required String description,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
      leading: Icon(
        value ? Icons.lock_open : Icons.lock_outline,
        color: Colors.deepPurple,
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      subtitle: Text(
        description,
        style: const TextStyle(fontSize: 14, color: Colors.black54),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: Colors.deepPurple,
      ),
    );
  }
}
