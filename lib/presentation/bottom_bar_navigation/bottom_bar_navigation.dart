import 'package:elssit/presentation/account_screen/account_screen.dart';
import 'package:elssit/presentation/home_screen/home_screen.dart';
import 'package:elssit/presentation/list_waiting_assign/screen/list_waitting_accept.dart';
import 'package:elssit/presentation/request_screen/request_screen.dart';

import 'package:elssit/presentation/schedule_screen/schedule_screen.dart';
import 'package:elssit/presentation/timeline_tracking/screen/list_item_waitting.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/utils/color_constant.dart';
import '../../core/utils/image_constant.dart';
import '../splash_screen/splash_screen.dart';
import 'dart:math' as math;

// ignore: must_be_immutable
class BottomBarNavigation extends StatefulWidget {
  int selectedIndex = 0;

  bool isBottomNav = true;

  BottomBarNavigation(
      {super.key, required this.selectedIndex, required this.isBottomNav});

  @override
  // ignore: no_logic_in_create_state
  State<BottomBarNavigation> createState() => _BottomBarNavigationState(
      selectedIndex: selectedIndex, isBottomNav: isBottomNav);
}

class _BottomBarNavigationState extends State<BottomBarNavigation> {
  int selectedIndex = 0;
  bool isBottomNav = true;

  _BottomBarNavigationState(
      {required this.selectedIndex, required this.isBottomNav});

  Widget pageCaller(index) {
    switch (selectedIndex) {
      case 0:
        return const HomeScreen();
      case 1:
        return const TimelineListInprogress();
      case 3:
        return const ScheduleScreen();
      case 4:
        return const AccountScreen();
      default:
        return const SplashScreen();
    }
  }

  void _onItemTapped(int index) {
    if(index==2){
Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListWaitingAcceptScreen(),
                        ));
    }else{
       setState(() {
      selectedIndex = index;
    });
    }
   
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Center(
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationZ(
              math.pi / 4,
            ),
            child: Container(
              width: 120,
              height: 120,
              decoration:  BoxDecoration(
                // borderRadius: BorderRadius.only(bottomRight: Radius.circular(2)),
                color: Colors.transparent,
                border: Border(
                  right: BorderSide(width: 3, color: Colors.white),
                  bottom: BorderSide(width: 3, color: Colors.white),
                ),
              ),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [ColorConstant.primaryColor,Colors.white],
                  ),
                  border: Border.all(
                    width: 3,
                    color: ColorConstant.primaryColor,
                  ),
                ),
                child: InkWell(
                  splashColor: ColorConstant.primaryColor,
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ListWaitingAcceptScreen(),
                        ));
                  },
                  child: Center(
                    child: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationZ(
                          -math.pi / 4,
                        ),
                        child: ImageIcon(
                          AssetImage(ImageConstant.icService),
                        )),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: pageCaller(selectedIndex),
      bottomNavigationBar: isBottomNav == true
          ? BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(ImageConstant.icHome),
                  ),
                  label: 'Trang chủ',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(ImageConstant.icRequest),
                  ),
                  label: 'Tiến trình',
                ),
                  BottomNavigationBarItem(
                  icon: Icon(
                  Icons.add,
                  ),
                  label: 'Đơn mới',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(ImageConstant.icSchedule),
                  ),
                  label: 'Lịch Trình',
                ),
                BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage(ImageConstant.icAccount),
                  ),
                  label: 'Tài khoản',
                ),
              ],
              currentIndex: selectedIndex,
              selectedItemColor: ColorConstant.primaryColor,
              selectedLabelStyle: GoogleFonts.roboto(
                color: ColorConstant.primaryColor,
              ),
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Colors.grey,
              unselectedLabelStyle: GoogleFonts.roboto(
                color: Colors.black,
              ),
              showUnselectedLabels: true,
              elevation: 0,
              onTap: _onItemTapped,
            )
          : Container(
              height: 0,
            ),
    );
  }
}
