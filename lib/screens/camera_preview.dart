import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CameraPreviewScreen extends StatefulWidget {
  const CameraPreviewScreen({super.key});

  @override
  State<CameraPreviewScreen> createState() => _CameraPreviewScreenState();
}

class _CameraPreviewScreenState extends State<CameraPreviewScreen> {
  CameraController? _cameraController;

  @override
  void initState() {
    super.initState();
    _startCamera();
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  void _startCamera() async {
    print("Starting Cameras");
    final start = DateTime.now().millisecondsSinceEpoch;
    final cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      final cameraDescription = cameras.firstWhere((camera) {
        return camera.lensDirection == CameraLensDirection.back;
      }, orElse: () => cameras.first);

      _cameraController = CameraController(
        cameraDescription,
        ResolutionPreset.veryHigh,
        enableAudio: false,
        imageFormatGroup: ImageFormatGroup.yuv420,
      );

      _cameraController!.initialize().then((_) {
        final stop = DateTime.now().millisecondsSinceEpoch;
        if (!mounted) {
          return;
        }
        print("Time taken to initialize the cameras: ${stop - start}");
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   content:
        //       Text("Time taken to initialize the cameras: ${stop - start}"),
        // ));
        setState(() {});
      }).catchError((Object e) {
        if (e is CameraException) {
          switch (e.code) {
            case 'CameraAccessDenied':
              // Handle access errors here.
              break;
            default:
              // Handle other errors here.
              break;
          }
        }
      });
    }
  }

  void _takePicture() async {
    final imageFile = await _cameraController?.takePicture();
    if (imageFile != null) {
      context.pushNamed('image-preview',
          queryParameters: {"imagePath": imageFile.path});

      // final imageBytes = await imageFile.readAsBytes();

      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (context) => ImagePreviewScreen(
      //       imageBytes: imageBytes,
      //     ),
      //   ),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Here's camera preview.",
            ),
            Expanded(
              child: _cameraController == null
                  ? Text(
                      'Camera not started',
                      style: Theme.of(context).textTheme.headlineMedium,
                    )
                  : CameraPreview(_cameraController!),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _takePicture,
        tooltip: 'Start Camera',
        child: const Icon(Icons.camera),
      ),
    );
  }
}
