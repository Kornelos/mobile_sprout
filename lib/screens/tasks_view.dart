import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_sprout/model/task.dart';
import 'package:mobile_sprout/providers/tasks_provider.dart';
import 'package:mobile_sprout/providers/settings_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TasksView extends StatelessWidget {
  const TasksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Provider.of<SettingsProvider>(context).getTheme();
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    return Container(
        color: _theme.scaffoldBackgroundColor,
        child: tasksProvider.hasNotifications()
            ? ListView.builder(
                itemCount: tasksProvider.tasks.length,
                itemBuilder: (BuildContext context, int index) {
                  Task task = tasksProvider.tasks[index];
                  return TaskListTile(
                      notificationProvider: tasksProvider, task: task);
                },
              )
            : Text(
                "You don't have any tasks, add some in your plants.",
                style: _theme.textTheme.headline3,
              ));
  }
}

class TaskListTile extends StatelessWidget {
  const TaskListTile({
    Key? key,
    required this.notificationProvider,
    required this.task,
  }) : super(key: key);

  final TasksProvider notificationProvider;
  final Task task;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: UniqueKey(),
      startActionPane: ActionPane(
        motion: const BehindMotion(),
        dismissible: DismissiblePane(
          onDismissed: () {
            notificationProvider.removeTaskNotification(task);
          },
        ),
        children: [
          SlidableAction(
            onPressed: (ctx) {
              notificationProvider.removeTaskNotification(task);
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          )
        ],
      ),
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (_) {
              //implement rescheduling
            },
            backgroundColor: Colors.amber,
            foregroundColor: Colors.white,
            icon: Icons.update,
            label: 'Reschedule',
          ),
        ],
      ),
      child: ListTile(
        title: Text("${task.relatedPlant}"),
        subtitle: Text("${task.type.toString().split(".")[1]}"),
        leading: Icon(
            task.type == TaskType.Watering ? Icons.water : Icons.yard),
        trailing: Text("${task.getRelativeDateString()}"),
      ),
    );
  }
}
