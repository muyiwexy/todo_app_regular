import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/todo_app.dart';
import '../bloc/todo_app_bloc.dart';
import '../widgets/text_header.dart';

class Loaded extends StatefulWidget {
  final GetTodo getTodo;
  const Loaded({super.key, required this.getTodo});

  @override
  State<Loaded> createState() => _LoadedState();
}

class _LoadedState extends State<Loaded> {
  FullTodo getme = FullTodo();

  final TextEditingController _addTodotextController = TextEditingController();
  void updateTodo(String label, String uid) {
    return BlocProvider.of<TodoAppBloc>(context)
        .add(UpdatePreviousTodoItems(label, uid));
  }

  void deleteTodo(String uid) {
    return BlocProvider.of<TodoAppBloc>(context).add(DeleteATodoItems(uid));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 232, 199, 199),
      appBar: appBar(),
      body: ListView.builder(
        itemBuilder: (context, index) {
          TextEditingController textController =
              TextEditingController(text: widget.getTodo.data![index].label);
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              tileColor: Colors.white,
              leading: widget.getTodo.data![index].completed == false
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          widget.getTodo.data![index].completed = true;
                        });
                      },
                      icon: const Icon(
                        Icons.circle_outlined,
                        color: Color.fromARGB(255, 72, 0, 135),
                        size: 40,
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          widget.getTodo.data![index].completed = false;
                        });
                      },
                      icon: const Icon(
                        Icons.circle,
                        color: Color.fromARGB(255, 72, 0, 135),
                        size: 40,
                      ),
                    ),
              title: Row(
                children: [
                  SizedBox(
                    width: 150,
                    child: TextField(
                      controller: textController,
                      enabled: widget.getTodo.data![index].edit,
                      style: TextStyle(
                        color: widget.getTodo.data![index].edit
                            ? Colors.black
                            : const Color.fromARGB(255, 79, 78, 78),
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                        decoration:
                            widget.getTodo.data![index].completed == false
                                ? null
                                : TextDecoration.lineThrough,
                      ),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(0),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        widget.getTodo.data![index].edit =
                            !widget.getTodo.data![index].edit;
                      });
                      if (widget.getTodo.data![index].edit == false) {
                        updateTodo(textController.text,
                            widget.getTodo.data![index].uid!);
                        BlocProvider.of<TodoAppBloc>(context)
                            .add(ListForTodoItems());
                      }
                    },
                    icon: widget.getTodo.data![index].edit
                        ? const Icon(
                            Icons.check,
                            size: 30,
                            color: Colors.black,
                          )
                        : const Icon(
                            Icons.edit_outlined,
                            size: 30,
                            color: Colors.black,
                          ),
                  )
                ],
              ),
              trailing: Container(
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.symmetric(vertical: 12),
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 194, 0, 0),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.delete_outline,
                    size: 20,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    deleteTodo(widget.getTodo.data![index].uid!);
                    BlocProvider.of<TodoAppBloc>(context)
                        .add(ListForTodoItems());
                  },
                ),
              ),
            ),
          );
        },
        itemCount: widget.getTodo.data!.length,
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 232, 199, 199),
      title: const TextHeader(textData: "ALL TASKS"),
      centerTitle: true,
      elevation: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 72, 0, 135),
              borderRadius: BorderRadius.circular(5),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.add_outlined,
                size: 20,
                color: Colors.white,
              ),
              onPressed: () {
                final todoBloc = BlocProvider.of<TodoAppBloc>(context);
                _showInputDialog(context, todoBloc);
              },
            ),
          ),
        )
      ],
    );
  }

  _showInputDialog(BuildContext context, TodoAppBloc todoBloc) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Input Dialog'),
            content: TextField(
              controller: _addTodotextController,
              decoration: const InputDecoration(
                labelText: 'Enter something',
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Access the input value here
                  String inputValue = _addTodotextController.text;
                  todoBloc.add(CreateNewTodoItems(inputValue));
                  _addTodotextController.clear();
                  Navigator.of(context).pop(); // Close the dialog
                  Future.delayed(const Duration(seconds: 1), () {
                    todoBloc.add(ListForTodoItems());
                  });
                },
                child: const Text('ADD'),
              ),
            ],
          );
        });
  }
}
