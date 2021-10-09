import 'package:flutter/material.dart';
import '../utils/colors.dart';
import '../controller/details_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  final DetailsController myController = Get.put(DetailsController());
  final TextEditingController _searchController = TextEditingController();

  final _searchFocusNode = FocusNode();

  dynamic newData;

  dynamic jsonData;
  // To collect all the data coming from Sports List Api.
  Future getSportsList() async {
    final response = await http.get(Uri.parse(
        "https://www.thesportsdb.com/api/v1/json/1/search_all_leagues.php?c=${myController.countryNameController.text}"));
    if (response.statusCode == 200) {
      jsonData = jsonDecode(response.body);
      print('Data from Sports DB: ' + jsonData.toString());
      print(jsonData["countrys"].length);
      newData = jsonData;
      return jsonData;
    } else {
      throw Exception("Unable to load data");
    }
  }

  Future? sportsList;

  dynamic data;
  //To collect all data coming after using Search API.
  Future getSearchData() async {
    final response = await http.get(Uri.parse(
        "https://www.thesportsdb.com/api/v1/json/1/search_all_leagues.php?s=${_searchController.text}&c=${myController.countryNameController.text}"));
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      print('Data from Search Data: ' + data.toString());
      print(data["countrys"].length);
      newData = data;
      return data;
    } else {
      throw Exception("Unable to load data");
    }
  }


  int? length;
  // for storing the different length coming from Sports List API and Search API.

  @override
  void initState() {
    sportsList = getSportsList().then((value) => length = jsonData["countrys"].length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: red,
        title: Text(myController.countryNameController.text),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(deviceWidth * .035),
            child: TextFormField(
              controller: _searchController,
              focusNode: _searchFocusNode,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              cursorColor: black,
              onChanged: (_) {
                setState(() {

                  _searchController.text.isNotEmpty
                      ? sportsList = getSearchData()
                          .then((value) => length = data["countrys"].length)
                      : sportsList = getSportsList().then(
                          (value) => length = jsonData["countrys"].length);
                //  We are calling search API here to get the updated screen on changing of textfield data.
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: grey.withOpacity(.25),
                hintText: "Search leagues...",
                hintStyle:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w300
                        // color: lightBlue
                        ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: deviceWidth * .05),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.transparent)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.transparent)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.transparent)),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(color: Colors.transparent)),
              ),
            ),
          ),
          Flexible(
            child: FutureBuilder(
              future: sportsList,
              builder: (ctx, snapshot) => snapshot.connectionState ==
                      ConnectionState.waiting
                  ? const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        valueColor: AlwaysStoppedAnimation<Color>(black),
                      ),
                    )
                  : length == null
                      ? const Center(
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 15),
                              child: Text(
                                'No Items Available!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 15, color: Colors.black),
                              ),
                            ),
                          ),
                        )
                      : ListView.builder(
                          padding: EdgeInsets.all(deviceWidth * .035),
                          itemCount: length,
                          // shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Container(
                              margin:
                                  EdgeInsets.only(bottom: deviceWidth * .035),
                              padding: EdgeInsets.all(deviceWidth * .025),
                              width: deviceWidth,
                              height: deviceWidth * .35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: NetworkImage(newData["countrys"]
                                                [index]["strBanner"] ==
                                            null
                                        // using static data if the strBanner is null.
                                        ? "https://www.thesportsdb.com/images/media/league/banner/tvuyrw1472151298.jpg"
                                        : newData["countrys"][index]
                                                ["strBanner"]
                                            .toString()),
                                    fit: BoxFit.fill,
                                    colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(.25),
                                        BlendMode.darken)),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    newData["countrys"][index]["strLeague"] ==
                                            null
                                    // using static data if the strLeague is null.
                                        ? "Soccer"
                                        : newData["countrys"][index]
                                                ["strLeague"]
                                            .toString(),
                                    style: TextStyle(
                                        color: white,
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: deviceWidth * .3,
                                        height: deviceWidth * .1,
                                        child: Image.network(
                                          newData["countrys"][index]
                                                      ["strLogo"] ==
                                                  null
                                          // using static data if the strLogo is null.
                                              ? "https://www.thesportsdb.com/images/media/league/logo/wtrpqs1472152759.png"
                                              : newData["countrys"][index]
                                                      ["strLogo"]
                                                  .toString(),
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [newData["countrys"][index]
                                                  ["strFacebook"] ==
                                              null
                                          ? Container()
                                          : SvgPicture.asset(
                                              "assets/images/twitter.svg",
                                              width: 30,
                                              height: 30,
                                              color: white,
                                            ),
                                      SizedBox(
                                        width: deviceWidth * .025,
                                      ),
                                      newData["countrys"][index]
                                                  ["strTwitter"] ==
                                              null
                                          ? Container()
                                          : SvgPicture.asset(
                                              "assets/images/facebook.svg",
                                              width: 30,
                                              height: 30,
                                              color: white,
                                            ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
            ),
          ),
        ],
      ),
    );
  }
}
