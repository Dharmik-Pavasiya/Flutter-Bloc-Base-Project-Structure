import 'package:get_it/get_it.dart';
import 'package:flutter_bloc_base_structure/common/bloc/language_bloc.dart';
import 'package:flutter_bloc_base_structure/common/network/api_base.dart';
import 'package:flutter_bloc_base_structure/common/network/api_service.dart';

import '../../../common/bloc/app_loader/app_loader_cubit.dart';
import '../../../screens/auth/data/repository/auth_repository.dart';
import '../../../screens/auth/data/repository/auth_repository_impl.dart';
import '../../../screens/no_Internet_screen/bloc/no_internet_bloc.dart';

final sl = GetIt.instance;

class DependencyInjectorContainer {
  static Future<void> init() async {
    // Registering the Cubits
    sl.registerLazySingleton<NoInternetBloc>(() => NoInternetBloc());
    sl.registerLazySingleton<LanguageBloc>(() => LanguageBloc());
    sl.registerLazySingleton<AppLoaderCubit>(() => AppLoaderCubit());

    // Registering the Repositories
    sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());

    // Registering the Api Service
    sl.registerLazySingleton<ApiBaseService>(() => ApiService());
  }
}
