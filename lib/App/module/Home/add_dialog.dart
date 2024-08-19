import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_todo/App/core/utils/extension.dart';
import 'package:getx_todo/App/module/Home/controller.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AddDialog extends StatelessWidget {
  final homectrl = Get.find<HomeController>();

  AddDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop:()async => false,
      child: Scaffold(
        body: Form(
          key: homectrl.formkey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(3.0.wp),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                        homectrl.editCtrl.clear();
                        homectrl.changeTask(null);
                      },
                      icon: const Icon(Icons.close),
                    ),
                    TextButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(Colors.transparent),
                      ),
                      onPressed: () {
                        if(homectrl.formkey.currentState!.validate()){
                          if(homectrl.task.value==null){
                            EasyLoading.showError("Please select the task");
      
      
                          }
                          else{
                            var success = homectrl.updateTask(
                              homectrl.task.value!,
                              homectrl.editCtrl.text,
                            );
                            if(success){
                              EasyLoading.showSuccess("Todo item addd sucess");
                              Get.back();
                              homectrl.changeTask(null);
                            } else{
                              EasyLoading.showError("Todo item already exist");
                            }
                            homectrl.editCtrl.clear();
                          }
      
                        }
                      },
                      child: Text(
                        "Done",
                        style: TextStyle(fontSize: 14.0.sp),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.sp),
                child: Text(
                  "New Task",
                  style: TextStyle(
                    fontSize: 20.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.0.sp),
                child: TextFormField(
                  controller: homectrl.editCtrl,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[400]!,
                      ),
                    ),
                  ),
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter your todo item";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 5.0.wp,
                  left: 5.0.wp,
                  bottom: 2.0.wp,
                  right: 5.0.wp,
                ),
                child: Text(
                  'Add to',
                  style: TextStyle(
                    fontSize: 14.0.sp,
                    color: Colors.grey,
                  ),
                ),
              ),
              ...homectrl.tasks.map((element) => Obx(
                  ()=> InkWell(
                  onTap: () => homectrl.changeTask(element),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0.wp, vertical: 3.0.wp),
                    child: Row(
                      children: [
                        Icon(
                          IconData(
                            element.icon,
                            fontFamily: 'MaterialIcons',
                          ),
                          color: HexColor.fromHex(element.color),
                        ),
                        SizedBox(width: 3.0.wp,),
                        Text(
                          element.title,
                          style: TextStyle(
                            fontSize: 12.0.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (homectrl.task.value == element)
                          const Icon(
                            Icons.check,
                            color: Colors.blue,
                          ),
                      ],
                    ),
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
