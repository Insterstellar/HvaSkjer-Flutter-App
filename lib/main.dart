import 'dart:convert';

import 'package:begivenhet/details/datails_page.dart';
import 'package:begivenhet/pages/navpages/main_page.dart';
import 'package:begivenhet/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'listViewsreusable/event_views.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   //


    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'HvaSkjer',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
        home: MainPage()

       // home: WelcomePage()
     // home: EventList(),

        //home: DetailPage(),
    );

  }

}

