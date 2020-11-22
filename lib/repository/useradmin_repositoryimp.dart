import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

import 'package:formusers/data/users_model.dart';
import 'package:formusers/entity/user_entity.dart';
import 'package:formusers/repository/useradmin_repository.dart';

class UserAdminRepositoryImp implements IUserAdminRepository {
  final http.Client httpClient;
  UserAdminRepositoryImp({
    @required this.httpClient,
  });
  final String _url = "https://028097a1b74d.ngrok.io/users";
  @override
  Future<Either<Failure, Unit>> createUser(UserEntity userEntity) async {
    try {
      final userModel = Users(
          id: userEntity.id,
          username: userEntity.username,
          password: userEntity.password);
      final response = await http.post(_url, body: usersToJson([userModel]));
      print(response.body);
      print(response.statusCode);
      if (response.statusCode != 200)
        return Left(
            const UserAdminFailure(message: "something was wrong on create"));
      return Right(unit);
    } catch (e) {
      return Left(
          const UserAdminFailure(message: "something was wrong on create"));
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteUser(int id) async {
    try {
      final response = await this.httpClient.delete(_url + '/$id');
      print(response.body);
      print(response.statusCode);
      if (response.statusCode != 200) {
        return Left(
            const UserAdminFailure(message: "something was wrong in delete"));
      }

      return Right(unit);
    } catch (e) {
      return Left(
          const UserAdminFailure(message: "something was wrong in getdata"));
    }
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getUsers() async {
    try {
      final response = await this.httpClient.get(_url);

      if (response.statusCode != 200) {
        return Left(
            const UserAdminFailure(message: "something was wrong in getdata"));
      }

      final listUser = usersFromJson(response.body);

      return Right(listUser);
    } catch (e) {
      return Left(
          const UserAdminFailure(message: "something was wrong in getdata"));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateUser(UserEntity userEntity) async {
    try {
      final userModel = Users(
          id: userEntity.id,
          username: userEntity.username,
          password: userEntity.password);
      final response = await http.put(_url, body: usersToJson([userModel]));
      print(response.body);
      print(response.statusCode);
      if (response.statusCode != 200)
        return Left(
            const UserAdminFailure(message: "something was wrong on update"));
      return right(unit);
    } catch (e) {
      return Left(
          const UserAdminFailure(message: "something was wrong on update"));
    }
  }
}

class UserAdminFailure extends Failure {
  final String message;

  const UserAdminFailure({this.message}) : super(message);
}
