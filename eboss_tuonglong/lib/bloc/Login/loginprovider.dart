import 'package:eboss_tuonglong/bloc/Login/LoginBloc.dart';
import 'package:eboss_tuonglong/bloc/Login/LoginEvent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginProvider extends StatelessWidget {
  final Widget child;
  const LoginProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return (BlocProvider<LoginBloc>(
      create: (BuildContext context) {
        // Khởi tạo LoginBloc và gửi sự kiện InitLoginEvent
        final loginBloc = LoginBloc()..add(LoginInitialEvent(context));
        return loginBloc;
      },
      child: child,
    ));
  }
}
