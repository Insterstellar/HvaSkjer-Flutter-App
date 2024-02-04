import 'package:begivenhet/models/events.dart';
import 'package:begivenhet/models/group_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../listViewsreusable/event_views.dart';
import '../misc/my_colors.dart';
import '../misc/my_text.dart';
import '../test/my_strings.dart';
import 'datails_page.dart';

class GroupDetails extends StatefulWidget {
  final GroupModel? groupItem;

  GroupDetails({Key? key, required this.groupItem}) : super(key: key);

  @override
  GroupDetailsState createState() => GroupDetailsState();
}

class GroupDetailsState extends State<GroupDetails> {
  @override
  Widget build(BuildContext context) {
    GroupModel? groupItem = widget.groupItem;

    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.dark,
              ),
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  groupItem?.picture??'',
                  fit: BoxFit.cover,
                ),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_outlined),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
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
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(50),
                child: Container(
                  transform: Matrix4.translationValues(0, 50, 0),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[200],
                    child: CircleAvatar(
                      radius: 48,
                      backgroundImage: NetworkImage(groupItem?.picture??''),
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                Container(height: 70),
                Text(
                  groupItem?.name ?? '',
                  style: MyText.headline(context)!.copyWith(
                    color: Colors.grey[900],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Container(height: 15),
                Text(
                  groupItem?.description ?? '',
                  textAlign: TextAlign.center,
                  style: MyText.subhead(context)!.copyWith(
                    color: Colors.grey[900],
                  ),
                ),
                Container(height: 25),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    primary: MyColors.primary,
                  ),
                  child: Text("FOLLOW", style: TextStyle(color: Colors.white)),
                  onPressed: () {},
                ),
                Container(height: 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(Icons.person, color: Colors.grey[900]),
                          Container(width: 5),
                          Text(
                            "1766",
                            style: MyText.title(context)!.copyWith(
                              color: Colors.grey[900],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(width: 5),
                          Text(
                            "Followers",
                            style: MyText.subhead(context)!
                                .copyWith(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(height: 20),
                Divider(height: 50),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: groupItem?.events?.length ?? 0,
                itemBuilder: (context, index) {
                  if (groupItem?.events != null && groupItem!.events!.isNotEmpty) {
                    EventsModel? groupEventItem = groupItem!.events![index];
                    return GestureDetector(
                      onTap: () {

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(eventItem: groupEventItem),
                          ),
                        );
                      },
                      child: EventList(
                        eventName: groupEventItem?.eventName ?? '',
                        startTime: groupEventItem?.eventStartTime ?? '',
                        location: groupEventItem?.eventVenue ?? '',
                        groupName: groupEventItem?.eventDescription ?? '',
                        imagePath: groupEventItem?.eventImage ?? '',
                      ),
                    );
                  } else {
                    return Container(); // Or any other fallback UI
                  }
                },
              ),

                Container(height: 35),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
