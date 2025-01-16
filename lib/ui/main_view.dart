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
            child: Container(
              color: Colors.white,
              child: Stack(
                children: [
                  Row(
                    children: [
                      SizedBox(width: 700, height: 500, child:
                      Obx(
                        () => controller.imageData.value.isEmpty
                            ? Text('没有选择图片')
                            : Image.memory(controller.imageData.value,
                                width: 700, height: 500),
                      ),
                      ),
                      Container(
                          width: 700,
                          height: 500,
                          decoration: BoxDecoration(
                            // 背景色
                            border: new Border.all(
                                color: Color(0xFFFF0000), width: 0.5),
                            borderRadius: BorderRadius.circular((8)),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Obx(() => SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                padding: EdgeInsets.all(0),
                                child: Text(controller.content.value))),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: controller.pickImage, child: Text('选择图片'))
                ],
              ),
            )));
  }
}
