import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ImagePreviewScreen extends StatefulWidget {
  final String imagePath;
  const ImagePreviewScreen({super.key, required this.imagePath});

  @override
  State<ImagePreviewScreen> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreviewScreen> {
  @override
  Widget build(BuildContext context) {
    final imageFile = XFile(widget.imagePath);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: SizedBox(
              width: double.maxFinite,
              child: FutureBuilder(
                future: imageFile.readAsBytes(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Image.memory(snapshot.data!);
                  }

                  return const CircularProgressIndicator();
                },
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(
              width: double.maxFinite,
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20).copyWith(bottom: 0),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Text(
                            "Is the picture ok?",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            context.pop();
                          },
                          child: const Text("No, retake"),
                        ),
                        TextButton(
                          onPressed: () {
                            context.push('/camera-preview');
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) =>
                            //         const CameraPreviewScreen(),
                            //   ),
                            // );
                          },
                          child: const Text("Yes, looks good"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
