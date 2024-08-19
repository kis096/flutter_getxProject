

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo/App/core/utils/extension.dart';
import 'package:getx_todo/App/module/Home/controller.dart';

class DoingList extends StatelessWidget {
  final HomeController homectrl = Get.find<HomeController>();

  DoingList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => homectrl.doingTodos.isEmpty && homectrl.doneTodos.isEmpty
          ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              'Assets/images/todo.jpeg',
              fit: BoxFit.cover,
              width: 65.0.wp,
            ),
          ),
          Text(
            'Add tasks',
            style: TextStyle(
              fontSize: 16.0.wp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      )
          : ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: [
          ...homectrl.doingTodos.map(
                (element) => Padding(
              padding: EdgeInsets.symmetric(
                vertical: 3.0.wp,
                horizontal: 9.0.wp,
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Checkbox(
                      fillColor: MaterialStateProperty.resolveWith(
                            (states) => Colors.grey,
                      ),
                      value: element['done'],
                      onChanged: (value) {
                        homectrl.doneTodo(element['title']);
                        homectrl.updateTodos();
                      },
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 1.5.wp,
                      horizontal: 4.0.wp,
                    ),
                    child: Text(
                      element['title'],
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ).toList(),
          if (homectrl.doingTodos.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0.wp),
              child: const Divider(thickness: 2),
            ),
        ],
      ),
    );
  }
}
