import 'package:flutter/widgets.dart';
import 'package:mobile_sprout/model/task.dart';

class TasksProvider extends ChangeNotifier {
  List<Task> notifications = [
    Task("Living Room plant", NotificationType.Watering,
        DateTime.now().add(Duration(hours: 1))),
    Task("Kitchen plant", NotificationType.Fertilizing,
        DateTime.now().add(Duration(hours: 2))),
    Task("Living Room plant", NotificationType.Watering,
        DateTime.now().add(Duration(days: 4)))
  ];

  void addNotification(Task notification) {
    notifications.add(notification);
    notifyListeners();
  }

  void removeTaskNotification(Task task) {
    notifications.remove(task);
    notifyListeners();
  }

  bool hasNotifications() => notifications.isNotEmpty;
}
