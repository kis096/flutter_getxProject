
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo/App/Data/module/task.dart';
import 'package:getx_todo/App/core/utils/extension.dart';
import 'package:getx_todo/App/module/Home/controller.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:getx_todo/App/module/details/detail_view.dart';

class TaskCard extends StatelessWidget {
  final HomeController homeCtrl = Get.find<HomeController>();
  final Task task;

  TaskCard({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color;
    try {
      color = HexColor.fromHex(task.color);
    } catch (e) {
      color = Colors.white; // Default color if parsing fails
    }

    final squareWidth = Get.width - 12.0.wp;
    return GestureDetector(
      onTap: (){
        homeCtrl.changeTask(task);
        homeCtrl.changesTodos(task.todos ??[]);
        Get.to(()=> DetailPage());
      },
      child: Container(
        width: squareWidth / 2,
        height: squareWidth / 2,
        margin: EdgeInsets.all(3.0.wp),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300]!,
              blurRadius: 7,
              offset: const Offset(0, 7),
            ),
          ],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.all(4.0.wp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
      
              StepProgressIndicator(
                totalSteps: homeCtrl.isTodosEmpty(task) ? 1 : task.todos!.length,
                currentStep: homeCtrl.isTodosEmpty(task)? 0: homeCtrl.getDoneTodo(task), // Replace with dynamic value if available
                size: 5,
                padding: 0,
                selectedGradientColor: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [color.withOpacity(0.5), color],
                ),
                unselectedGradientColor: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white, Colors.white],
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  IconData(task.icon, fontFamily: 'MaterialIcons'),
                  color: color,
                  size: 24.0, // Adjust the size as needed
                ),
              ),
              Padding(
                padding:  EdgeInsets.all(6.0.wp),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.title,
                     style: TextStyle(fontWeight: FontWeight.bold,
                     fontSize: 12.0.sp),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2.0.wp,),
      
                    Text('${task.todos?.length ?? 0}Task',
                    style: const TextStyle(fontWeight: FontWeight.bold,
                    color: Colors.grey),),
      
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
