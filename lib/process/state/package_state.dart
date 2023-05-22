import 'package:elssit/core/models/package_service_models/package_service_all_model.dart';
import 'package:elssit/core/models/package_service_models/package_service_detail_data_model.dart';

abstract class PackageState {}

class OtherPackageState extends PackageState {}

class GetAllPackageState extends PackageState {
  GetAllPackageState({required this.packageList});

  PackageServiceAllModel packageList;
}

class GetHavePackageState extends PackageState {
  GetHavePackageState({required this.packageList});

  PackageServiceAllModel packageList;
}

class GetNotHavePackageState extends PackageState {
  GetNotHavePackageState({required this.packageList});

  PackageServiceAllModel packageList;
}

class GetPackageServiceDetailState extends PackageState {
  GetPackageServiceDetailState({required this.packageDetail});

  PackageServiceDetailDataModel packageDetail;
}

class CheckPackageState extends PackageState {
  CheckPackageState({required this.listPackage});

  List<String> listPackage;
}
