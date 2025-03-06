import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/shared_prefs/user_shared_prefs.dart';
import '../../../auth/presentation/view/login_view.dart';
import '../../../home/presentation/view/home_view.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 2))..forward();
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));
    Future.delayed(const Duration(seconds: 3), _navigateToNextScreen);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToNextScreen() async {
    final userSharedPrefs = ref.read(userSharedPrefsProvider);
    final result = await userSharedPrefs.getUserToken();
    result.fold((failure) => _goToLogin(), (token) => token != null && token.isNotEmpty ? _goToHome() : _goToLogin());
  }

  void _goToLogin() =>
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const LoginView()));
  void _goToHome() => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const HomeView()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset('assets/image/logo.png', width: MediaQuery.of(context).size.width * 0.4),
                const SizedBox(height: 20),
                const Text(
                  'Exclusive Fashion',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: Colors.black),
                ),
                const SizedBox(height: 20),
                const CircularProgressIndicator(color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
