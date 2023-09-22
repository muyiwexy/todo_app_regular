import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:http/http.dart" as http;

import 'core/network/network_status.dart';
import 'features/todo_app/data/datasources/todo_app_local_data_sources.dart';
import 'features/todo_app/data/datasources/todo_app_remote_data_sources.dart';
import 'features/todo_app/domain/repository/todo_app_repository.dart';
import 'features/todo_app/data/repository/todo_app_repository_impl.dart';
import 'features/todo_app/domain/usecases/create_todo_items.dart';
import 'features/todo_app/domain/usecases/delete_todo_items.dart';
import 'features/todo_app/domain/usecases/list_todo_items.dart';
import 'features/todo_app/domain/usecases/update_todo_item.dart';

import 'features/todo_app/presentation/bloc/todo_app_bloc.dart';

final serviceLocator = GetIt.asNewInstance();

Future<void> init() async {
  //! Features - To do
  // Bloc
  serviceLocator.registerFactory(
    () => TodoAppBloc(
        listTodoItems: serviceLocator(),
        createTodoItems: serviceLocator(),
        updateTodoItems: serviceLocator(),
        deleteTodoItems: serviceLocator()),
  );

  // use cases
  serviceLocator.registerLazySingleton(
    () => CreateTodoItems(serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => ListTodoItems(serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => UpdateTodoItems(serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => DeleteTodoItems(serviceLocator()),
  );

  // Repository
  serviceLocator.registerLazySingleton<TodoAppRepository>(
    () => TodoAppRepositoryImpl(
      todoAppRemoteDataSource: serviceLocator(),
      todoAppLocalDataSource: serviceLocator(),
      networkStatus: serviceLocator(),
    ),
  );

  // Data sources
  serviceLocator.registerLazySingleton<TodoAppRemoteDataSource>(
    () => TodoAppRemoteDataSourceImpl(
      client: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<TodoAppLocalDataSource>(
    () => TodoAppLocalDataSourceImpl(
      sharedPreferences: serviceLocator(),
    ),
  );
  //! Core
  serviceLocator.registerLazySingleton<NetworkStatus>(
    () => NetworkStatusImpl(
      serviceLocator(),
    ),
  );
  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);
  serviceLocator.registerLazySingleton(() => http.Client());
  serviceLocator.registerLazySingleton(() => InternetConnectionChecker());
}
