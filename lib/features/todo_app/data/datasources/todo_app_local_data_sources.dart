import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/error/exceptions.dart';
import '../model/todo_app_model.dart';

abstract class TodoAppLocalDataSource {
  /// Gets the cached [GetTodoModel] which was gotten the last time
  /// the user had an internet connection.
  ///
  /// Throws [NoLocalDataException] if no cached data is present.
  Future<GetTodoModel>? getLastTodoList();

  Future<void>? cacheTodoList(GetTodoModel todoToCache);
}

const CACHED_NUMBER_TRIVIA = "CACHED_NUMBER_TRIVIA";

class TodoAppLocalDataSourceImpl implements TodoAppLocalDataSource {
  SharedPreferences sharedPreferences;
  TodoAppLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<GetTodoModel>? getLastTodoList() {
    final jsonString = sharedPreferences.getString(CACHED_NUMBER_TRIVIA);
    if (jsonString != null) {
      return Future.value(GetTodoModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void>? cacheTodoList(GetTodoModel todoToCache) {
    return sharedPreferences.setString(
      CACHED_NUMBER_TRIVIA,
      json.encode(todoToCache.toJson()),
    );
  }
}
