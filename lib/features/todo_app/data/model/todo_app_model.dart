//GetTodo Model
import '../../domain/entities/todo_app.dart';

// ignore: must_be_immutable
class GetTodoModel extends GetTodo {
  GetTodoModel({
    required List<FullTodoModel>? data,
  }) : super(data: data);

  factory GetTodoModel.fromJson(Map<String, dynamic> json) {
    List<FullTodoModel> fullTodoList = (json["data"] as List)
        .map((item) => FullTodoModel.fromJson(item))
        .toList();
    return GetTodoModel(
      data: fullTodoList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((fullTodo) => fullTodo.toJson()).toList(),
    };
  }
}

class CreateTodoModel extends CreateTodo {
  CreateTodoModel({
    required FullTodoModel? data,
  }) : super(data: data!);

  factory CreateTodoModel.fromJson(Map<String, dynamic> json) {
    return CreateTodoModel(
      data: FullTodoModel.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

// FullTodo Model
// ignore: must_be_immutable
class FullTodoModel extends FullTodo {
  FullTodoModel({
    String? uid,
    String? label,
    bool? completed,
    bool edit = false,
  }) : super(uid: uid, label: label, completed: completed, edit: edit);
  factory FullTodoModel.fromJson(Map<String, dynamic> json) {
    return FullTodoModel(
      uid: json["uid"],
      edit: json["edit"] ?? false,
      label: json["label"],
      completed: json["completed"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "uid": uid,
      "label": label,
      "edit": edit,
      "completed": completed,
    };
  }
}

// MessageTodo Model
class MessageTodoModel extends MessageTodo {
  const MessageTodoModel({
    required String? message,
  }) : super(message: message);

  factory MessageTodoModel.fromJson(Map<String, dynamic> json) {
    return MessageTodoModel(
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
    };
  }
}
