import 'package:dartz/dartz.dart';
import '../entities/todo_app.dart';
import '../repository/todo_app_repository.dart';

import '../../../../core/error/failures.dart';

class DeleteTodoItems {
  late final TodoAppRepository todoAppRepository;

  DeleteTodoItems(this.todoAppRepository);

  Future<Either<Failure, MessageTodo>?>? execute({required String uid}) {
    return todoAppRepository.deleteTodoItems(uid);
  }
}
