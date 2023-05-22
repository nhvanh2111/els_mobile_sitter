
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../core/utils/globals.dart' as globals;
import '../../process/bloc/authen_bloc.dart';
import '../../process/event/authen_event.dart';
import '../splash_screen/splash_screen.dart';

// ignore: must_be_immutable
class LoginWithGoogleSplitRole extends StatefulWidget {
  User user;

  LoginWithGoogleSplitRole({super.key, required this.user});

  @override
  State<LoginWithGoogleSplitRole> createState() =>
      // ignore: no_logic_in_create_state
      _LoginWithGoogleSplitRoleState(user: user);
}

class _LoginWithGoogleSplitRoleState extends State<LoginWithGoogleSplitRole> {
  User user;

  _LoginWithGoogleSplitRoleState({required this.user});

  final _authenBloc = AuthenBloc();

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    _authenBloc.eventController.sink.add(LoginWithGoogle(user.email.toString(),
        user.displayName.toString(), "", "", globals.deviceID, context));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _authenBloc.stateController.stream,
      builder: (context, snapshot) {
        return const SplashScreen();
      },
    );
    // TODO: implement build
  }
}
