import 'package:elssit/core/models/booking_models/booking_detail_form_dto.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

class JobDescriptionPanel extends StatefulWidget {
  const JobDescriptionPanel({Key? key, required this.bookingDetail})
      : super(key: key);
  final BookingDetailFormDto bookingDetail;

  @override
  State<JobDescriptionPanel> createState() =>
      _JobDescriptionPanelState(bookingDetail: bookingDetail);
}

class _JobDescriptionPanelState extends State<JobDescriptionPanel> {
  _JobDescriptionPanelState({required this.bookingDetail});

  final BookingDetailFormDto bookingDetail;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: null,
      builder: (context, snapshot) {
        return Container(
          color: Colors.white,
          padding: EdgeInsets.only(
            left: size.width * 0.05,
            right: size.width * 0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   "Thời gian thực hiện",
              //   style: GoogleFonts.roboto(
              //     fontSize: size.height * 0.022,
              //     fontWeight: FontWeight.w500,
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsets.only(
              //     top: size.height * 0.01,
              //     bottom: size.height * 0.02,
              //     left: size.width * 0.05,
              //   ),
              //   child: Text(
              //     "Ngày: ${MyUtils().displayDateTimeInScheduleItem(bookingDetail.startDateTime).split(" ")[0]} - Lúc:  ${MyUtils().displayDateTimeInScheduleItem(bookingDetail.startDateTime).split(" ")[1]}",
              //     style: GoogleFonts.roboto(
              //       fontSize: size.height * 0.022,
              //       fontWeight: FontWeight.w400,
              //     ),
              //   ),
              // ),
              Text(
                "Gói dịch vụ :",
                style: GoogleFonts.roboto(
                  fontSize: size.height * 0.022,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: size.height * 0.01,
                  bottom: size.height * 0.02,
                  left: size.width * 0.05,
                ),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    const Icon(
                      Icons.arrow_forward,
                      size: 17,
                      color: Color(0xFF5CB85C),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    SizedBox(
                      width: size.width * 0.7,
                      child: Text(
                        bookingDetail.packageName,
                        style: GoogleFonts.roboto(
                          fontSize: size.height * 0.02,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.015,
              ),
              Text(
                "Các công việc có trong gói dịch vụ :",
                style: GoogleFonts.roboto(
                  fontSize: size.height * 0.022,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              ListView.separated(
                  padding: EdgeInsets.only(
                    top: size.height * 0.01,
                    left: size.width * 0.05,
                    //bottom: size.height * 0.05,
                  ),
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => Row(
                        children: [
                          const CircleAvatar(
                            radius: 12,
                            backgroundColor: Color(0xFFF1F9F1),
                            child: Icon(
                              Icons.done,
                              size: 17,
                              color: Color(0xFF5CB85C),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: size.width * 0.7,
                              child: Text(
                                bookingDetail
                                    .detailServiceDtos[index].serviceName,
                                style: GoogleFonts.roboto(
                                  fontSize: size.height * 0.02,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black.withOpacity(0.7),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  separatorBuilder: (context, index) => SizedBox(
                        height: size.height * 0.005,
                      ),
                  itemCount: bookingDetail.detailServiceDtos.length),
              SizedBox(
                height: size.height * 0.2,
              ),
              // Row(
              //   children: [
              //     const CircleAvatar(
              //       radius: 12,
              //       backgroundColor: Color(0xFFF1F9F1),
              //       child: Icon(
              //         Icons.done,
              //         size: 17,
              //         color: Color(0xFF5CB85C),
              //       ),
              //     ),
              //     const SizedBox(
              //       width: 10,
              //     ),
              //     ListView.separated(
              //         padding: EdgeInsets.only(
              //           top: size.height * 0.01,
              //           left: size.width * 0.05,
              //         ),
              //         scrollDirection: Axis.vertical,
              //         physics: const BouncingScrollPhysics(),
              //         shrinkWrap: true,
              //         itemBuilder: (context, index) => Text(
              //               bookingDetail.detailServiceDtos[index].serviceName,
              //               style: GoogleFonts.roboto(
              //                 fontSize: size.height * 0.022,
              //                 fontWeight: FontWeight.w400,
              //               ),
              //             ),
              //         separatorBuilder: (context, index) => SizedBox(
              //               height: size.height * 0.005,
              //             ),
              //         itemCount: bookingDetail.detailServiceDtos.length),
              //   ],
              // ),
            ],
          ),
        );
      },
    );
  }
}
