import 'package:flutter/cupertino.dart';

class UserEntity {

  final int id;
  final String username;
  final String password;
  
  const UserEntity({
    @required this.id,
    @required this.username,
    @required this.password,
  });
  

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is UserEntity &&
      o.id == id &&
      o.username == username &&
      o.password == password;
  }

  @override
  int get hashCode => id.hashCode ^ username.hashCode ^ password.hashCode;

  @override
  String toString() => 'UserEntity(id: $id, username: $username, password: $password)';
}
