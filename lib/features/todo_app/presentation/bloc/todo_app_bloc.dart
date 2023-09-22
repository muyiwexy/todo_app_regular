import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/todo_app.dart';
import '../../domain/usecases/create_todo_items.dart';
import '../../domain/usecases/delete_todo_items.dart';
import '../../domain/usecases/list_todo_items.dart';
import '../../domain/usecases/update_todo_item.dart';

part 'todo_app_event.dart';
part 'todo_app_state.dart';

const String SERVER_FAILURE_MESSAGE = "Server failure";
const String CACHE_FAILURE_MESSAGE = "Cache failure";

class TodoAppBloc extends Bloc<TodoAppEvent, TodoAppState> {
  late final ListTodoItems listTodoItems;
  late final CreateTodoItems createTodoItems;
  late final UpdateTodoItems updateTodoItems;
  late final DeleteTodoItems deleteTodoItems;
  TodoAppBloc({
    required this.listTodoItems,
    required this.createTodoItems,
    required this.updateTodoItems,
    required this.deleteTodoItems,
  }) : super(Empty()) {
    on<ListForTodoItems>((event, emit) async {
      emit(Loading());
      final listTodo = await listTodoItems.execute();
      emit(listTodo!.fold(
        (failure) {
          return Error(message: _mapFailureToMessage(failure));
        },
        (getTodo) {
          return GetTodoLoaded(getTodo: getTodo);
        },
      ));
    });
    on<CreateNewTodoItems>((event, emit) async {
      final createTodo = await createTodoItems.execute(label: event.label);
      emit(createTodo!.fold(
        (failure) {
          return Error(message: _mapFailureToMessage(failure));
        },
        (createTodo) {
          return CreateTodoLoaded(createTodo: createTodo);
        },
      ));
    });
    on<UpdatePreviousTodoItems>((event, emit) async {
      final updateTodo =
          await updateTodoItems.execute(label: event.label, uid: event.uid);
      emit(
        updateTodo!.fold(
            (failure) => Error(message: _mapFailureToMessage(failure)),
            (messageTodo) => MessageTodoLoaded(messageTodo: messageTodo)),
      );
    });
    on<DeleteATodoItems>((event, emit) async {
      final deleteTodo = await deleteTodoItems.execute(uid: event.uid);
      emit(
        deleteTodo!.fold(
            (failure) => Error(message: _mapFailureToMessage(failure)),
            (messageTodo) => MessageTodoLoaded(messageTodo: messageTodo)),
      );
    });
  }

  String _mapFailureToMessage(Failure failure) {
    // Instead of a regular 'if (failure is ServerFailure)...'
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
