import 'package:elssit/presentation/home_screen/widgets/balance_item.dart';
import 'package:flutter/Material.dart';
import 'package:google_fonts/google_fonts.dart';

class BalancePanel extends StatefulWidget {
  const BalancePanel({Key? key}) : super(key: key);

  @override
  State<BalancePanel> createState() => _BalancePanelState();
}

class _BalancePanelState extends State<BalancePanel> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return StreamBuilder(
      stream: null,
      builder: (context, snapshot) {
        return Container(
          color: Colors.white,
          padding: EdgeInsets.only(
            left: size.width*0.05,
            right: size.width*0.05,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ngày 3/32023",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  fontSize: size.height * 0.02,
                  color: Colors.black,
                ),
              ),
              Container(
                width: size.width,
                color: Colors.white,
                child: ListView.separated(
                  padding: EdgeInsets.only(
                    top: size.height*0.02,
                  ),
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: (){
                    },
                    child: balanceItem(context),
                  ),
                  separatorBuilder: (context, index) =>  SizedBox(height: size.height*0.02,),
                  itemCount: 5,
                ),
              ),
              SizedBox(height: size.height*0.1,),
            ],
          ),
        );
      },
    );
  }
}
