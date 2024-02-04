import 'package:flutter/material.dart';

import '../misc/my_text.dart';

class NoitemEvent extends StatefulWidget {

  NoitemEvent();

  @override
  NoitemEventState createState() => new NoitemEventState();
}


class NoitemEventState extends State<NoitemEvent> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.center,
        child: Container(
          alignment: Alignment.center,
          width: 220,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey[300],
                  ),
                  Container(width: 20),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(height: 10, width : 80, color: Colors.grey[300]),
                      Container(height: 10),
                      Container(height: 10, width : 145, color: Colors.grey[300]),
                      Container(height: 10),
                      Container(height: 10, width : 40, color: Colors.grey[300])
                    ],
                  )
                ],
              ),
              Container(height: 20),
              Row(
                children: <Widget>[
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey[200],
                  ),
                  Container(width: 20),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(height: 10, width : 100, color: Colors.grey[200]),
                      Container(height: 10),
                      Container(height: 10, width : 145, color: Colors.grey[200]),
                      Container(height: 10),
                      Container(height: 10, width : 40, color: Colors.grey[200])
                    ],
                  )
                ],
              ),
              Container(height: 25),
              Text("opps no event here", style: MyText.subhead(context)!.copyWith(
                  color: Colors.grey[700]
              )),
            ],
          ),
        ),
      ),
    );
  }
}

