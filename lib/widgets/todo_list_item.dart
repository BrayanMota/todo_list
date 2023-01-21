import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/task_model.dart';

class TodoListItem extends StatelessWidget {
  final Task task;
  final Function(Task) deleteTask;
  final Function(Task) changeCheckBoxValue;

  const TodoListItem({
    required this.task,
    required this.deleteTask,
    required this.changeCheckBoxValue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.grey[200],
      ),
      padding: EdgeInsets.all(16.0),
      child: ListTileItem(
        task: task,
        deleteTask: deleteTask,
        changeCheckBoxValue: changeCheckBoxValue,
      ),
      // child: CustomList(
      //   task: task,
      //   deleteTask: deleteTask,
      //   changeCheckBoxValue: changeCheckBoxValue,
      // ),
    );
  }
}

class CustomList extends StatelessWidget {
  final Task task;
  final Function(Task) deleteTask;
  final Function(Task) changeCheckBoxValue;

  const CustomList({
    required this.task,
    required this.deleteTask,
    required this.changeCheckBoxValue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: task.stateTask,
          onChanged: (value) => changeCheckBoxValue(task),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('dd/MM/yyyy - HH:mm').format(task.dateTask),
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            Text(
              task.title,
              overflow: TextOverflow.clip,
              maxLines: 3,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        IconButton(
          onPressed: (() => deleteTask(task)),
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}

class ListTileItem extends StatelessWidget {
  final Task task;
  final Function(Task) deleteTask;
  final Function(Task) changeCheckBoxValue;

  const ListTileItem({
    required this.task,
    required this.deleteTask,
    required this.changeCheckBoxValue,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        DateFormat('dd/MM/yyyy - HH:mm').format(task.dateTask),
        style: TextStyle(
          fontSize: 12,
        ),
      ),
      subtitle: Text(
        task.title,
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      leading: Checkbox(
        value: task.stateTask,
        onChanged: (value) => changeCheckBoxValue(task),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      trailing: IconButton(
        onPressed: (() => deleteTask(task)),
        icon: Icon(
          Icons.delete,
          color: Colors.red,
        ),
      ),
    );
  }
}
