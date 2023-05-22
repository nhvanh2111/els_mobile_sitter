
import 'package:elssit/process/state/report_state.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/models/rating_model/rating_data_model.dart';
import '../../../process/bloc/rating_bloc.dart';
import '../../../process/event/rating_event.dart';
import '../../../process/state/rating_state.dart';

class RatingPanel extends StatefulWidget {
  const RatingPanel({super.key});

  @override
  State<RatingPanel> createState() => _RatingPanelState();
}

class _RatingPanelState extends State<RatingPanel> {
  final ratingBloc = RatingBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ratingBloc.eventController.sink.add(GetAllRatingEvent());
  }



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder(
        stream: ratingBloc.stateController.stream,
        builder: (context, snapshot) {
          RatingDataModel ratingData = RatingDataModel(
              countOneRate: 0,
              countTwoRate: 0,
              countThreeRate: 0,
              countFourRate: 0,
              countFiveRate: 0,
              hasTag: "",
              average: "0");
          if (snapshot.hasData) {
            if (snapshot.data is GetAllRatingState) {
              ratingData =
                  (snapshot.data as GetAllRatingState)
                      .ratingData;
            }
          }
          return Material(
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

                    Padding(
                      padding: EdgeInsets.only(
                        left: size.width * 0.07,
                        top: size.height * 0.03,
                      ),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        children: [
                          Text(
                            "Điểm trung bình: ",
                            style: GoogleFonts.roboto(
                              fontSize: size.height * 0.022,
                              fontWeight: FontWeight.w400,
                              color:
                              Colors.black.withOpacity(0.8),
                            ),
                          ),
                          Text(
                            "${(ratingData.average != "NaN") ? ratingData.average : "0" } - ${ratingData.countFiveRate + ratingData.countFourRate + ratingData.countThreeRate + ratingData.countTwoRate + ratingData.countOneRate} lượt",
                            style: GoogleFonts.roboto(
                              fontSize: size.height * 0.022,
                              fontWeight: FontWeight.w400,
                              color:
                              Colors.black.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: size.width * 0.07,
                        top: size.height * 0.015,
                      ),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        children: [
                          Text(
                            "5 sao: ${ratingData.countFiveRate} lượt",
                            style: GoogleFonts.roboto(
                              fontSize: size.height * 0.022,
                              fontWeight: FontWeight.w400,
                              color:
                              Colors.black.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: size.width * 0.07,
                        top: size.height * 0.015,
                      ),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        children: [
                          Text(
                            "4 sao: ${ratingData.countFourRate} lượt",
                            style: GoogleFonts.roboto(
                              fontSize: size.height * 0.022,
                              fontWeight: FontWeight.w400,
                              color:
                              Colors.black.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: size.width * 0.07,
                        top: size.height * 0.015,
                      ),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        children: [
                          Text(
                            "3 sao: ${ratingData.countThreeRate} lượt",
                            style: GoogleFonts.roboto(
                              fontSize: size.height * 0.022,
                              fontWeight: FontWeight.w400,
                              color:
                              Colors.black.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: size.width * 0.07,
                        top: size.height * 0.015,
                      ),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        children: [
                          Text(
                            "2 sao: ${ratingData.countTwoRate} lượt",
                            style: GoogleFonts.roboto(
                              fontSize: size.height * 0.022,
                              fontWeight: FontWeight.w400,
                              color:
                              Colors.black.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: size.width * 0.07,
                        top: size.height * 0.015,
                      ),
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.start,
                        children: [
                          Text(
                            "1 sao: ${ratingData.countOneRate} lượt",
                            style: GoogleFonts.roboto(
                              fontSize: size.height * 0.022,
                              fontWeight: FontWeight.w400,
                              color:
                              Colors.black.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
          }
        );
  }
}
