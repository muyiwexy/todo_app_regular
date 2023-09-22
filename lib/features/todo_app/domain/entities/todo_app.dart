import 'package:equatable/equatable.dart';

import '../../data/model/todo_app_model.dart';

// List todos
// ignore: must_be_immutable
class GetTodo extends Equatable {
  List<FullTodoModel>? data;

  GetTodo({
    required this.data,
  });

  @override
  List<Object?> get props => [data];
}

class CreateTodo extends Equatable {
  final FullTodoModel data;

  const CreateTodo({
    required this.data,
  });

  @override
  List<Object?> get props => [data];
}

// ignore: must_be_immutable
class FullTodo extends Equatable {
  final String? uid;
  final String? label;
  bool? completed;
  bool edit;

  FullTodo({
    this.uid,
    this.label,
    this.completed,
    this.edit = false,
  });

  // Getter for choice
  bool getEdit() {
    return edit;
  }

  // Setter for choice
  void setEdit(bool newEdit) {
    edit = newEdit;
  }

  @override
  List<Object?> get props => [uid, label, completed, edit];
}

// Update todos
class MessageTodo extends Equatable {
  final String? message;

  const MessageTodo({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}
