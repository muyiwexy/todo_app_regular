import 'package:dartz/dartz.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_status.dart';
import '../datasources/todo_app_local_data_sources.dart';
import '../datasources/todo_app_remote_data_sources.dart';
import '../../domain/entities/todo_app.dart';
import '../../domain/repository/todo_app_repository.dart';

class TodoAppRepositoryImpl implements TodoAppRepository {
  late final TodoAppRemoteDataSource todoAppRemoteDataSource;
  late final TodoAppLocalDataSource todoAppLocalDataSource;
  late final NetworkStatus networkStatus;

  TodoAppRepositoryImpl({
    required this.todoAppRemoteDataSource,
    required this.todoAppLocalDataSource,
    required this.networkStatus,
  });

  @override
  Future<Either<Failure, CreateTodo>>? createTodoItems(String? label) async {
    networkStatus.isConnected;
    try {
      final remoteTodo = await todoAppRemoteDataSource.createTodoItems(label);
      return Right(remoteTodo!);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, MessageTodo>>? deleteTodoItems(String? uid) async {
    networkStatus.isConnected;
    try {
      final remoteTodo = await todoAppRemoteDataSource.deleteTodoItems(uid);
      return Right(remoteTodo!);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, GetTodo>>? getTodoItems() async {
    if (await networkStatus.isConnected!) {
      try {
        final remoteTodo = await todoAppRemoteDataSource.getTodoItems();
        todoAppLocalDataSource.cacheTodoList(remoteTodo!);
        return Right(remoteTodo);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localTodo = await todoAppLocalDataSource.getLastTodoList();
        return Right(localTodo!);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, MessageTodo>>? updateTodoItems(
      String? label, String? uid) async {
    networkStatus.isConnected;
    try {
      final remoteTodo =
          await todoAppRemoteDataSource.updateTodoItems(label, uid);
      return Right(remoteTodo!);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
