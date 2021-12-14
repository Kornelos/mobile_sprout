import 'package:flutter/widgets.dart';
import 'package:mobile_sprout/model/notification.dart';

class NotificationProvider extends ChangeNotifier {
  List<TaskNotification> notifications = [
    TaskNotification("Living Room plant", NotificationType.Watering, DateTime.now().add(Duration(hours: 1))),
    TaskNotification("Kitchen plant", NotificationType.Fertilizing, DateTime.now().add(Duration(hours: 2))),
    TaskNotification("Living Room plant", NotificationType.Watering, DateTime.now().add(Duration(days: 4)))

  ];

  void addNotification(TaskNotification notification){
    notifications.add(notification);
    notifyListeners();
  }

  void removeTaskNotification(TaskNotification task) {
    notifications.remove(task);
    notifyListeners();
  }
  bool hasNotifications() => notifications.isNotEmpty;
}