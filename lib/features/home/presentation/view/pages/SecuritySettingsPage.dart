import 'package:flutter/material.dart';

import 'ChangePasswordPage.dart';

class SecuritySettingsPage extends StatefulWidget {
  const SecuritySettingsPage({super.key});

  @override
  _SecuritySettingsPageState createState() => _SecuritySettingsPageState();
}

class _SecuritySettingsPageState extends State<SecuritySettingsPage> {
  bool isFingerprintEnabled = true;
  bool isTwoFactorEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Security Settings', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Security Options', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.fingerprint, color: Colors.deepPurple),
              title: const Text('Fingerprint'),
              subtitle: const Text('Enable fingerprint authentication'),
              trailing: Switch(
                value: isFingerprintEnabled,
                onChanged: (bool value) {
                  setState(() {
                    isFingerprintEnabled = value;
                  });
                },
                activeColor: Colors.deepPurple,
              ),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.lock, color: Colors.deepPurple),
              title: const Text('Change Password'),
              subtitle: const Text('Update your account password'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePasswordPage()));
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.phone_android, color: Colors.deepPurple),
              title: const Text('Two-Factor Authentication'),
              subtitle: const Text('Enhance account security'),
              trailing: Switch(
                value: isTwoFactorEnabled,
                onChanged: (bool value) {
                  setState(() {
                    isTwoFactorEnabled = value;
                  });
                },
                activeColor: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
