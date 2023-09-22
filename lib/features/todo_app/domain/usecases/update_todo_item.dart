import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/todo_app.dart';

import '../repository/todo_app_repository.dart';

class UpdateTodoItems {
  late final TodoAppRepository todoAppRepository;

  UpdateTodoItems(this.todoAppRepository);

  Future<Either<Failure, MessageTodo>>? execute(
      {required String? label, required String? uid}) {
    return todoAppRepository.updateTodoItems(label, uid);
  }
}
