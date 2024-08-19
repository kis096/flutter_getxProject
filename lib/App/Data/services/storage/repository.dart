 import 'package:getx_todo/App/Data/module/provider/task/provider.dart';
import 'package:getx_todo/App/Data/module/task.dart';

class TaskRepository{
  TaskProvider taskProvider;
  TaskRepository({required this.taskProvider});
  List<Task> readTask()=> taskProvider.readTask();
  void writeTask(List<Task>task) => taskProvider.writeTask(task);
 }