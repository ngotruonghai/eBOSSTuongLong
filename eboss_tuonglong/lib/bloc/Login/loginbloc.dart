import 'package:eboss_tuonglong/Access/keyservices.dart';
import 'package:eboss_tuonglong/Access/sharedpreferencesservice.dart';
import 'package:eboss_tuonglong/bloc/Login/loginstate.dart';
import 'package:eboss_tuonglong/common/loadingoverlay.dart';
import 'package:eboss_tuonglong/common/snackbarerror.dart';
import 'package:eboss_tuonglong/model/Login/loginmodel.dart';
import 'package:eboss_tuonglong/services/NetWorkRequest.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoginEvent.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, Loginstate> {
  LoginBloc() : super(Loginstate.LoginInnitial) {
    on<LoginClickEvent>(_onLoginClick);
    on<LoginInitialEvent>(_onLoadPage);
  }

  Future<void> _onLoadPage(
      LoginInitialEvent event, Emitter<Loginstate> emit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await SharedPreferencesService.init();
    prefs.clear();
    if (prefs.getString(KeyServices.Token) == null) {
      emit(Loginstate.LoginInnitial);
    } else {
      emit(Loginstate.Success);
    }
  }

  Future<void> _onLoginClick(
      LoginClickEvent event, Emitter<Loginstate> emit) async {
    try {
      if (event.username == "" || event.password == "") {
        SnackbarError.showSnackbar_Waiting(event.context,
            message: "Vui lòng điền đầy đủ thông tin!");
      } else {
        LoadingOverlay.show(event.context);
        /* Cal API */
        Map<String, dynamic> request = {
          "userName": event.username,
          "password": event.password
        };
        final response = await NetWorkRequest.PostDefault(
            "/api/User/LoginUser", request, event.context);
        final reponse = LoginModel.fromJson(response);

        if (reponse.code == 200) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await SharedPreferencesService.init();
          prefs.setString(
              KeyServices.Token, reponse.data!.token.toString());
          prefs.setString(
              KeyServices.UserName, reponse.data!.userName.toString());
          prefs.setString(
              KeyServices.EmployeeAID, reponse.data!.employeeAID.toString());

          emit(Loginstate.Success);
        }
        LoadingOverlay.hide(event.context);        
      }
    } catch (e) {
      LoadingOverlay.hide(event.context);
    }
  }
}
