import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';

import 'package:thread_clone/constants/gaps.dart';
import 'package:thread_clone/constants/sizes.dart';

class TakePhotoScreen extends StatefulWidget {
  const TakePhotoScreen({super.key});

  @override
  State<TakePhotoScreen> createState() => _TakePhotoScreenState();
}

class _TakePhotoScreenState extends State<TakePhotoScreen>
    with WidgetsBindingObserver {
  final List<FlashMode> _flashModes = [
    FlashMode.off,
    FlashMode.auto,
    FlashMode.always,
    FlashMode.torch,
  ];
  final List<IconData> _flashIcons = [
    Icons.flash_off_rounded,
    Icons.flash_auto_rounded,
    Icons.flashlight_on_rounded,
    Icons.flash_on_rounded,
  ];
  bool _hasPermission = false;
  bool _isSelfieMode = false;

  late int _flashModeIndex = 0;
  late CameraController _cameraController;

  Future<void> initCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) {
      return;
    }

    _cameraController = CameraController(
      cameras[_isSelfieMode ? 1 : 0],
      ResolutionPreset.high,
    );
    await _cameraController.initialize();
  }

  Future<void> initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDenied || !micDenied) {
      _hasPermission = true;
      await initCamera();
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    initPermissions();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (!_hasPermission) return;
    if (!_cameraController.value.isInitialized) return;

    if (state == AppLifecycleState.resumed) {
      await initCamera();
      setState(() {});
    } else if (state == AppLifecycleState.inactive) {
      _cameraController.dispose();
    }
  }

  Future<void> _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
    setState(() {});
  }

  Future<void> _rotateFlashMode() async {
    _flashModeIndex = (_flashModeIndex + 1) % _flashModes.length;
    final newFlashMode = _flashModes[_flashModeIndex];
    await _cameraController.setFlashMode(newFlashMode);
    setState(() {});
  }

  Future<void> _takePicture() async {
    final pictureFile = await _cameraController.takePicture();
    if (!mounted) return;

    Navigator.pop(context, pictureFile);
  }

  Future<void> _onPickImagePressed() async {
    final pictureFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pictureFile == null) return;
    if (!mounted) return;

    Navigator.pop(context, pictureFile);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: !_hasPermission || !_cameraController.value.isInitialized
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Requesting permissions...",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Sizes.size20,
                        ),
                      ),
                      Gaps.v20,
                      CircularProgressIndicator.adaptive(
                        backgroundColor: Colors.white,
                      ),
                    ],
                  )
                : Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height - 100,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(20),
                          ),
                        ),
                        child: CameraPreview(_cameraController),
                      ),
                      Positioned(
                        width: MediaQuery.of(context).size.width,
                        bottom: Sizes.size40,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: IconButton(
                                  onPressed: () => _rotateFlashMode(),
                                  icon: Icon(
                                    _flashIcons[_flashModeIndex],
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: _takePicture,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  const SizedBox(
                                    height: Sizes.size80 + Sizes.size14,
                                    width: Sizes.size80 + Sizes.size14,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: Sizes.size4,
                                      value: 1,
                                    ),
                                  ),
                                  Container(
                                    height: Sizes.size80,
                                    width: Sizes.size80,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: IconButton(
                                    onPressed: _toggleSelfieMode,
                                    icon: const FaIcon(
                                      FontAwesomeIcons.arrowsRotate,
                                      color: Colors.white,
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        left: Sizes.size10,
                        top: Sizes.size32,
                        child: IconButton(
                          onPressed: () {},
                          icon: const FaIcon(
                            FontAwesomeIcons.chevronLeft,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  "Camera",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                GestureDetector(
                  onTap: _onPickImagePressed,
                  child: Text(
                    "Library",
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: Sizes.size20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
