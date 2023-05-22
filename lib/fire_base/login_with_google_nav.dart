import 'package:elssit/process/bloc/authen_bloc.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';

import 'package:elssit/process/event/authen_event.dart';
import 'package:elssit/process/bloc/authen_bloc.dart';
import '../presentation/login_with_google_split_role/login_with_google_split_role.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/login_screen/login_screen.dart';

class LoginWithGoogleNav extends StatefulWidget {
  const LoginWithGoogleNav({super.key});

  @override
  State<LoginWithGoogleNav> createState() => _LoginWithGoogleNavState();
}

class _LoginWithGoogleNavState extends State<LoginWithGoogleNav> {
  final _elsBox = Hive.box('elsBox');
  final _authenBloc = AuthenBloc();

  @override
  void initState() {
    super.initState();
    if (_elsBox.get('checkLogin') != null) {
      if (_elsBox.get('checkLogin')) {
        _authenBloc.eventController.sink.add(MaintainLoginEvent(context));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      child: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashScreen();
          } else if (snapshot.hasData) {
            return LoginWithGoogleSplitRole(user: FirebaseAuth.instance.currentUser!);
          } else if (snapshot.hasError) {
            return const SplashScreen();
          } else {
            if(_elsBox.get('checkLogin') != null){
              if(_elsBox.get('checkLogin')){
                return const SplashScreen();
              }else{
                return const LoginScreen();
              }
            }else{
              return const LoginScreen();
            }
          }
        },
      ),
    );
  }
}
