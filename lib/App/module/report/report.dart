import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo/App/core/utils/extension.dart';
import 'package:getx_todo/App/core/values/colors.dart';
import 'package:getx_todo/App/module/Home/controller.dart';
import 'package:intl/intl.dart';

class Report extends StatelessWidget {
  final HomeController homectrl = Get.find<HomeController>();

  Report({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          var createdTask = homectrl.getTotalTask();
          var completedTask = homectrl.getTotalDoneTask();
          var liveTask = createdTask - completedTask;
          var percent = (createdTask == 0) ? 0.0 : completedTask / createdTask;

          return SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: 5.0.sp,
                    right: 145.0.sp,
                  ),
                  child: Text(
                    "My Report",
                    style: TextStyle(
                      fontSize: 24.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 4.0.sp,
                    right: 158.0.sp,
                  ),
                  child: Text(
                    DateFormat.yMMMMd().format(DateTime.now()),
                    style: TextStyle(
                      fontSize: 14.0.sp,
                      color: Colors.grey,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 3.0.wp,
                    horizontal: 5.0.wp,
                  ),
                  child: const Divider(
                    thickness: 2,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8.0.wp,
                    horizontal: 8.0.wp,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatus(Colors.green, liveTask, 'Live Tasks'),
                      _buildStatus(Colors.orange, completedTask, 'Completed'),
                      _buildStatus(Colors.blue, createdTask, 'Created'),
                    ],
                  ),
                ),
                SizedBox(height: 16.0.wp),
                Padding(
                  padding: EdgeInsets.only(top: 4.0.wp), // Adjusted padding
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 260.0, // Increased width
                        height: 260.0, // Increased height
                        child: CircularProgressIndicator(
                          value: percent,
                          strokeWidth: 14.0, // Adjust the thickness of the circle
                          backgroundColor: Colors.grey[200]!,
                          valueColor: AlwaysStoppedAnimation<Color>(green),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${(percent * 100).toInt()}%", // Remove decimal
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0.sp,
                            ),
                          ),
                          Text(
                            "Efficiency",
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Row _buildStatus(Color color, int number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 3.0.wp,
          width: 3.0.wp,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 0.5.wp,
              color: color,
            ),
          ),
        ),
        SizedBox(width: 3.0.wp),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$number',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0.sp,
              ),
            ),
            SizedBox(height: 2.0.wp),
            Text(
              text,
              style: TextStyle(
                fontSize: 12.0.sp,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
