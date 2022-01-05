import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile_sprout/model/task.dart';

class TasksProvider extends ChangeNotifier {
  static const String TASKS_KEY = "notifications";

  List<Task> tasks = [
    Task("Living Room plant", NotificationType.Watering,
        DateTime.now().add(Duration(hours: 1))),
    Task("Kitchen plant", NotificationType.Fertilizing,
        DateTime.now().add(Duration(hours: 2))),
    Task("Living Room plant", NotificationType.Watering,
        DateTime.now().add(Duration(days: 4)))
  ];

  final Box _taskBox;

  TasksProvider(this._taskBox){
    tasks = _taskBox.get(TASKS_KEY) != null ? (_taskBox.get(TASKS_KEY) as List).map((e) => e as Task).toList()  : tasks;
  }

  void addNotification(Task notification) {
    tasks.add(notification);
    _persistAndNotify();
  }

  void removeTaskNotification(Task task) {
    tasks.remove(task);
    _persistAndNotify();
  }

  void _persistAndNotify() {
    _taskBox.put(TASKS_KEY, tasks);
    notifyListeners();
  }

  bool hasNotifications() => tasks.isNotEmpty;
}
