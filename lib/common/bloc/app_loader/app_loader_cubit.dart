import 'package:flutter_bloc/flutter_bloc.dart';

class AppLoaderCubit extends Cubit<bool> {
  AppLoaderCubit() : super(false);

  void showLoader() => emit(true);

  void hideLoader() => emit(false);
}
