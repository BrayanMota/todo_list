import 'package:flutter/material.dart';

import '../models/task_model.dart';
import '../widgets/todo_list_item.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController _taskController = TextEditingController();
  final List<Task> _tasks = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/background.jpg'),
                  fit: BoxFit.cover),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 64.0),
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Lista de Tarefas',
                          style: TextStyle(
                            fontSize: 24.0,
                            color: Colors.purple,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      // TODO Colocar o botão do mesmo tamanho do text field de forma automâtica
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Tarefa',
                                hintText: 'Buscar a vó no Jiu-Jitsu',
                              ),
                              controller: _taskController,
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          ElevatedButton(
                            onPressed: _addTask,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple,
                              padding: EdgeInsets.all(12.0),
                            ),
                            child: Icon(
                              Icons.add,
                              size: 32.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Flexible(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return TodoListItem(
                              task: _tasks[index],
                              deleteTask: _deleteTask,
                            );
                          },
                          itemCount: _tasks.length,
                        ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        'Você possui ${_tasks.length} tarefas pendentes',
                      ),
                      ElevatedButton(
                        onPressed: _cleanTaskList,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                        ),
                        child: Text(
                          'Remover tarefas concluídas',
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _addTask() {
    setState(() {
      Task task = Task(title: _taskController.text, dateTask: DateTime.now());
      _tasks.add(task);
      _taskController.text = '';
    });
  }

  void _cleanTaskList() {
    setState(() {
      _tasks.removeWhere((element) => element.stateTask);
      // _tasks.clear();
    });
  }

  void _deleteTask(Task task) {
    setState(() {
      _tasks.remove(task);
    });
  }
}
