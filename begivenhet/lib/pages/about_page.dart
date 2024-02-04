import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../misc/my_colors.dart';
import '../misc/my_text.dart';
import '../test/my_strings.dart';

class About extends StatefulWidget {

  About();

  @override
  AboutState createState() => new AboutState();
}


class AboutState extends State<About> {

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
          ),
          title: Text("About", style: TextStyle(color: MyColors.grey_80)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: MyColors.grey_80),
            onPressed: () {Navigator.pop(context);},
          ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("Hva Skjer", style: MyText.display1(context)!.copyWith(color: MyColors.grey_60, fontWeight: FontWeight.w300)),
            Container(height: 5),
            Container(width: 120, height: 3, color: MyColors.primary),
            Container(height: 15),
            Text("Version", style: MyText.body1(context)!.copyWith(color: MyColors.grey_40)),
            Text("1.0", style: MyText.medium(context).copyWith(color: MyColors.grey_90)),
            Container(height: 15),
            Text("Last Update", style: MyText.body1(context)!.copyWith(color: MyColors.grey_40)),
            Text(MyStrings.about_the_app, style: MyText.medium(context).copyWith(color: MyColors.grey_90)),
            Container(height: 25),
            Text("Term of services", style: MyText.medium(context).copyWith(color: MyColors.grey_90)),

          ],
        ),
      ),
    );
  }
}

