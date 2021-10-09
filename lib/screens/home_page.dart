import 'package:flutter/material.dart';
import '../utils/colors.dart';
import 'package:get/get.dart';
import 'details_page.dart';
import '../widgets/tile.dart';
import '../controller/details_controller.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DetailsController detailsController = Get.put(DetailsController());


  @override
  Widget build(BuildContext context) {
    // final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: red,
      body:  Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(deviceWidth* .05),
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children:  [
Text("The Sports DB",style: TextStyle(
  color: white,
  fontSize: 34,
  fontWeight: FontWeight.bold,
),),
              SizedBox(height: deviceWidth* .2,),
              // using tile widget from widget directory
              Tile(buttonName: "India",navigate: (){
                detailsController.countryNameController.text = "India";
                Get.to(()=> const DetailsPage());
              },),
              Tile(buttonName: "United States",navigate: (){
                detailsController.countryNameController.text = "United States";
                Get.to(()=> const DetailsPage());
              },),
              Tile(buttonName: "Australia",navigate: (){
                detailsController.countryNameController.text = "Australia";
                Get.to(()=> const DetailsPage());
              },),
              Tile(buttonName: "China",navigate: (){
                detailsController.countryNameController.text = "China";
                Get.to(()=> const DetailsPage());
              },),
              Tile(buttonName: "Argentina",navigate: (){
                detailsController.countryNameController.text = "Argentina";
                Get.to(()=> const DetailsPage());
              },),
              Tile(buttonName: "Canada",navigate: (){
                detailsController.countryNameController.text = "Canada";
                Get.to(()=> const DetailsPage());
              },),
            ],
          ),
        ),
      ),
    );
  }
}




