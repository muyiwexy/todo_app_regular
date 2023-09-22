import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/todo_app_bloc.dart';
import '../widgets/loading_indicator.dart';
import 'loaded_state_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TodoAppBloc>(context).add(ListForTodoItems());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<TodoAppBloc>(context).add(ListForTodoItems());
      },
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 232, 199, 199),
        body: BlocConsumer<TodoAppBloc, TodoAppState>(
          listenWhen: (previous, current) => current is TodoActionState,
          buildWhen: (previous, current) => current is! TodoActionState,
          listener: (context, state) {
            switch (state.runtimeType) {
              case Error:
                final errorState = state as Error;
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(errorState.message),
                  duration: const Duration(seconds: 3),
                ));
              case CreateTodoLoaded:
              default:
            }
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case Loading:
                return const LoadingIndicator();
              case GetTodoLoaded:
                final loadedState = state as GetTodoLoaded;
                return Loaded(
                  getTodo: loadedState.getTodo,
                );
              default:
                return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
