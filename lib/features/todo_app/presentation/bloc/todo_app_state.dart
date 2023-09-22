part of 'todo_app_bloc.dart';

sealed class TodoAppState extends Equatable {
  const TodoAppState();

  @override
  List<Object> get props => [];
}

final class Empty extends TodoAppState {}

final class Loading extends TodoAppState {}

abstract class TodoActionState extends TodoAppState {}

final class MessageTodoLoaded extends TodoActionState {
  final MessageTodo messageTodo;
  MessageTodoLoaded({
    required this.messageTodo,
  });

  @override
  List<Object> get props => [
        messageTodo,
      ];
}

final class GetTodoLoaded extends TodoAppState {
  final GetTodo getTodo;
  const GetTodoLoaded({
    required this.getTodo,
  });

  @override
  List<Object> get props => [getTodo];
}

final class CreateTodoLoaded extends TodoActionState {
  final CreateTodo createTodo;
  CreateTodoLoaded({
    required this.createTodo,
  });

  @override
  List<Object> get props => [createTodo];
}

final class Error extends TodoActionState {
  final String message;
  Error({required this.message});

  @override
  List<Object> get props => [message];
}
