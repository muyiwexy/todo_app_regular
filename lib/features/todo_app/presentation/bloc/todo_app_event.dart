part of 'todo_app_bloc.dart';

sealed class TodoAppEvent extends Equatable {
  const TodoAppEvent();

  @override
  List<Object> get props => [];
}

class ListForTodoItems extends TodoAppEvent {}

class CreateNewTodoItems extends TodoAppEvent {
  final String label;
  const CreateNewTodoItems(this.label);
  @override
  List<Object> get props => [label];
}

class UpdatePreviousTodoItems extends TodoAppEvent {
  final String label;
  final String uid;
  const UpdatePreviousTodoItems(this.label, this.uid);
  @override
  List<Object> get props => [label, uid];
}

class DeleteATodoItems extends TodoAppEvent {
  final String uid;
  const DeleteATodoItems(this.uid);
  @override
  List<Object> get props => [uid];
}
