import 'package:begivenhet/misc/colors.dart';
import 'package:begivenhet/misc/my_colors.dart';
import 'package:begivenhet/widgets/app_buttons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:begivenhet/misc/my_text.dart';

import '../widgets/app_text.dart';

class OrganiserList extends StatelessWidget {
  final String? eventName;
  //final String? groupName;
  final String? imagePath;

  const OrganiserList({
    Key? key,
    required this.eventName,
  //  required this.groupName,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 110,
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  Card(
                    margin: EdgeInsets.all(0),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Image.network(
                      imagePath??'',
                      height:80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 100,
                          child: Text(
                            eventName??'',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: MyText.subhead(context)!.copyWith(
                              color: MyColors.grey_80,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              padding: EdgeInsets.symmetric(horizontal: 30),
                              primary: MyColors.primary
                          ),
                          child: Text("FOLLOW", style: TextStyle(color: Colors.white)),
                          onPressed: (){

                          },
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(height: 10),
            Divider(height: 0),
          ],
        ),
      ),
    );
  }
}
