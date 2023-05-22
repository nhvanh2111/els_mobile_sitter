import 'package:elssit/core/models/sitter_models/sitter_detail_data_model.dart';
import 'package:flutter/material.dart';

import '../../core/models/identify_information_models/identify_information_model.dart';

abstract class SitState {}

class SitOtherState extends SitState {}

class SitDetailState extends SitState {
  SitDetailState({required this.sitInfo});
  SitDetailDataModel sitInfo;
}

class LoadIdentifyInfoSitState extends SitState{
}

class SitDobState extends SitState{
  SitDobState({required this.dobController});
  final TextEditingController dobController;
}
class UpdateAddressState extends SitState {
}
