import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(InitialState()) {
    on<AuthEvent>((event, emit) async {});
  }
}

abstract class AuthEvent {}

abstract class AuthState {}

class AttemptingLoginEvent extends AuthEvent {
  String email;
  String password;

  AttemptingLoginEvent({required this.email, required this.password});
}

class InitialState extends AuthState {}

class LoggingInState extends AuthState {}

class LoginSuccessState extends AuthState {}

class LoginFailState extends AuthState {
  String error;

  LoginFailState(this.error);
}
