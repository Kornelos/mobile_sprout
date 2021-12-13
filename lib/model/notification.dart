import 'package:equatable/equatable.dart';

class TaskNotification extends Equatable {
  final String relatedPlant;
  final NotificationType type;
  final DateTime dueDate;

  TaskNotification(this.relatedPlant, this.type, this.dueDate);

  @override
  List<Object?> get props => [relatedPlant, type, dueDate];
}

enum NotificationType { Watering, Fertilizing }
