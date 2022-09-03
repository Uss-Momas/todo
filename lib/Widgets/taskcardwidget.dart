import 'package:flutter/material.dart';

class TaskCardWidget extends StatelessWidget {
  final String? taskTitle;
  final String? taskDescription;
  const TaskCardWidget({Key? key, this.taskTitle, this.taskDescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 18.0,
      ),
      margin: const EdgeInsets.only(
        bottom: 15.0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            taskTitle ?? "(Tarefa sem nome)",
            style: const TextStyle(
              color: Color.fromARGB(255, 0x21, 0x15, 0x51),
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
            ),
            child: Text(
              taskDescription ?? "Tarefa sem descrição",
              style: const TextStyle(
                color: Color.fromARGB(255, 0x86, 0x82, 0x90),
                fontSize: 14.0,
                fontWeight: FontWeight.w500,
                height: 1.5,
              ),
            ),
          )
        ],
      ),
    );
  }
}
