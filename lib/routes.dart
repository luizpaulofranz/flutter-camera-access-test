import 'package:camera_access_test/screens/camera_preview.dart';
import 'package:camera_access_test/screens/home_screen.dart';
import 'package:camera_access_test/screens/image_preview.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter goRouter = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: "/camera-preview",
      builder: (context, state) => const CameraPreviewScreen(),
    ),
    GoRoute(
      path: "/image-preview",
      name: "image-preview",
      pageBuilder: (context, state) {
        return MaterialPage<void>(
          key: state.pageKey,
          name: state.name,
          child: ImagePreviewScreen(
            imagePath: state.uri.queryParameters['imagePath']!,
          ),
        );
      },
    ),
  ],
);
