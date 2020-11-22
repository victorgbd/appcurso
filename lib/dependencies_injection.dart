import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'cubit/UserAdmin_cubit.dart';
import 'package:formusers/repository/useradmin_repository.dart';
import 'package:formusers/repository/useradmin_repositoryimp.dart';

/// service locator
final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => AdminUserCubit(sl()));

  sl.registerLazySingleton<IUserAdminRepository>(
      () => UserAdminRepositoryImp(httpClient: sl())
    );
  sl.registerLazySingleton(() => http.Client());
}
