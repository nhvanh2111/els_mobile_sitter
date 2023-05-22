import 'package:elssit/process/bloc/package_bloc.dart';
import 'package:flutter/material.dart';

abstract class PackageEvent {}

class GetAllPackageEvent extends PackageEvent {
  GetAllPackageEvent();
}

class OtherPackageEvent extends PackageEvent{}

class GetHavePackageEvent extends PackageEvent {}

class GetNotHavePackageEvent extends PackageEvent {}

class CheckPackageEvent extends PackageEvent {
  CheckPackageEvent({required this.packageID});

  String packageID;
}

class SaveListPackageEvent extends PackageEvent {
  SaveListPackageEvent({required this.context, required this.packageBloc});

  final BuildContext context;
  final PackageBloc packageBloc;
}

class GetPackageServiceDetailEvent extends PackageEvent {
  GetPackageServiceDetailEvent({required this.packageServiceID});

  String packageServiceID;
}

class ConfirmSendFormEvent extends PackageEvent {
  ConfirmSendFormEvent({required this.context});

  final BuildContext context;
}
