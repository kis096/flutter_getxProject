
import 'package:get/get.dart';
import 'package:getx_todo/App/Data/module/provider/task/provider.dart';
import 'package:getx_todo/App/Data/services/storage/repository.dart';
import 'package:getx_todo/App/module/Home/controller.dart';
class HomeBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut( ()=> HomeController(
        taskRepository: TaskRepository(
          taskProvider: TaskProvider(),
        ))
    );
  }

}