import 'package:bloc/bloc.dart';

import 'package:formusers/entity/user_entity.dart';
import 'package:formusers/repository/useradmin_repository.dart';

import 'package:meta/meta.dart';

part 'UserAdmin_state.dart';

class AdminUserCubit extends Cubit<AdminUserState> {
  final IUserAdminRepository userAdminRepository;
  AdminUserCubit(this.userAdminRepository) : super(AdminUserInitial());
  Future<void> getUsers() async {
    emit(AdminUserLoading());

    final failureOrSuccess = await this.userAdminRepository.getUsers();

    failureOrSuccess.fold(
      (failure) => emit(AdminUserError(message: failure.message)),
      (userEntities) => emit(AdminUserLoaded(userEntities: userEntities)),
    );
  }

  Future<void> create(String username, String password) async {
    emit(AdminUserCreating());

    final userEntity =
        UserEntity(username: username, password: password, id: 1);

    final failureOrUnit = await this.userAdminRepository.createUser(userEntity);

    failureOrUnit.fold(
      (failure) => emit(AdminUserError(message: failure.message)),
      (unit) => getUsers(),
    );
  }

  Future<void> delete(int id) async {
    final failureOrUnit = await this.userAdminRepository.deleteUser(id);

    failureOrUnit.fold(
      (failure) => emit(AdminUserError(message: failure.message)),
      (unit) => unit,
    );
  }

  Future<void> update(String username, String password, int id) async {
    emit(AdminUserUpdating());

    final userEntity =
        UserEntity(username: username, password: password, id: id);

    final failureOrUnit = await this.userAdminRepository.updateUser(userEntity);

    failureOrUnit.fold(
      (failure) => emit(AdminUserError(message: failure.message)),
      (unit) => getUsers(),
    );
  }
}
