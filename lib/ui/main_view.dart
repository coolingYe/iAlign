import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ialign/ui/controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      TextButton(onPressed: () {
        controller.requestOCR();
      }, child: const Text('OCR'))
    ],);
  }

}