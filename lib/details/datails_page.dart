import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:begivenhet/models/events.dart';
import '../misc/my_colors.dart';
import '../misc/my_text.dart';
import '../test/my_strings.dart';

class DetailPage extends StatelessWidget {
 final EventsModel? eventItem;

  DetailPage({Key? key, required this.eventItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 250.0,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.dark,
              ),
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                background: Image.network((eventItem?.eventImage??''), fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace){
                  return Image.asset(
                    'images/noimage.png',
                    fit: BoxFit.cover,
                  );
                },
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
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {
                    icon: const Icon(Icons.favorite_border);
                  },
                ), // overflow menu
                PopupMenuButton<String>(
                  onSelected: (String value) {},
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: "Settings",
                      child: Text("Settings"),
                    ),
                  ],
                )
              ],
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  color: MyColors.primary,
                  child: Text(
                    eventItem?.id.toString()??'',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Container(height: 15),
                Text(
                  eventItem?.eventName ?? '',
                  style: MyText.headline(context)!.copyWith(
                    color: Colors.grey[900],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(height: 15),

                Row(
                  children: <Widget>[
                    Icon(Icons.event, size: 20.0, color: Colors.grey),
                    Container(width: 5),
                    Text(
                      eventItem?.eventStartTime ?? '',
                      style: MyText.body1(context)!.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
                Container(height: 5),
                Row(
                  children: <Widget>[
                    Icon(Icons.location_on, size: 20.0, color: Colors.grey),
                    Container(width: 5),
                    Text(
                      eventItem?.eventVenue?? '',
                      style: MyText.body1(context)!.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
                Container(height: 20),
                Text(MyStrings.very_long_lorem_ipsum, textAlign: TextAlign.justify),
                Container(height: 20),
                // Non-scrollable button at the bottom

              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 75,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
       color: Colors.transparent,
        child: ElevatedButton(
          onPressed: () {  },
          child: Text('Attend'),

        )
      ),
    );
  }




}
