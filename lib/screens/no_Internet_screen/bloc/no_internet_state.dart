part of 'no_internet_bloc.dart';

sealed class NoInternetState extends Equatable {
  const NoInternetState();
}

class ConnectivityInitial extends NoInternetState {
  const ConnectivityInitial();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ConnectivityConnected extends NoInternetState {
  const ConnectivityConnected();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ConnectivityDisconnected extends NoInternetState {
  const ConnectivityDisconnected();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}
