import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentapp/authentication/auth_service.dart';
import 'package:rentapp/localstorage/local_storage.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(InitialState()) {
    on<AuthEvent>((event, emit) async {
      if (event is AttemptingLoginEvent) {
        emit(LoggingInState());

        try {
          final response =
              await AuthService().login(event.email, event.password);
          if (response['status_code'] == 200) {
            await LocalStorageService()
                .setDataToStorage('db_token', response['token']);

            await LocalStorageService()
                .setDataToStorage('id', response['userid']);

            emit(LoginSuccessState());
          } else {
            emit(LoginFailState(response['error']));
          }
        } catch (e) {
          emit(LoginFailState('$e'));
        }
      } else if (event is AttemptingSignUpEvent) {
        emit(SignUpState());

        try {
          final response = await AuthService()
              .signUp(event.name, event.email, event.password);
          if (response['status_code'] == 200) {
            await LocalStorageService()
                .setDataToStorage('db_token', response['token']);

            await LocalStorageService()
                .setDataToStorage('id', response['userid']);

            emit(SignUpSuccessState());
          } else {
            emit(SignUpFailState(response['error']));
          }
        } catch (e) {
          emit(SignUpFailState('$e'));
        }
      } else if (event is SendingEmailEvent) {
        emit(SendMailState());
        final response = await AuthService().sendVerificationEmail(event.email);

        try {
          if (response['status_code'] == 200) {
            emit(SendMailSuccessState());
          } else {
            emit(SendMailFailState(response['error']));
          }
        } catch (e) {
          emit(SendMailFailState('$e'));
        }
      } else if (event is VerifyingEmailEvent) {
        emit(VerifyMailState());
        final response =
            await AuthService().verifyEmail(event.email, event.otp);

        try {
          if (response['status_code'] == 200) {
            emit(VerifyMailSuccessState());
          } else {
            emit(VerifyMailFailState(response['error']));
          }
        } catch (e) {
          emit(VerifyMailFailState('$e'));
        }
      }
    });
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

class AttemptingSignUpEvent extends AuthEvent {
  String name;
  String email;
  String password;

  AttemptingSignUpEvent({
    required this.name,
    required this.email,
    required this.password,
  });
}

class SignUpState extends AuthState {}

class SignUpSuccessState extends AuthState {}

class SignUpFailState extends AuthState {
  String error;
  SignUpFailState(this.error);
}

class SendingEmailEvent extends AuthEvent {
  String email;

  SendingEmailEvent({
    required this.email,
  });
}

class SendMailState extends AuthState {}

class SendMailSuccessState extends AuthState {}

class SendMailFailState extends AuthState {
  String error;

  SendMailFailState(this.error);
}

class VerifyingEmailEvent extends AuthEvent {
  String email;
  String otp;

  VerifyingEmailEvent({
    required this.email,
    required this.otp,
  });
}

class VerifyMailState extends AuthState {}

class VerifyMailSuccessState extends AuthState {}

class VerifyMailFailState extends AuthState {
  String error;

  VerifyMailFailState(this.error);
}
