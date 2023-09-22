import 'package:dartz/dartz.dart';
import '../entities/todo_app.dart';

import '../../../../core/error/failures.dart';

abstract class TodoAppRepository {
  Future<Either<Failure, GetTodo>>? getTodoItems();
  Future<Either<Failure, CreateTodo>>? createTodoItems(String? label);
  Future<Either<Failure, MessageTodo>>? updateTodoItems(
      String? label, String? uid);
  Future<Either<Failure, MessageTodo>>? deleteTodoItems(String? uid);
}
