import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_base_structure/common/bloc/app_loader/app_loader_cubit.dart';
import 'package:flutter_bloc_base_structure/service/toastification_service.dart';

import '../../../config/di/di/dependency_injector_container.dart';
import '../data/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepo;

  AuthBloc({required this.authRepo}) : super(AuthState()) {
    on<OnUsernameChanged>(_onUserNameOrEmailChanged);
    on<OnEmailChanged>(_onEmailChanged);
    on<OnPasswordChanged>(_onPasswordChanged);
    on<OnConfirmPasswordChanged>(_onConfirmPasswordChanged);
    on<OnLoginButtonPressed>(_onLoginButtonPressed);
    on<OnCreateAccountButtonPressed>(_onCreateAccountButtonPressed);
    on<OnForgotPasswordButtonPressed>(_onForgotPasswordButtonPressed);
  }

  void _onUserNameOrEmailChanged(
    OnUsernameChanged event,
    Emitter<AuthState> emit,
  ) {
    emit(state.copyWith(userName: event.usernameOrEmail));
  }

  void _onEmailChanged(OnEmailChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordChanged(OnPasswordChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _onConfirmPasswordChanged(
    OnConfirmPasswordChanged event,
    Emitter<AuthState> emit,
  ) {
    print("confirm password : ${event.confirmPassword}");
    emit(state.copyWith(confirmPassword: event.confirmPassword));
  }

  void _onLoginButtonPressed(
    OnLoginButtonPressed event,
    Emitter<AuthState> emit,
  ) async {
    sl<AppLoaderCubit>().showLoader();
    final result = await authRepo.login(
      usernameOrEmail: state.userName ?? '',
      password: state.password ?? '',
    );
    result.fold(
      ifLeft: (exception) {
        sl<AppLoaderCubit>().hideLoader();
        ToastService.instance.showError(title: exception);
      },
      ifRight: (data) {
        ToastService.instance.showSuccess(title: data.message);
      },
      whenDone: () {
        sl<AppLoaderCubit>().hideLoader();
      },
    );
  }

  void _onCreateAccountButtonPressed(
    OnCreateAccountButtonPressed event,
    Emitter<AuthState> emit,
  ) async {
    sl<AppLoaderCubit>().showLoader();
    final result = await authRepo.register(
      username: state.userName ?? '',
      email: state.email ?? '',
      password: state.password ?? '',
      confirmPassword: state.confirmPassword ?? '',
    );
    result.fold(
      ifLeft: (exception) {
        sl<AppLoaderCubit>().hideLoader();
        ToastService.instance.showError(title: exception);
      },
      ifRight: (data) {
        ToastService.instance.showSuccess(title: data.message);
      },
      whenDone: () {
        sl<AppLoaderCubit>().hideLoader();
      },
    );
  }

  void _onForgotPasswordButtonPressed(
    OnForgotPasswordButtonPressed event,
    Emitter<AuthState> emit,
  ) async {
    sl<AppLoaderCubit>().showLoader();
    final result = await authRepo.forgotPassword(email: state.email ?? '');
    result.fold(
      ifLeft: (exception) {
        sl<AppLoaderCubit>().hideLoader();
        ToastService.instance.showError(title: exception);
      },
      ifRight: (data) {
        ToastService.instance.showSuccess(title: data.message);
      },
      whenDone: () {
        sl<AppLoaderCubit>().hideLoader();
      },
    );
  }
}
