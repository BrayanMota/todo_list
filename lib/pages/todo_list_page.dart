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
  Task? deletedTask;
  int? deletedTaskPos;

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
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
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
                      Expanded(
                        child: _tasks.isEmpty
                            ? Align(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Image(
                                      width: 100,
                                      image: AssetImage(
                                          'assets/images/listTasksEmpty.png'),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      'Vamos adicionar novas tarefinhas?',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return TodoListItem(
                                    task: _tasks[index],
                                    deleteTask: _deleteTask,
                                    changeCheckBoxValue: _changeCheckBoxValue,
                                  );
                                },
                                itemCount: _tasks.length,
                              ),
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Text(
                        'Você possui ${_tasks.where((element) => !element.stateTask).length} tarefas pendentes',
                      ),
                      ElevatedButton(
                        onPressed:
                            _tasks.where((element) => element.stateTask).isEmpty
                                ? null
                                : _showDialogConfirmDeleteTasks,
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

  void _removeTaskListWhere() {
    setState(() {
      _tasks.removeWhere((element) => element.stateTask);
    });
    Navigator.pop(context);
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void _deleteTask(Task task) {
    deletedTask = task;
    deletedTaskPos = _tasks.indexOf(task);

    setState(() {
      _tasks.remove(task);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.purple,
        content: Text('Tarefa removida com sucesso!'),
        action: SnackBarAction(
          onPressed: () {
            setState(() {
              _tasks.insert(deletedTaskPos!, deletedTask!);
            });
          },
          label: 'Desfazer',
          textColor: Colors.white,
        ),
      ),
    );
  }

  void _changeCheckBoxValue(Task task) {
    setState(() {
      task.stateTask = !task.stateTask;
    });
  }

  void _showDialogConfirmDeleteTasks() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Remover tarefas concluídas?'),
            content: Text(
              'Você tem certeza que deseja apagar todas as tarefas?',
            ),
            actions: [
              OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancelar')),
              ElevatedButton(
                  onPressed: _removeTaskListWhere, child: Text('Confirmar'))
            ],
          );
          // return Card(
          //   child: Column(
          //     children: [
          //       Text(''),
          //       Row(
          //         children: [
          //           OutlinedButton(onPressed: () {}, child: Text('Cancelar')),
          //           ElevatedButton(onPressed: () {}, child: Text('Confirmar'))
          //         ],
          //       ),
          //     ],
          //   ),
          // );
        });
  }
}
