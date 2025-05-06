part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

class OnUsernameChanged extends AuthEvent {
  final String usernameOrEmail;

  const OnUsernameChanged(this.usernameOrEmail);

  @override
  List<Object?> get props => [usernameOrEmail];
}

class OnEmailChanged extends AuthEvent {
  final String email;

  const OnEmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

class OnPasswordChanged extends AuthEvent {
  final String password;

  const OnPasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

class OnConfirmPasswordChanged extends AuthEvent {
  final String confirmPassword;

  const OnConfirmPasswordChanged(this.confirmPassword);

  @override
  List<Object?> get props => [confirmPassword];
}

class OnLoginButtonPressed extends AuthEvent {
  const OnLoginButtonPressed();

  @override
  List<Object?> get props => [];
}

class OnCreateAccountButtonPressed extends AuthEvent {
  const OnCreateAccountButtonPressed();

  @override
  List<Object?> get props => [];
}

class OnForgotPasswordButtonPressed extends AuthEvent {
  const OnForgotPasswordButtonPressed();

  @override
  List<Object?> get props => [];
}
