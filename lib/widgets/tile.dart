import 'package:flutter/material.dart';
import '../utils/const.dart';
import '../utils/colors.dart';


class Tile extends StatelessWidget {

final String buttonName;
final VoidCallback navigate;
const Tile({Key? key, required this.buttonName, required this.navigate}) : super(key: key);

@override
Widget build(BuildContext context) {
  final deviceWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        ListTile(
          onTap: navigate,
          shape: kTileShape,
          tileColor: white.withOpacity(.8),
          leading: Text(buttonName,style: kButtonTextStyle,),
          trailing: kArrowRight,
        ),
        SizedBox(height: deviceWidth* .075,),
      ],
    );
  }
}