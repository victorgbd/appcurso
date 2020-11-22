part of 'UserAdmin_cubit.dart';

@immutable
abstract class AdminUserState {}

class AdminUserInitial extends AdminUserState {}
class AdminUserLoading extends AdminUserState {}
class AdminUserLoaded extends AdminUserState {
  final List<UserEntity> userEntities;
  AdminUserLoaded({
    this.userEntities,
  });
}
class AdminUserError extends AdminUserState {
  final String message;
  AdminUserError({
    this.message,
  });
}
class AdminUserCreating extends AdminUserState {}
class AdminUserCreated extends AdminUserState {}
class AdminUserUpdating extends AdminUserState {}
class AdminUserUpdated extends AdminUserState {}
class AdminUserDeleting extends AdminUserState {}
class AdminUserDeleted extends AdminUserState {}
