import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/todo_app.dart';

import '../repository/todo_app_repository.dart';

class CreateTodoItems {
  late final TodoAppRepository todoAppRepository;

  CreateTodoItems(this.todoAppRepository);

  Future<Either<Failure, CreateTodo>?>? execute({required String? label}) {
    return todoAppRepository.createTodoItems(label);
  }
}
