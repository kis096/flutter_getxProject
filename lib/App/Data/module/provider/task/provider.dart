import 'dart:convert';
import 'package:get/get.dart';
import 'package:getx_todo/App/Data/module/task.dart';
import 'package:getx_todo/App/Data/services/storage/services.dart';
import 'package:getx_todo/App/core/utils/keys.dart';

class TaskProvider {
  final StorageServices _storage = Get.find<StorageServices>();

  List<Task> readTask() {
    var tasks = <Task>[];
    var storedTasks = _storage.read(taskKey).toString();

    var decodedTasks = jsonDecode(storedTasks) as List;
    tasks = decodedTasks.map((taskJson) => Task.fromJson(taskJson)).toList();

    return tasks;
  }

  void writeTask(List<Task> tasks) {
    var encodedTasks = jsonEncode(tasks.map((task) => task.toJson()).toList());
    _storage.write(taskKey, encodedTasks);
  }
}
