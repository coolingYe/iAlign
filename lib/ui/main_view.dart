import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ialign/ui/controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Material(
            color: Colors.transparent,
            child: Scaffold(
              backgroundColor: Colors.white,
              body: Stack(
                children: [
                  Obx(() =>
                    controller.imageData.value.isEmpty
                        ? Text('没有选择图片')
                        : Image.memory(controller.imageData.value),
                  ),

                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: controller.pickImage, child: Text('选择图片'))
                ],
              ),
            )));
  }
}
