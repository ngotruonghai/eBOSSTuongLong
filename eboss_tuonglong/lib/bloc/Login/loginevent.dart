import 'package:flutter/material.dart';

abstract class LoginEvent {}

class LoginInitialEvent extends LoginEvent {
  LoginInitialEvent(this.context);
  final BuildContext context;
}

class LoginClickEvent extends LoginEvent {
  LoginClickEvent(this.username, this.password, this.context);
  final String username;
  final String password;
  final BuildContext context;
}

class LoginInProgressEvent extends LoginEvent{}
