import 'package:begivenhet/misc/my_colors.dart';
import 'package:begivenhet/widgets/app_large_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:begivenhet/misc/my_text.dart';

import '../widgets/app_text.dart';
//import 'my_strings.dart';

class EventList extends StatelessWidget {
  final String? eventName;
  final String? startTime;
  final String? location;
  final String? groupName;
  final String? imagePath;

  const EventList({
    Key? key,
    required this.eventName,
    required this.startTime,
    required this.location,
    required this.groupName,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget widget;
    List<Widget> items = [];
    Widget w = Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                margin: EdgeInsets.all(0),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child:
                Column(
                  children: [
                    if (imagePath == null)
                      Image.asset(
                        'images/noimage.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                    else
                      Image.network(
                        imagePath??'',
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'images/noimage.png',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                  ],
                )
                ,
              ),
              Container(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment : CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(eventName??'', style: MyText.medium(context).copyWith(
                        color: Colors.grey[800], fontWeight: FontWeight.w500
                    )),
                    Container(height: 5),
                    Text(startTime??'', style: MyText.body1(context)!.copyWith(
                        color: Colors.grey[500]
                    )),
                    Container(height: 5),
                    Text(groupName??'', maxLines : 2, style: MyText.subhead(context)!.copyWith(
                        color: Colors.grey[700]
                    )),
                    Container(height: 5),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          size: 12,
                        ),
                        Container(width: 5),
                        Text(location??'', style: MyText.body1(context)!.copyWith(
                            color: Colors.grey[500]
                        )),
                        const Spacer(),
                        const Icon(
                          Icons.favorite_border,
                          size: 13,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        Divider(height: 0, color: Colors.grey[300], thickness: 0.5)
      ],
    );
    items.add(w);


    widget = SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: items,
      ),
    );
    return widget;
  }
}

