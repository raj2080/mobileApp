import 'package:flutter/material.dart';

class NoContentPage extends StatelessWidget {
  // final Future<void> Function() onRefresh;

  const NoContentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('No Content'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.warning,
                size: 80.0,
                color: Colors.amber,
              ),
              SizedBox(height: 20.0),
              Text(
                'No Content Available',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                'Sorry, we couldn\'t find any content here. Please check back later.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.purple.shade200,
                ),
              ),
              SizedBox(height: 20.0),

            ],
          ),
        ),
      ),
    );
  }
}
