import 'package:elssit/presentation/achievement_screen/achievement_detail_screen.dart';
import 'package:elssit/presentation/achievement_screen/widgets/achievement_item.dart';
import 'package:elssit/presentation/loading_screen/loading_screen.dart';
import 'package:elssit/process/bloc/achievement_bloc.dart';
import 'package:elssit/process/event/achievement_event.dart';
import 'package:elssit/process/state/achievement_state.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/utils/color_constant.dart';
import '../splash_screen/splash_screen.dart';

class AchievementScreen extends StatefulWidget {
  const AchievementScreen({Key? key}) : super(key: key);

  @override
  State<AchievementScreen> createState() => _AchievementScreenState();
}

class _AchievementScreenState extends State<AchievementScreen> {
  final _achievementBloc = AchievementBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _achievementBloc.eventController.sink.add(GetAllAchievementEvent());
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder<AchievementState>(
      stream: _achievementBloc.stateController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_outlined,
                  size: size.height * 0.03,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/accountScreen');
                },
              ),
              title: const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Giải Thưởng & Thành Tích",
                ),
              ),
              titleTextStyle: GoogleFonts.roboto(
                fontSize: size.height * 0.024,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/addNewAchievementScreen');
              },
              elevation: 0.0,
              backgroundColor: ColorConstant.primaryColor,
              child: const Icon(Icons.add),
            ),
            body: Material(
              child: Container(
                width: size.width,
                height: size.height,
                color: Colors.white,
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ((snapshot.data as GetAllAchievementState)
                              .achievementList
                              .data
                              .isEmpty)
                          ? const Text("Chưa có dữ liệu")
                          : ListView.separated(
                              scrollDirection: Axis.vertical,
                              padding: EdgeInsets.only(
                                left: size.width * 0.05,
                                right: size.width * 0.05,
                                top: size.height * 0.03,
                              ),
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AchievementDetailScreen(
                                                achievementID: (snapshot.data
                                                        as GetAllAchievementState)
                                                    .achievementList
                                                    .data[index]
                                                    .id),
                                      ));
                                },
                                child: achievementItem(
                                    context,
                                    (snapshot.data as GetAllAchievementState)
                                        .achievementList
                                        .data[index]),
                              ),
                              separatorBuilder: (context, index) => SizedBox(
                                height: size.height * 0.02,
                              ),
                              itemCount:
                                  (snapshot.data as GetAllAchievementState)
                                      .achievementList
                                      .data
                                      .length,
                            ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return const LoadingScreen();
        }
      },
    );
  }
}
