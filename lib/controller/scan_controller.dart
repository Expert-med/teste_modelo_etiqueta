import 'dart:io';

import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ScanController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    initTflite();
  }

  
  late File imageFile;
  var label = "";
  var prediction = "";

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      imageFile = File(pickedImage.path);
      objectDetector();
    }
  }

  initTflite() async {
    await Tflite.loadModel(
      model: "assets/model.tflite",
      labels: "assets/labels.txt",
      isAsset: true,
      numThreads: 1,
      useGpuDelegate: false,
    );
  }

  objectDetector() async {
    var detector = await Tflite.runModelOnImage(
      path: imageFile.path,
      imageMean: 127.5,
      imageStd: 127.5,
      threshold: 0.4,
    );

    if (detector != null && detector.isNotEmpty) {
      var ourDetectedObject = detector.first;
      print(ourDetectedObject);
      print('entrei');
      
    
      if (ourDetectedObject['confidence'] * 100 >  60) {
        print('MAIOR');
        label = ourDetectedObject['label'].toString();
        prediction = (ourDetectedObject['confidence'] * 100).toStringAsFixed(2) + '%';
        update();
      }else{
        label = 'Insira outra imagem';
        prediction = '';
        update();
      }
    }
  }
}
