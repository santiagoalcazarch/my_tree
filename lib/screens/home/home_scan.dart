import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_tree/screens/style/text_style.dart';
import 'package:my_tree/screens/utils/navigator.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';

import 'scan_result.dart';

class TakePictureScreen extends StatefulWidget {
  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {

  CameraDescription camera;
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  /* ***********************     Funciones     ******************** */
  @override
  void initState() {
    loadCamera();
    super.initState();
  }

  Future loadCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _controller = CameraController( firstCamera, ResolutionPreset.ultraHigh);
    _initializeControllerFuture = _controller.initialize();
  }

  Future takePicture() async {
    try {
      await _initializeControllerFuture;
      String path = (await getTemporaryDirectory()).path;
      final imagePath = join(path, '${DateTime.now()}.png' );
      await _controller.takePicture(imagePath);
      navigateTo( ScanResults(imagePath: imagePath), context);
    } catch (e) {
      print(e);
    }
  }

  Future selectFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if ( pickedFile != null ){
      navigateTo( ScanResults(imagePath: pickedFile.path), context);
    }
  }

  /* ***********************     Widgets     ******************** */

  Widget cameraPreview(){
    return Stack(
      overflow: Overflow.visible,
      children: [
        Column(
          children: [
            Expanded(child: CameraPreview(_controller))
          ],
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: SvgPicture.asset(
              'assets/screens/base-dos.svg',
              fit: BoxFit.cover,
            ),
          ),
        )
      ],
    );
  }

  Widget body(){
    return FutureBuilder(
      future: loadCamera(),
      builder: (context, snapshot) {
        return FutureBuilder(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return cameraPreview();
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        );
      }
    );
  }

  Widget floutingBottom( IconData icon, Function onTap ){
    return Container(
      margin: EdgeInsets.only(bottom: 60 ),
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Color(0xFFC0D0C5),
        shape: BoxShape.circle
      ),
      child: InkWell(
        child: Icon(icon, color: Color(0xFF0C3D00)),
        onTap: onTap,
      ),
    );
  }

  Widget floutingMenu(){
    return Padding(
      padding: const EdgeInsets.only( left: 35 ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          floutingBottom( Icons.photo, selectFromGallery ),
          floutingBottom( Icons.camera_alt_outlined, takePicture ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Toma una foto',
          style: getTextStyle(false, 19, 'b', Color(0xFF388125)),
        ),
        automaticallyImplyLeading: false,
      ),
      body: body(),
      floatingActionButton: floutingMenu()
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}