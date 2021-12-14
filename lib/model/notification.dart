import 'package:equatable/equatable.dart';

class TaskNotification extends Equatable {
  final String relatedPlant;
  final NotificationType type;
  final DateTime dueDate;

  TaskNotification(this.relatedPlant, this.type, this.dueDate);

  @override
  List<Object?> get props => [relatedPlant, type, dueDate];

  String getRelativeDateString() {
    var diff = dueDate.difference(DateTime.now());
    if (diff.inDays != 0) {
      return "in " + diff.inDays.toString() + " days";
    } else if (diff.inHours != 0) {
      return "in " +diff.inHours.toString() + " hours";
    } else {
      return "now!";
    }
  }
}

enum NotificationType { Watering, Fertilizing }
