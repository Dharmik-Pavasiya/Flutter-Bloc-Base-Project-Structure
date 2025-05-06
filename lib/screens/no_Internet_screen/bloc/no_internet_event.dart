part of 'no_internet_bloc.dart';

sealed class NoInternetEvent extends Equatable {
  const NoInternetEvent();
}

class CheckConnectivity extends NoInternetEvent {
  const CheckConnectivity();

  @override
  List<Object?> get props => [];
}

class ConnectivityChanged extends NoInternetEvent {
  final bool isConnected;

  const ConnectivityChanged(this.isConnected);

  @override
  List<Object?> get props => [isConnected];
}
