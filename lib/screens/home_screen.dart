import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Center(
              child: TextButton(
                onPressed: () {
                  context.go('/camera-preview');
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => const CameraPreviewScreen(),
                  //   ),
                  // );
                },
                child: const Text("Start camera test"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
