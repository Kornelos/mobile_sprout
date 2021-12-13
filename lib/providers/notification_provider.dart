import 'package:flutter/widgets.dart';
import 'package:mobile_sprout/model/notification.dart';

class NotificationProvider extends ChangeNotifier {
  List<TaskNotification> notifications = List.empty(growable: true);

  void addNotification(TaskNotification notification){
    notifications.add(notification);
    notifyListeners();
  }
}