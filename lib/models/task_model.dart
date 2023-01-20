// ignore_for_file: public_member_api_docs, sort_constructors_first
class Task {
  String title;
  DateTime dateTask;
  bool stateTask = false;

  Task({
    required this.title,
    required this.dateTask,
    bool stateTask = false,
  });
}
