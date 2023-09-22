import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../../core/error/exceptions.dart';

import '../model/todo_app_model.dart';

abstract class TodoAppRemoteDataSource {
  Future<GetTodoModel>? getTodoItems();
  Future<CreateTodoModel>? createTodoItems(String? label);
  Future<MessageTodoModel>? updateTodoItems(String? label, String? uid);
  Future<MessageTodoModel>? deleteTodoItems(String? uid);
}

class TodoAppRemoteDataSourceImpl extends TodoAppRemoteDataSource {
  late final http.Client client;
  TodoAppRemoteDataSourceImpl({required this.client});

  @override
  Future<CreateTodoModel>? createTodoItems(String? label) async {
    try {
      final response = await client.post(
        Uri.parse(
            "https://98b3-197-210-76-221.ngrok-free.app/api/todos/create"),
        body: jsonEncode({
          'label': label!,
        }),
        headers: {'Content-Type': 'application/json'},
      );
      final jsonResponse = json.decode(response.body);
      return CreateTodoModel.fromJson(jsonResponse);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<GetTodoModel>? getTodoItems() async {
    try {
      final response = await client.get(
        Uri.parse("https://98b3-197-210-76-221.ngrok-free.app/api/todos/list"),
        headers: {'Content-Type': 'application/json'},
      );
      final jsonResponse = json.decode(response.body);
      return GetTodoModel.fromJson(jsonResponse);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<MessageTodoModel>? updateTodoItems(String? label, String? uid) async {
    try {
      final body = {
        'label': label!,
      };
      final response = await client.patch(
        Uri.parse(
            "https://98b3-197-210-76-221.ngrok-free.app/api/todos/update/$uid"),
        body: jsonEncode(body),
        headers: {'Content-Type': 'application/json'},
      );

      final jsonResponse = json.decode(response.body);
      return MessageTodoModel.fromJson(jsonResponse);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<MessageTodoModel>? deleteTodoItems(String? uid) async {
    try {
      final response = await client.delete(
        Uri.parse(
            "https://98b3-197-210-76-221.ngrok-free.app/api/todos/delete/$uid"),
        headers: {'Content-Type': 'application/json'},
      );
      final jsonResponse = json.decode(response.body);
      return MessageTodoModel.fromJson(jsonResponse);
    } catch (e) {
      throw ServerException();
    }
  }
}
