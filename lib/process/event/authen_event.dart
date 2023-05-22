import 'package:flutter/material.dart';

abstract class AuthenEvent {}

class LoginEvent extends AuthenEvent {
  LoginEvent(this.context);

  final BuildContext context;
}

class InputEmailEvent extends AuthenEvent {
  InputEmailEvent({required this.email});

  final String email;
}

class InputPasswordEvent extends AuthenEvent {
  InputPasswordEvent({required this.password});

  final String password;
}

class InputRePasswordEvent extends AuthenEvent {
  InputRePasswordEvent({required this.rePassword});

  final String rePassword;
}

class InputOldPasswordEvent extends AuthenEvent {
  InputOldPasswordEvent({required this.oldPassword});

  final String oldPassword;
}

class MaintainLoginEvent extends AuthenEvent {
  MaintainLoginEvent(this.context);

  final BuildContext context;
}

class LogoutEvent extends AuthenEvent {
  LogoutEvent(this.context);

  final BuildContext context;
}

class LoadInfo extends AuthenEvent {
  LoadInfo({required this.context});
  final BuildContext context;
}

class LoginWithGoogle extends AuthenEvent {
  LoginWithGoogle(this.email, this.fullName, this.dob, this.gender, this.token,
      this.context);

  final String email;
  final String fullName;
  final String dob;
  final String gender;
  final String token;
  final BuildContext context;
}
class ChangePasswordAuthenEvent extends AuthenEvent {
  ChangePasswordAuthenEvent({required this.context});

  final BuildContext context;
}
