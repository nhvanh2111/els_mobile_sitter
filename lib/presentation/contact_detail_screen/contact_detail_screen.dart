import 'package:elssit/presentation/search_address_screen/search_address_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/globals.dart' as globals;
import 'package:elssit/core/utils/color_constant.dart';
import 'package:elssit/core/models/sitter_models/sitter_detail_data_model.dart';

import 'package:elssit/process/bloc/sitter_bloc.dart';
import 'package:elssit/process/event/sitter_event.dart';
import 'package:elssit/process/state/sitter_state.dart';

class ContactDetailScreen extends StatefulWidget {
  const ContactDetailScreen({Key? key}) : super(key: key);

  @override
  State<ContactDetailScreen> createState() => _ContactDetailScreenState();
}

class _ContactDetailScreenState extends State<ContactDetailScreen> {
  final _sitBloc = SitBloc();

  late var emailController = TextEditingController();
  late var phoneController = TextEditingController();
  late var descriptionController = TextEditingController();
  late var addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: globals.email);
    _sitBloc.eventController.sink.add(GetContactSitEvent());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final ThemeData theme = ThemeData();
    return StreamBuilder<SitState>(
      stream: _sitBloc.stateController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data is SitDetailState) {
            SitDetailDataModel sitInfo =
                (snapshot.data as SitDetailState).sitInfo;
            if (sitInfo.address.isNotEmpty) {
              _sitBloc.eventController.sink
                  .add(FillAddressSitEvent(address: sitInfo.address));
              addressController = TextEditingController(text: sitInfo.address);
            }
            _sitBloc.eventController.sink
                .add(FillPhoneSitEvent(phone: sitInfo.phone));
            phoneController = TextEditingController(text: sitInfo.phone);
            _sitBloc.eventController.sink
                .add(FillDescriptionSitEvent(description: sitInfo.description));
            descriptionController =
                TextEditingController(text: sitInfo.description);

            _sitBloc.eventController.sink.add(SitOtherEvent());
          }
        }
        if (snapshot.data is UpdateAddressState) {
          addressController = TextEditingController(text: _sitBloc.address);
        }
        print(snapshot.data);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            bottomOpacity: 0.0,
            elevation: 0.0,
            leading: (globals.sitterStatus == "CREATED" || globals.sitterStatus == "REJECTED")
                ? const SizedBox()
                : GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_rounded,
                size: size.height * 0.03,
                color: Colors.black,
              ),
            ),
            title: Padding(
              padding: EdgeInsets.only(left: size.width * 0.005),
              child: const Text(
                "Thông Tin Liên Lạc",
              ),
            ),
            titleTextStyle: GoogleFonts.roboto(
              fontSize: size.height * 0.028,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          body: Container(
            color: Colors.white,
            height: size.height,
            width: size.width,
            padding: EdgeInsets.only(
              left: size.width * 0.07,
              right: size.width * 0.07,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Địa chỉ',
                      style: GoogleFonts.roboto(
                        color: ColorConstant.gray43,
                        fontWeight: FontWeight.w400,
                        fontSize: size.height * 0.02,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: size.height * 0.01,
                    ),
                    decoration: BoxDecoration(
                      color: ColorConstant.whiteF3,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Theme(
                      data: theme.copyWith(
                        colorScheme: theme.colorScheme
                            .copyWith(primary: ColorConstant.primaryColor),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SearchAddressPage(sitBloc: _sitBloc),
                              ));
                        },
                        child: TextField(
                          enabled: false,
                          onChanged: (value) {},
                          style: TextStyle(
                            fontSize: size.width * 0.04,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          cursorColor: ColorConstant.primaryColor,
                          controller: addressController,
                          decoration: InputDecoration(
                            hintText: "Địa chỉ hiện tại",
                            prefixIcon: SizedBox(
                              width: size.width * 0.05,
                              child: Icon(
                                Icons.location_on,
                                size: size.width * 0.05,
                              ),
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15)),
                              borderSide: BorderSide(
                                width: 1,
                                color: ColorConstant.primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  (snapshot.hasError &&
                          (snapshot.error as Map<String, String>)
                              .containsKey("address"))
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            (snapshot.error as Map<String, String>)["address"]!,
                            style: TextStyle(
                              color: ColorConstant.redFail,
                              fontSize: size.height * 0.017,
                            ),
                          ),
                        )
                      : const SizedBox(),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Số điện thoại',
                      style: GoogleFonts.roboto(
                        color: ColorConstant.gray43,
                        fontWeight: FontWeight.w400,
                        fontSize: size.height * 0.02,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      bottom: size.height * 0.01,
                    ),
                    decoration: BoxDecoration(
                      color: ColorConstant.whiteF3,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Theme(
                      data: theme.copyWith(
                        colorScheme: theme.colorScheme
                            .copyWith(primary: ColorConstant.primaryColor),
                      ),
                      child: TextField(
                        onChanged: (value) {
                          _sitBloc.eventController.sink
                              .add(FillPhoneSitEvent(phone: value.toString()));
                        },
                        style: TextStyle(
                          fontSize: size.width * 0.04,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        cursorColor: ColorConstant.primaryColor,
                        controller: phoneController,
                        enabled: true,
                        decoration: InputDecoration(
                          hintText: "Số điện thoại",
                          prefixIcon: SizedBox(
                            width: size.width * 0.05,
                            child: Icon(
                              Icons.phone,
                              size: size.width * 0.05,
                            ),
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(
                              width: 1,
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  (snapshot.hasError &&
                          (snapshot.error as Map<String, String>)
                              .containsKey("phone"))
                      ? Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            (snapshot.error as Map<String, String>)["phone"]!,
                            style: TextStyle(
                              color: ColorConstant.redFail,
                              fontSize: size.height * 0.017,
                            ),
                          ),
                        )
                      : const SizedBox(),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Email',
                      style: GoogleFonts.roboto(
                        color: ColorConstant.gray43,
                        fontWeight: FontWeight.w400,
                        fontSize: size.height * 0.02,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorConstant.whiteF3,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    child: TextField(
                      style: TextStyle(
                        fontSize: size.width * 0.04,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      cursorColor: ColorConstant.primaryColor,
                      controller: emailController,
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: "Email",
                        prefixIcon: SizedBox(
                          width: size.width * 0.05,
                          child: Icon(
                            Icons.email,
                            size: size.width * 0.05,
                          ),
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(
                            width: 1,
                            color: ColorConstant.primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Giới thiệu bản thân (nhiều nhất 100 kí tự)',
                      style: GoogleFonts.roboto(
                        color: ColorConstant.gray43,
                        fontWeight: FontWeight.w400,
                        fontSize: size.height * 0.02,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorConstant.whiteF3,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                    ),
                    child: Theme(
                      data: theme.copyWith(
                        colorScheme: theme.colorScheme
                            .copyWith(primary: ColorConstant.primaryColor),
                      ),
                      child: TextField(
                        onChanged: (value) {
                          _sitBloc.eventController.sink.add(
                              FillDescriptionSitEvent(
                                  description: value.toString()));
                        },
                        maxLines: 11,
                        style: TextStyle(
                          fontSize: size.width * 0.04,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                        cursorColor: ColorConstant.primaryColor,
                        controller: descriptionController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(
                            left: size.width * 0.04,
                            top: size.height * 0.05,
                          ),
                          hintText: "...",
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(
                              width: 1,
                              color: ColorConstant.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  Container(
                    height: 1,
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      color: ColorConstant.whiteEE,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: size.height * 0.07,
                    child: ElevatedButton(
                      onPressed: () {
                        _sitBloc.eventController.sink
                            .add(UpdateContactDetailSitEvent(context: context));
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(color: ColorConstant.primaryColor),
                        ),
                        backgroundColor: ColorConstant.primaryColor,
                        textStyle: TextStyle(
                          fontSize: size.width * 0.045,
                        ),
                      ),
                      child: (globals.sitterStatus == "CREATED" || globals.sitterStatus == "REJECTED") ? const Text("Tiếp theo") : const Text("Lưu"),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
