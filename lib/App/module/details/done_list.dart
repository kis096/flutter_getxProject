












import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo/App/core/utils/extension.dart';
import 'package:getx_todo/App/module/Home/controller.dart';

class DoneList extends StatelessWidget {
  final HomeController homectrl = Get.find<HomeController>();

  DoneList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => homectrl.doneTodos.isNotEmpty
          ? ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 2.0.wp,
              horizontal: 5.0.wp,
            ),
            child: Text(
              'Completed (${homectrl.doneTodos.length})',
              style: TextStyle(
                fontSize: 14.0.sp,
                color: Colors.grey,
              ),
            ),
          ),
          ...homectrl.doneTodos.map(
                (element) => Dismissible(
              key: ObjectKey(element),
              direction: DismissDirection.endToStart,
              onDismissed: (_) => homectrl.deleteDoneTodo(element),
              background: Container(
                color: Colors.red.withOpacity(0.8),
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 5.0),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 4.0.wp,
                  horizontal: 9.0.wp,
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.done,
                      size: 20,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 8),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4.0.wp),
                      child: Text(
                        element['title'],
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ).toList(),
        ],
      )
          : Container(),
    );
  }
}
