import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/task_model.dart';

class TodoListItem extends StatefulWidget {
  final Task task;
  final Function(Task) deleteTask;

  const TodoListItem({
    required this.task,
    required this.deleteTask,
    super.key,
  });

  @override
  State<TodoListItem> createState() => _TodoListItemState();
}

class _TodoListItemState extends State<TodoListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.grey[200],
      ),
      padding: EdgeInsets.all(16.0),
      child: Row(
        children: [
          // Checkbox(
          //   value: widget.task.stateTask,
          //   onChanged: (value) => _changeCheckBoxValue(widget.task),
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(10.0),
          //   ),
          // ),
          Expanded(
            child: ListTile(
              title: Text(
                DateFormat('dd/MM/yyyy - HH:mm').format(widget.task.dateTask),
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              subtitle: Text(
                widget.task.title,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              leading: Checkbox(
                value: widget.task.stateTask,
                onChanged: (value) => _changeCheckBoxValue(widget.task),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              trailing: IconButton(
                onPressed: widget.deleteTask(widget.task),
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ),
          ),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Text(
          //       DateFormat('dd/MM/yyyy - HH:mm').format(widget.task.dateTask),
          //       style: TextStyle(
          //         fontSize: 12,
          //       ),
          //     ),
          //     Text(
          //       widget.task.title,
          //       style: TextStyle(
          //         fontSize: 16,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //   ],
          // ),
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(Icons.delete),
          // )
        ],
      ),
    );
  }

  void _changeCheckBoxValue(Task task) {
    setState(() {
      task.stateTask = !task.stateTask;
    });
  }
}
