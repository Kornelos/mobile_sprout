import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../persist/hive_config.dart';

part 'task.g.dart';

@HiveType(typeId: HiveConfig.TASK)
class Task extends Equatable {
  @HiveField(1)
  final String relatedPlant;
  @HiveField(2)
  final TaskType type;
  @HiveField(3)
  final DateTime dueDate;

  Task(this.relatedPlant, this.type, this.dueDate);

  @override
  List<Object?> get props => [relatedPlant, type, dueDate];

  String getRelativeDateString() {
    var diff = dueDate.difference(DateTime.now());
    if (diff.inDays != 0) {
      return "in " + diff.inDays.toString() + " days";
    } else if (diff.inHours != 0) {
      return "in " + diff.inHours.toString() + " hours";
    } else {
      return "now!";
    }
  }
}

@HiveType(typeId: HiveConfig.TASK_TYPE)
enum TaskType {
  @HiveField(0)
  Watering,
  @HiveField(1)
  Fertilizing
}
