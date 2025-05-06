import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_base_structure/core/app_extension.dart';

typedef EventType = Object?;
typedef StateType = Object?;

typedef BlocType = BlocBase<StateType>;

typedef ChangeType = Change<StateType>;
typedef TransitionType = Transition<EventType, StateType>;

typedef ErrorType = Object;
typedef StackTraceType = StackTrace;

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocType bloc) {
    "==================== 🔵 Bloc Created 🔵 ====================".printSuccess;
    "[NAME] => ${bloc.runtimeType}".printSuccess;
    "==================== 🔵 Bloc Created 🔵 ====================\n"
        .printSuccess;
    super.onCreate(bloc);
  }

  @override
  void onEvent(Bloc bloc, EventType event) {
    "==================== 🎯 Event Added 🎯 ====================".printSuccess;
    "[BLOC] => ${bloc.runtimeType}".printSuccess;
    "[EVENT] => $event".printSuccess;
    "==================== 🎯 Event Added 🎯 ====================\n"
        .printSuccess;
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocType bloc, ChangeType change) {
    "==================== 🔄 State Changed 🔄 ===================="
        .printSuccess;
    "[BLOC]   => ${bloc.runtimeType}".printSuccess;
    "[FROM]   => ${change.currentState}".printSuccess;
    "[TO]     => ${change.nextState}".printSuccess;
    "==================== 🔄 State Changed 🔄 ====================\n"
        .printSuccess;
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, TransitionType transition) {
    "==================== 🚦 Transition 🚦 ====================".printSuccess;
    "[BLOC]      => ${bloc.runtimeType}".printSuccess;
    "[EVENT]     => ${transition.event}".printSuccess;
    "[FROM]      => ${transition.currentState}".printSuccess;
    "[TO]        => ${transition.nextState}".printSuccess;
    "==================== 🚦 Transition 🚦 ====================\n".printSuccess;
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocType bloc, ErrorType error, StackTraceType stackTrace) {
    "\n==================== 🔴 Error Occurred 🔴 ====================\n[BLOC]  => ${bloc.runtimeType}\n[ERROR] => $error\n[STACK] => $stackTrace\n==================== 🔴 Error Occurred 🔴 ====================\n"
        .printError;
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocType bloc) {
    "==================== ⚫ Bloc Closed ⚫ ====================".printSuccess;
    "[BLOC]  => ${bloc.runtimeType}".printSuccess;
    "==================== ⚫ Bloc Closed ⚫ ====================\n".printSuccess;
    super.onClose(bloc);
  }
}
