import 'dart:convert';
import 'dart:io';

import 'package:begivenhet/models/events.dart';
import 'package:begivenhet/models/category_model.dart';
import 'package:begivenhet/repository/services/events_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../controllers/events_controller.dart';
import '../../listViewsreusable/event_views.dart';
import '../../misc/my_text.dart';
import '../../noitem/no_items_found.dart';
import '../../repository/interfaces/events_interface.dart';
import '../../details/datails_page.dart';
import 'package:http/http.dart' as http;

class CategoryEvents extends StatefulWidget {
  final CategoryModel? categoryItems;
  const CategoryEvents({Key? key, required this.categoryItems})
      : super(key: key);

  @override
  State<CategoryEvents> createState() => _CategoryEventsState();
}

class _CategoryEventsState extends State<CategoryEvents> {
  @override
  Widget build(BuildContext context) {
    // var eventsController= EventsController(EventsRepository());
    CategoryModel? categoryItems = widget.categoryItems;

    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 100.0,
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarBrightness: Brightness.dark,
              ),
              floating: false,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Stack(
                  children: <Widget>[
                    Image.network(
                      categoryItems?.picture ?? '',
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                    ),
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ],
                ),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(200),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        categoryItems?.name ?? ''.toUpperCase(),
                        style: MyText.display1(context)!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(height: 15),
                    ],
                  ),
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
                // overflow menu
                PopupMenuButton<String>(
                  onSelected: (String value) {},
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: "Settings",
                      child: Text("Settings"),
                    ),
                  ],
                ),
              ],
            ),
          ];
        },
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: categoryItems?.eventsList?.isEmpty == true
                    ? NoitemEvent() // Replace with your desired text widget
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: categoryItems?.eventsList?.length ?? 0,
                        itemBuilder: (context, index) {
                          EventsModel? categoryEventItem =
                              categoryItems?.eventsList?[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailPage(eventItem: categoryEventItem),
                                ),
                              );
                            },
                            child: EventList(
                              eventName: categoryEventItem?.eventName ?? '',
                              startTime:
                                  categoryEventItem?.eventStartTime ?? '',
                              location: categoryEventItem?.eventVenue ?? '',
                              groupName:
                                  categoryEventItem?.eventDescription ?? '',
                              imagePath: categoryEventItem?.eventImage ?? '',
                            ),
                          );
                        },
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
