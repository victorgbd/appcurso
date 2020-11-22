import 'package:http/http.dart' as http;
import 'package:formusers/data/users_model.dart';
import 'dart:convert';

Future<List<Users>> getUsers() async {
  const url = "https://9e3a9830c9e7.ngrok.io/users";
  final response = await http.get(url);

  if (response.statusCode != 200) throw UnimplementedError();

  final userList = usersFromJson(response.body);

  return userList;
}

Future<String> postUser(String body) async {
  var url = "https://9e3a9830c9e7.ngrok.io/users";

  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  final response = await http.post(url, body: body, headers: headers);
  final responseJson = json.decode(response.body);
  print(responseJson);
  return response.body;
}
