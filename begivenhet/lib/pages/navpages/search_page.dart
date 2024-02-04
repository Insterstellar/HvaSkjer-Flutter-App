import 'dart:async';

import 'package:begivenhet/listViewsreusable/event_views.dart';
import 'package:begivenhet/models/events.dart';
import 'package:begivenhet/pages/navpages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../controllers/events_controller.dart';
import '../../details/datails_page.dart';
import '../../misc/my_colors.dart';
import '../../misc/my_text.dart';
import '../../repository/services/events_service.dart';
import 'main_page.dart';



class SearchPage extends StatefulWidget {

  SearchPage();

  @override
  MotionSearchBarExpandRouteState createState() => MotionSearchBarExpandRouteState();
}

class MotionSearchBarExpandRouteState extends State<SearchPage> {


  late BuildContext _scaffoldCtx;

  void onItemClick() {
    Navigator.push(_scaffoldCtx, PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 1000),
        pageBuilder: (_, __, ___) => MotionSearchBarExpandDetails())
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(Duration(milliseconds: 500), (){
        onItemClick();
      });
    });
    super.initState();
  }
  var eventsController = EventsController(EventsRepository());
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark
        ),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(20),
            child: Hero(tag: "searchBar",
              child: Card(
                margin: EdgeInsets.all(10), elevation: 3,
                child: InkWell(
                  splashColor: Colors.grey[600], highlightColor: Colors.grey[600],
                  onTap: (){
                    onItemClick();
                  },
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        splashColor: Colors.grey[600], highlightColor: Colors.grey[600],
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MainPage()),
                          );
                        },
                        child: Padding(
                          padding: EdgeInsets.all(13),
                          child: Icon(Icons.arrow_back_outlined, size: 23.0, color: Colors.grey[500],),
                        ),
                      ),
                      Text("Search events", style: TextStyle(color: Colors.grey[500], fontSize: 16.0)),
                      Spacer(),
                      InkWell(
                        splashColor: Colors.grey[600], highlightColor: Colors.grey[600],
                        onTap: (){ },
                        child: Padding(
                          padding: EdgeInsets.all(13),
                          child: Icon(Icons.close, size: 23.0, color: Colors.grey[700],),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
        ),
        backgroundColor: Colors.grey[200],
        automaticallyImplyLeading: false,
      ),
      body: Builder(builder: (BuildContext context) {
        _scaffoldCtx = context;
        return Container(
          color: Colors.grey[200],
          alignment: Alignment.center,
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    "Search\n Events",
                    textAlign: TextAlign.center,
                    style: MyText.headline(context)!.copyWith(
                      color: MyColors.grey_40,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}


class MotionSearchBarExpandDetails extends StatefulWidget {

  @override
  State<MotionSearchBarExpandDetails> createState() => _MotionSearchBarExpandDetailsState();
}

class _MotionSearchBarExpandDetailsState extends State<MotionSearchBarExpandDetails> {
  final TextEditingController inputController = new TextEditingController();

  var eventsController = EventsController(EventsRepository());

  List<EventsModel> searchEvents(List<EventsModel> events, String searchTerm) {
    if (searchTerm.isEmpty) {
      return events; // Return all events if the search term is empty
    }
    final filteredEvents = events.where((event) {
      final eventName = event.eventName?.toLowerCase() ?? '';
      final eventDescription = event.eventDescription?.toLowerCase() ?? '';

      // Check if either the event name or event description contains the search term
      return eventName.contains(searchTerm.toLowerCase()) ||
          eventDescription.contains(searchTerm.toLowerCase());
    }).toList();

    return filteredEvents;
  }

  String searchQuery = ''; // Store the search term

// Function to handle changes in the search query
  void onSearchQueryChanged(String query) {
    setState(() {
      searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Hero(tag: "searchBar",
        child: Scaffold(
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarBrightness: Brightness.dark
            ), toolbarHeight: 0,
            elevation: 0, backgroundColor: Colors.white,
          ),
          body: Container(
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    InkWell(
                      splashColor: Colors.grey[600], highlightColor: Colors.grey[600],
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Icon(Icons.arrow_back, size: 23.0, color: Colors.grey[500],),
                      ),
                    ),
                    Expanded(
                      child: TextField(maxLines: 1, controller: inputController, onChanged: onSearchQueryChanged,
                        style: TextStyle(color: Colors.grey[600], fontSize: 18), keyboardType: TextInputType.text,
                        decoration: InputDecoration(border: InputBorder.none,
                          hintText: 'Search', hintStyle: TextStyle(fontSize: 16.0, color: Colors.grey[500]),
                        ),
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.grey[600], highlightColor: Colors.grey[600],
                      onTap: (){
                        inputController.text = "";
                      },
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Icon(Icons.close, size: 23.0, color: Colors.grey[700],),
                      ),
                    ),
                  ],
                ),
                Divider(height: 0, thickness: 1, color: MyColors.grey_10),
                Container(height: 8),
                Expanded(child: FutureBuilder(
                  future: eventsController.fetchEventsLists(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                          child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("Whoops something went wrong "),
                      );
                    }
                    final allEvents = snapshot.data ?? []; // Retrieve all events from the snapshot
                    final filteredEvents = searchEvents(allEvents, searchQuery);
                    return ListView.builder(
                        itemCount: filteredEvents.length,
                        itemBuilder: (context, index){
                          final allevents = filteredEvents[index];
                          return GestureDetector(
                            onTap: () {

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        DetailPage(
                                            eventItem:
                                            allevents)),
                              );
                            },

                            child: EventList(
                                eventName: allevents.eventName,
                                startTime:allevents.eventStartTime,
                                location: allevents.eventVenue,
                                groupName:allevents.eventDescription,
                                imagePath:allevents.eventImage
                            ),
                          );
                        }

                    );
                  }
                ))


              ],
            ),
          ),
        )
    );
  }
}

