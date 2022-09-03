import 'package:flutter/material.dart';
import 'package:todo/databaseconnection.dart';
import 'package:todo/models/task.dart';

class TaskPage extends StatefulWidget {
  final Task? task;
  const TaskPage({Key? key, this.task}) : super(key: key);

  @override
  TaskPageState createState() => TaskPageState();
}

class TaskPageState extends State<TaskPage> {
  bool contentVisibility = false;
  String? taskTitle = "null";
  DatabaseHelper dbhelper = DatabaseHelper();
  Task? auxTask;
  @override
  void initState() {
    if (widget.task != null) {
      contentVisibility = true;
      auxTask = widget.task;
    }

    if (widget.task?.title != null) {
      taskTitle = widget.task?.title;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15.0,
                      bottom: 10.0,
                    ),
                    child: Row(
                      children: [
                        InkWell(
                            onTap: () {
                              setState(() {});
                              Navigator.pop(
                                  context); //volta para a pagina anterior
                            },
                            borderRadius: BorderRadius.circular(
                              5.0,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Icon(
                                Icons.arrow_back_rounded,
                                color: Colors.black,
                              ),
                            )),
                        Expanded(
                          //Text Field input do titulo
                          child: TextField(
                            controller: TextEditingController(text: taskTitle),
                            onSubmitted: (value) async {
                              if (value != '') {
                                if (widget.task == null) {
                                  Task newTask = Task(
                                    title: value,
                                  );
                                  await dbhelper.insertTask(newTask);
                                  setState(() {
                                    contentVisibility = true;
                                  });
                                } else {}
                              }
                            },
                            decoration: const InputDecoration(
                              hintText: "Digite o título da tarefa",
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(
                                    255, 0xFF21, 0xFF15, 0xFF51)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      bottom: 12.0,
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Digite a descrição para a tarefa...",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 15.0,
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Color(0xFF868290),
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: contentVisibility,
                child: Positioned(
                  //o botao floacting_action configurado pessoalmente
                  bottom: 15.0,
                  right: 24.0,
                  child: GestureDetector(
                    onTap: () {
                      if (auxTask!.id != 0) {
                        dbhelper.deleteTask(auxTask!.id);
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFE3577),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: const Icon(
                        Icons.delete_forever_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
