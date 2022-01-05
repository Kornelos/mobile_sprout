import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:mobile_sprout/model/task.dart';
import 'package:mobile_sprout/providers/tasks_provider.dart';
import 'package:mobile_sprout/providers/settings_provider.dart';
import 'package:provider/provider.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({Key? key, required this.relatedPlantName}) : super(key: key);
  final String relatedPlantName;

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  TaskType dropdownValue = TaskType.Watering;
  DateTime dueDate = DateTime.now();
  bool formComplete = false;

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Provider.of<SettingsProvider>(context).getTheme();
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    return AlertDialog(
      title: Text("Change Schedule"),
      content: Container(
        width: double.maxFinite,
        height: 200,
        child: ListView(
          children: [
            Text("Task type", style: _theme.textTheme.headline3),
            DropdownButton<TaskType>(
                value: dropdownValue,
                onChanged: (TaskType? newVal) {
                  setState(() {
                    dropdownValue = newVal!;
                  });
                },
                items: TaskType.values
                    .map((e) => DropdownMenuItem(
                        value: e, child: Text(e.toString().split('.')[1])))
                    .toList()),
            Text(formComplete ? dueDate.toString() : ""),
            TextButton(
                onPressed: () {
                  DatePicker.showDateTimePicker(context,
                      showTitleActions: true,
                      minTime: DateTime.now(),
                      maxTime: DateTime.now().add(Duration(days: 365)),
                      onChanged: (date) {
                    setState(() {
                      dueDate = date;
                      formComplete = true;
                    });
                  });
                },
                child: Text("Select date"))
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () {
              tasksProvider.addNotification(
                  new Task(widget.relatedPlantName, dropdownValue, dueDate));
              Navigator.pop(context);
            },
            child: Text(
              "Add",
              style: TextStyle(color: formComplete ? Colors.blue : Colors.grey),
            ))
      ],
    );
  }
}
