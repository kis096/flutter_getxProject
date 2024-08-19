
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo/App/Data/module/task.dart';
import 'package:getx_todo/App/module/Home/add_card.dart';
import 'package:getx_todo/App/module/Home/add_dialog.dart';
import 'package:getx_todo/App/module/Home/controller.dart';
import 'package:getx_todo/App/core/utils/extension.dart';
import 'package:getx_todo/App/module/Home/task_.card.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:getx_todo/App/module/report/report.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(
        index: controller.tabIndex.value,
        children: [
          SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'My list',
                    style: TextStyle(
                      fontSize: 24.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Obx(
                      () => GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    children: [
                      ...controller.tasks.map((element) => LongPressDraggable(
                        data: element,
                        onDragStarted: () => controller.changeDeleting(true),
                        onDraggableCanceled: (_, __) => controller.changeDeleting(false),
                        onDragEnd: (_) => controller.changeDeleting(false),
                        feedback: Opacity(
                          opacity: 0.8,
                          child: TaskCard(task: element),
                        ),
                        child: TaskCard(task: element),
                      ))
                          .toList(),
                      AddCard(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Report(),
        ],
      )),
      floatingActionButton: DragTarget<Task>(
        builder: (_, __, ___) {
          return Obx(
                () => FloatingActionButton(
              backgroundColor: controller.deleting.value ? Colors.red : Colors.blue,
              onPressed: () {
                if (controller.tasks.isNotEmpty) {
                  Get.to(() => AddDialog(), transition: Transition.downToUp);
                } else {
                  EasyLoading.showInfo("Please create your task");
                }
              },
              child: Icon(controller.deleting.value ? Icons.delete : Icons.add),
            ),
          );
        },
        onAccept: (Task task) {
          controller.deleteTask(task);
          EasyLoading.showSuccess("Delete Success");
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Obx(
              () => BottomNavigationBar(
            onTap: (int index) => controller.changeTabIndex(index),
            currentIndex: controller.tabIndex.value,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedItemColor: Colors.blue, // Selected tab color
            unselectedItemColor: Colors.grey, // Unselected tab color
            backgroundColor: controller.tabIndex.value == 0 ? Colors.white : Colors.white, // Background color change
            items: [
              BottomNavigationBarItem(
                label: 'Home',
                icon: Padding(
                  padding: EdgeInsets.only(right: 15.0.wp),
                  child: const Icon(Icons.apps),
                ),
              ),
              BottomNavigationBarItem(
                label: 'Report',
                icon: Padding(
                  padding: EdgeInsets.only(left: 15.0.wp),
                  child: const Icon(Icons.data_usage),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
