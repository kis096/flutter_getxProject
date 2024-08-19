
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo/App/Data/module/task.dart';
import 'package:getx_todo/App/module/Home/controller.dart';
import 'package:getx_todo/App/core/utils/extension.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:getx_todo/App/Widget/icon.dart'; // Adjust import if needed
import 'package:getx_todo/App/core/values/colors.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
class AddCard extends StatelessWidget {
  final HomeController homeCtrl = Get.find<HomeController>();

  AddCard({super.key});

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var squareWidth = Get.width - 12.0.wp;

    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
            titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
            radius: 5,
            title: 'Task Type',
            content: Form(
              key: homeCtrl.formkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                    child: TextFormField(
                      controller: homeCtrl.editCtrl,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Title",
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your task title';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 3.0.wp),
                  Obx(
                        () => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Wrap(
                        spacing: 2.0.wp,
                        children: icons.map((e) {
                          final index = icons.indexOf(e);
                          return ChoiceChip(
                            selectedColor: Colors.grey[200],
                            pressElevation: 0,
                            backgroundColor: Colors.white,
                            label: e,
                            selected: homeCtrl.chipIndex.value == index,
                            onSelected: (bool selected) {
                              homeCtrl.chipIndex.value = selected ? index : 0;
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      maximumSize: const Size(150, 40),
                    ),
                    onPressed: () {
                      if (homeCtrl.formkey.currentState!.validate()) {
                        var selectedIcon = icons[homeCtrl.chipIndex.value] as Icon;
                        int iconCodePoint = selectedIcon.icon!.codePoint;
                        String color = (selectedIcon.color ?? Colors.black).toHex();
                        var task = Task(
                          title: homeCtrl.editCtrl.text,
                          icon: iconCodePoint,
                          color: color,
                        );
                        Get.back();
                        homeCtrl.addTask(task)
                            ? EasyLoading.showSuccess('Create success')
                            : EasyLoading.showError('Duplicated Task');
                      }
                    },
                    child: const Text("Confirm"),
                  ),
                ],
              ),
            ),
          );
          homeCtrl.editCtrl.clear();
          homeCtrl.changeChipIndex(0);
        },
        child: DottedBorder(
          color: Colors.grey[400]!,
          dashPattern: const [8, 4],
          child: Center(
            child: Icon(
              Icons.add,
              size: 10.0.wp,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
