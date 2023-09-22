// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:todo_app_regular/core/error/exceptions.dart';

// void main() async {
//   final http.Client client;
//   client = http.Client();

//   Future<void> sendrequest(String label) async {
//     final response = await client.post(
//         Uri.parse(
//             "https://98b3-197-210-76-221.ngrok-free.app/api/todos/create"),
//         body: jsonEncode({
//           'label': label,
//         }),
//         headers: {"Content-Type": "application/json"});
//     if (response.statusCode == 201) {
//       final jsonResponse = json.decode(response.body);
//     } else {
//       throw ServerException();
//     }
//   }

//   await sendrequest("hello");
// }
