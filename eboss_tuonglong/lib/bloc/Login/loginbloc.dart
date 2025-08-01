import 'package:eboss_tuonglong/Access/keyservices.dart';
import 'package:eboss_tuonglong/Access/mobilelanguageprovider.dart';
import 'package:eboss_tuonglong/Access/sharedpreferencesservice.dart';
import 'package:eboss_tuonglong/bloc/Login/loginstate.dart';
import 'package:eboss_tuonglong/common/loadingoverlay.dart';
import 'package:eboss_tuonglong/common/snackbarerror.dart';
import 'package:eboss_tuonglong/databaseHelper/mobilelanguageProvider.dart';
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
    LoginInitialEvent event,
    Emitter<Loginstate> emit,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await SharedPreferencesService.init();
      if (prefs.containsKey(KeyServices.Token) == false) {
        emit(Loginstate.LoginInnitial);
      } else {
        // check token
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? refreshToken = prefs.getString(KeyServices.Token);
        if (refreshToken == null || refreshToken.isEmpty) {
          emit(Loginstate.LoginInnitial);
          return;
        }
        LoadingOverlay.show(event.context);

        Map<String, dynamic> request = {
          "token": prefs.get(KeyServices.Token),
          "refestToken": prefs.get(KeyServices.RefestToken),
          "mobileCode": "ebossMobile",
          "ip": "NULL",
        };
        final response = await NetWorkRequest.PostDefault(
          "/api/User/RefestTokenNew",
          request,
          event.context,
        );
        final reponse = LoginModel.fromJson(response);

        if (reponse.data?.allowAccess == true) {
          prefs.setString(KeyServices.Token, reponse.data!.token.toString());
          prefs.setString(
            KeyServices.RefestToken,
            reponse.data!.refreshToken.toString(),
          );
          await LoadAppMobileLanguage.LoadOldData();
          emit(Loginstate.Success);
          LoadingOverlay.hide(event.context);
        } else {
          emit(Loginstate.LoginInnitial);
          LoadingOverlay.hide(event.context);
        }
      }
    } catch (e) {
      emit(Loginstate.LoginInnitial);
      LoadingOverlay.hide(event.context);
    }
  }

  Future<void> _onLoginClick(
    LoginClickEvent event,
    Emitter<Loginstate> emit,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String lang =  prefs.get(KeyServices.Language).toString();
      if (event.username == "" || event.password == "") {
        SnackbarError.showSnackbar_Waiting(
          event.context,
          message: lang == "EN" ? "Please fill in all information":"Vui lòng điền đầy đủ thông tin!",
        );
      } else {
        LoadingOverlay.show(event.context);
        /* Cal API */
        Map<String, dynamic> request = {
          "userName": event.username,
          "password": event.password,
        };
        final response = await NetWorkRequest.PostDefault(
          "/api/User/LoginUser",
          request,
          event.context,
        );
        final reponse = LoginModel.fromJson(response);

        LoadingOverlay.hide(event.context);

        if (reponse.data?.allowAccess == true) {
          
          await SharedPreferencesService.init();
          prefs.setString(KeyServices.Token, reponse.data!.token.toString());
          prefs.setString(
            KeyServices.UserName,
            reponse.data!.userName.toString(),
          );
          prefs.setString(
            KeyServices.EmployeeAID,
            reponse.data!.employeeAID.toString(),
          );
          prefs.setString(
            KeyServices.RefestToken,
            reponse.data!.refreshToken.toString(),
          );

          await LoadAppMobileLanguage.clearData();
          await LoadAppMobileLanguage.updateLanguage();
          emit(Loginstate.Success);
        } else if (reponse.data?.allowAccess == false) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await SharedPreferencesService.init();
          prefs.setString(KeyServices.Token, reponse.data!.token.toString());
          prefs.setString(
            KeyServices.UserName,
            reponse.data!.userName.toString(),
          );
          prefs.setString(
            KeyServices.EmployeeAID,
            reponse.data!.employeeAID.toString(),
          );
          prefs.setString(
            KeyServices.RefestToken,
            reponse.data!.refreshToken.toString(),
          );
          await LoadAppMobileLanguage.clearData();
          await LoadAppMobileLanguage.updateLanguage();
          emit(Loginstate.CreateUser);
        } else {
          emit(Loginstate.LoginInnitial);
        }
      }
    } catch (e) {
      LoadingOverlay.hide(event.context);
    }
  }
}
