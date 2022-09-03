import 'package:flutter/material.dart';
import 'package:todo/Widgets/taskcardwidget.dart';
import 'package:todo/databaseconnection.dart';
import 'package:todo/models/task.dart';
import 'package:todo/screens/taskpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  DatabaseHelper dbHelper = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          color: const Color.fromARGB(255, 0xF6, 0xF6, 0xF6),
          child: Stack(
            children: [
              Column(
                //LOGO CONTAINER
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 15.0,
                      bottom: 28.0,
                    ),
                    child: const Image(
                      image: AssetImage("assets/images/todoLogo.png"),
                      height: 40,
                      width: 40,
                    ),
                  ),
                  const TaskCardWidget(
                    taskTitle: "Hello, Create your Task Notes here!",
                    taskDescription:
                        "You're free to create as many toDos as you want...\nSimply clicking at the + button... \nEnjoy",
                  ),
                  Expanded(
                    //Expanded que contem os cards das tarefas
                    child: FutureBuilder(
                      future: dbHelper.getTask(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Task>> snapshot) {
                        return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, int index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TaskPage(
                                      task: snapshot.data?[index],
                                    ),
                                  ),
                                ).then((value) {
                                  setState(() {});
                                });
                              },
                              child: TaskCardWidget(
                                taskTitle: snapshot.data?[index].title,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  )
                ],
              ),
              Positioned(
                //o botao floacting_action configurado pessoalmente
                bottom: 15.0,
                right: 0.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TaskPage(),
                      ),
                    ).then((value) {
                      setState(() {});
                    });
                  },
                  child: Container(
                    width: 50.0,
                    height: 50.0,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF7349FE),
                          Color(0xFF643FDE),
                        ],
                        begin: Alignment(0.0, -1.0), //-1.0 significa o topo
                        end: Alignment(0.0, 1.0), //1.0 significa bottom(baixo)
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
