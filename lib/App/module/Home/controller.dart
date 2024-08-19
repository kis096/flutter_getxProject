import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:getx_todo/App/Data/services/storage/repository.dart';
import '../../Data/module/task.dart';

class HomeController extends GetxController {
  final TaskRepository taskRepository;

  HomeController({required this.taskRepository});

  final editCtrl = TextEditingController();
  final tabIndex = 0.obs;
  final formkey = GlobalKey<FormState>();
  final chipIndex = 0.obs;
  final deleting = false.obs;
  final success = false.obs;
  final tasks = <Task>[].obs;
  final task = Rx<Task?>(null);
  final doingTodos = <dynamic>[].obs;
  final doneTodos = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    refreshTasks();
    ever(tasks, (_) => taskRepository.writeTask(tasks));
  }

  @override
  void onClose() {
    editCtrl.dispose();
    super.onClose();
  }

  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  void refreshTasks() {
    tasks.assignAll(taskRepository.readTask());
    if (task.value != null) {
      changesTodos(task.value!.todos ?? []);
    }
  }

  void changeChipIndex(int value) {
    chipIndex.value = value;
  }

  void changeDeleting(bool value) {
    deleting.value = value;
  }

  void changeTask(Task? select) {
    task.value = select;
    if (select != null) {
      changesTodos(select.todos ?? []);
    }
  }

  void changesTodos(List<dynamic> select) {
    doingTodos.clear();
    doneTodos.clear();
    for (var todo in select) {
      if (todo['done'] == true) {
        doneTodos.add(todo);
      } else {
        doingTodos.add(todo);
      }
    }
  }

  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    }
    tasks.add(task);
    return true;
  }

  void deleteTask(Task task) {
    tasks.remove(task);
    tasks.refresh();
  }

  bool updateTask(Task task, String title) {
    var todos = task.todos ?? [];
    if (containsTodo(todos, title)) {
      return false;
    }
    var todo = {'title': title, 'done': false};
    todos.add(todo);
    var newTask = task.copyWith(todos: todos);
    int oldIdx = tasks.indexOf(task);
    tasks[oldIdx] = newTask;
    tasks.refresh();
    return true;
  }

  bool containsTodo(List todos, String title) {
    return todos.any((element) => element['title'] == title);
  }

  bool addTodo(String title) {
    var todo = {'title': title, 'done': false};
    if (doingTodos.any((element) => mapEquals<String, dynamic>(todo, element)) ||
        doneTodos.any((element) => mapEquals<String, dynamic>(todo, element))) {
      return false;
    }
    doingTodos.add(todo);
    doingTodos.refresh();
    return true;
  }

  void updateTodos() {
    if (task.value != null) {
      var newTodos = <Map<String, dynamic>>[
        ...doingTodos,
        ...doneTodos,
      ];
      var newTask = task.value!.copyWith(todos: newTodos);
      int oldIdx = tasks.indexOf(task.value);
      tasks[oldIdx] = newTask;
      tasks.refresh();
    }
  }

  void doneTodo(String title) {
    var doingTodo = {'title': title, 'done': false};
    int index = doingTodos.indexWhere((element) => mapEquals<String, dynamic>(doingTodo, element));
    if (index != -1) {
      doingTodos.removeAt(index);
      var doneTodo = {'title': title, 'done': true};
      doneTodos.add(doneTodo);
      updateTodos();
      doingTodos.refresh();
      doneTodos.refresh();
    }
  }

  void deleteDoneTodo(dynamic doneTodo) {
    int index = doneTodos.indexWhere((element) => mapEquals<String, dynamic>(doneTodo, element));
    if (index != -1) {
      doneTodos.removeAt(index);
      updateTodos();
      doneTodos.refresh();
    }
  }

  bool isTodosEmpty(Task task) {
    return task.todos == null || task.todos!.isEmpty;
  }

  int getDoneTodo(Task task) {
    return task.todos?.where((todo) => todo['done'] == true).length ?? 0;
  }

  int getTotalTask() {
    var res = 0;
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].todos != null) {
        res += tasks[i].todos!.length;
      }
    }
    return res;
  }

  int getTotalDoneTask() {
    var res = 0;
    for (int i = 0; i < tasks.length; i++) {
      if (tasks[i].todos != null) {
        for (int j = 0; j < tasks[i].todos!.length; j++) {
          if (tasks[i].todos![j]['done'] == true) {
            res += 1;
          }
        }
      }
    }
    return res;
  }
}
