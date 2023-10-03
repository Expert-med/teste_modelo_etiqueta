import 'package:baaba/controller/scan_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CameraView extends StatelessWidget {
  const CameraView({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ScanController>(
        init: ScanController(),
        builder: ((controller) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    controller.pickImage();
                  },
                  child: Text('Select Image'),
                ),
                SizedBox(height: 20),
                Text(
                  'Instrumental: ${controller.label}',

                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                Text(
                  'Prediction: ${controller.prediction}',

                  style: TextStyle(fontSize: 20),
                ),
                
        
              ],
            ),
          );
        }),
      ),
    );
  }
}
