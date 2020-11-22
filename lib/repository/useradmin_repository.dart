import 'package:dartz/dartz.dart';

import 'package:formusers/entity/user_entity.dart';

abstract class IUserAdminRepository {
  Future<Either<Failure, List<UserEntity>>> getUsers();
  Future<Either<Failure, Unit>> createUser(UserEntity userEntity);
  Future<Either<Failure, Unit>> updateUser(UserEntity userEntity);
  Future<Either<Failure, Unit>> deleteUser(int id);
}

abstract class Failure {
  final String message;
  const Failure(this.message);
}
