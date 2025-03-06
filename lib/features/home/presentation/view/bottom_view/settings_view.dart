import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../app/app.dart';
import '../../../../../core/shared_prefs/user_shared_prefs.dart';
import '../../../../auth/presentation/view/login_view.dart';
import '../pages/AccountSettingsPage.dart';
import '../pages/ContactUsPage.dart';
import '../pages/aboutus_View.dart';

final userSharedPrefsProvider = Provider<UserSharedPrefs>((ref) {
  return UserSharedPrefs();
});

class SettingsView extends ConsumerStatefulWidget {
  const SettingsView({super.key});

  @override
  ConsumerState<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends ConsumerState<SettingsView> {
  bool _notificationsEnabled = true;

  Future<void> _logout() async {
    final userSharedPrefs = ref.read(userSharedPrefsProvider);
    final result = await userSharedPrefs.deleteUserToken();
    result.fold(
          (failure) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error logging out: ${failure.error}')),
      ),
          (_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginView()),
        );
      },
    );
  }

  Future<void> _confirmLogout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Confirm Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
            style: TextButton.styleFrom(
              backgroundColor: Colors.grey[300],
              foregroundColor: Colors.black,
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Logout'),
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );

    if (shouldLogout == true) {
      _logout();
    }
  }


  @override
  Widget build(BuildContext context) {
    final themeNotifier = ref.watch(themeNotifierProvider);
    bool isDarkMode = themeNotifier.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade200,
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        children: [
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.deepPurple),
            title: const Text('Account Settings'),
            subtitle: const Text('Privacy, Security, Language'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AccountSettingsPage(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.notifications, color: Colors.deepPurple),
            title: const Text('Notifications'),
            subtitle: const Text('Email, Push notifications'),
            trailing: Switch(
              value: _notificationsEnabled,
              onChanged: (value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
              activeColor: Colors.deepPurple,
            ),
            onTap: () {
              setState(() {
                _notificationsEnabled = !_notificationsEnabled;
              });
            },
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.brightness_6, color: Colors.deepPurple),
            title: const Text('Dark Mode'),
            subtitle: const Text('Enable Dark Mode'),
            trailing: Switch(
              value: isDarkMode,
              onChanged: (value) {
                themeNotifier.toggleTheme(value);
              },
              activeColor: Colors.deepPurple,
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline, color: Colors.deepPurple),
            title: const Text('About Us'),
            subtitle: const Text('Learn more about our store'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutUsPage(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.contact_phone, color: Colors.deepPurple),
            title: const Text('Contact Us'),
            subtitle: const Text('Get in touch with us'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactUsPage(),
                ),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.deepPurple),
            title: const Text('Logout'),
            onTap: _confirmLogout,
          ),
          const SizedBox(height: 30),
          Center(
            child: Text(
              'Version 1.0.0',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }
}
