import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:blushstore_project/app/app.dart';
import 'package:blushstore_project/app/constants/app_constants.dart';
import 'package:flutter/services.dart';

void main() async {
  try {
    // Ensure Flutter is initialized
    WidgetsFlutterBinding.ensureInitialized();

    // Set preferred orientations
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Initialize Hive
    await Hive.initFlutter();

    // Open Hive boxes with error handling
    await Future.wait([
      Hive.openBox(AppConstants.userBox),
      Hive.openBox(AppConstants.productBox),
      Hive.openBox(AppConstants.cartBox),
      Hive.openBox(AppConstants.orderBox),
    ]).catchError((error) {
      debugPrint('Error opening Hive boxes: $error');
      // You might want to show an error dialog or handle the error appropriately
    });

    // Store initial app data
    final userBox = Hive.box(AppConstants.userBox);
    if (!userBox.containsKey('lastLoginTime')) {
      await userBox.put('lastLoginTime', '2025-03-04 06:54:31');
    }
    if (!userBox.containsKey('currentUser')) {
      await userBox.put('currentUser', '2025raj');
    }

    // Run the app
    runApp(
      const ProviderScope(
        child: MyApp(),
      ),
    );
  } catch (e, stackTrace) {
    debugPrint('Error initializing app: $e');
    debugPrint('Stack trace: $stackTrace');
    // You might want to show an error screen here
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('Error initializing app: $e'),
          ),
        ),
      ),
    );
  }
}

// Add this provider at the top level of your file
final initializationProvider = FutureProvider<void>((ref) async {
  try {
    // You can add more initialization logic here
    await Future.delayed(const Duration(seconds: 2)); // Simulated delay
    return;
  } catch (e) {
    throw Exception('Failed to initialize app: $e');
  }
});

// Optional: Add this class if you want to handle global app errors
class AppErrorBoundary extends StatelessWidget {
  final Widget child;

  const AppErrorBoundary({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, widget) {
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 48,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Something went wrong!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      errorDetails.exception.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Add restart app logic here if needed
                      },
                      child: const Text('Restart App'),
                    ),
                  ],
                ),
              ),
            ),
          );
        };
        return widget ?? const SizedBox.shrink();
      },
      home: child,
    );
  }
}