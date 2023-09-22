import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/todo_app.dart';

import '../repository/todo_app_repository.dart';

class ListTodoItems {
  late final TodoAppRepository todoAppRepository;
  ListTodoItems(this.todoAppRepository);

  Future<Either<Failure, GetTodo>?>? execute() async {
    return await todoAppRepository.getTodoItems();
  }
}
