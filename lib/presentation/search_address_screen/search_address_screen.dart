import 'dart:convert';

import 'package:elssit/core/models/searchModel/data_search_model.dart';
import 'package:elssit/core/utils/color_constant.dart';
import 'package:elssit/presentation/widget/dialog/fail_dialog.dart';
import 'package:elssit/process/bloc/sitter_bloc.dart';
import 'package:elssit/process/event/sitter_event.dart';
import 'package:elssit/process/state/sitter_state.dart';
import 'package:flutter/Material.dart';
import 'package:http/http.dart' as http;

class SearchAddressPage extends StatefulWidget {
  SearchAddressPage({super.key, required this.sitBloc});
  final SitBloc sitBloc;
  @override
  State<SearchAddressPage> createState() =>
      _SearchAddressPageState(sitBloc: sitBloc);
}

class _SearchAddressPageState extends State<SearchAddressPage> {
  _SearchAddressPageState({required this.sitBloc});
  final SitBloc sitBloc;
  bool isWaitting = false;
  List<DataSearchModel> listLocation = [];
  String apiKey = "38M4gcZIYn33Tlimrf9igTQbTUAor9vq6rEvbpOI";
  String input = "";
  TextEditingController controller = TextEditingController();
  double lat = 0;
  double lng = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (sitBloc.modelSearch != null) {
      controller.text = sitBloc.modelSearch!.description;
    }
  }

//https://rsapi.goong.io/Place/Detail?place_id=ypOM9hu-8iJaa1pJsn6-_rxrVQq5famNW8orA6YYh8dts0FUOp3z2jFyghD6nfpA1Wq_lRadthINdv0EzvkcSjGigeEqMRYzJaKxaTox8jEFpbeUaurqcSWsaQTGWjPfM&api_key=38M4gcZIYn33Tlimrf9igTQbTUAor9vq6rEvbpOI
  Future<void> fetchData() async {
    //38M4gcZIYn33Tlimrf9igTQbTUAor9vq6rEvbpOI

    isWaitting = true;
    try {
      var url = Uri.parse(
          "https://rsapi.goong.io/Place/AutoComplete?api_key=${apiKey}&input=${input}");
      final response = await http.get(
        url,
      );
      print("ahaa ${response.statusCode}");
      if (response.statusCode.toString() == '200') {
        var dataRespone = jsonDecode(response.body);
        Iterable listData = dataRespone["predictions"];

        final mapData = listData.cast<Map<String, dynamic>>();
        listLocation = mapData.map<DataSearchModel>((json) {
          return DataSearchModel.fromJson(json);
        }).toList();
      } else {
        listLocation = [];
        print("haha");
      }
    } catch (e) {
      print(e);
      listLocation = [];
    } finally {
      setState(() {
        isWaitting = false;
      });
    }
  }

  Future<void> getLatLong(String id) async {
    //38M4gcZIYn33Tlimrf9igTQbTUAor9vq6rEvbpOI
//
    try {
      var url = Uri.parse(
          "https://rsapi.goong.io/Place/Detail?place_id=${id}&api_key=${apiKey}");
      final response = await http.get(
        url,
      );
      print(response.body);
      if (response.statusCode.toString() == '200') {
        var dataRespone = jsonDecode(response.body);
        lat = dataRespone["result"]["geometry"]["location"]["lat"].toDouble();
        sitBloc.lat = lat;
        lng = dataRespone["result"]["geometry"]["location"]["lng"].toDouble();
        sitBloc.lng = lng;
      } else {}
    } catch (e) {
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          width: double.infinity,
          child: TextFormField(
            autofocus: true,
            controller: controller,
            style: TextStyle(
                fontSize: 16,
                color: Colors.grey[800],
                fontWeight: FontWeight.w500),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Nhập vị trí",
              hintStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800]),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.grey[800],
                  size: 25,
                ),
                onPressed: () {
                  setState(() {
                    input = "";
                    controller.text = "";
                  });
                },
              ),
            ),
            textInputAction: TextInputAction.search,
            onChanged: (value) async {
              setState(() {
                isWaitting = true;
                input = value;
                print(input);
              });
              await fetchData();
            },
            onFieldSubmitted: (value) async {
              setState(() {
                isWaitting = true;
                input = value;
                print(input);
              });
              await fetchData();
            },
          ),
        ),
        backgroundColor: ColorConstant.primaryColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // suggestion text
          isWaitting
              ? Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: CircularProgressIndicator(
                          color: ColorConstant.primaryColor,
                        ),
                      ),
                    ],
                  ),
                )
              : Expanded(
                  child: listLocation.isEmpty
                      ? SizedBox.shrink()
                      : ListView.separated(
                          padding: EdgeInsets.all(10),
                          itemCount: listLocation.length,
                          separatorBuilder: (context, index) => SizedBox(
                            height: 5,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              onTap: () async {
                                print("ủa");
                                if (listLocation[index].compound.province !=
                                    "Hồ Chí Minh") {
                                  showFailDialog(context,
                                      "Dịch vụ hiện tại chỉ hỗ trợ ở thành phố Hồ Chí Minh");
                                } else {
                                  await getLatLong(listLocation[index].placeId);
                                  sitBloc.modelSearch = listLocation[index];
                                  sitBloc.district = listLocation[index].compound.district;
                                  sitBloc.modelSearch?.lat = lat;
                                  sitBloc.modelSearch?.lng = lng;
                                  sitBloc.eventController.sink.add(
                                      FillAddressSitEvent(
                                          address: listLocation[index]
                                              .description
                                              .toString()));
                                  print(sitBloc.modelSearch?.lat);
                                  Navigator.pop(context);
                                }
                              },
                              leading: Icon(
                                Icons.location_on_outlined,
                                color: ColorConstant.primaryColor,
                              ),
                              title: Text(listLocation[index]
                                  .structuredFormatting
                                  .mainText),
                              subtitle: Text(listLocation[index]
                                  .structuredFormatting
                                  .secondaryText),
                            );
                          },
                        ))
        ],
      ),
    );
  }
}
