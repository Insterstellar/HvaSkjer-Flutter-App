import 'dart:collection';

import 'package:begivenhet/controllers/group_controller.dart';
import 'package:begivenhet/listViewsreusable/organisers_list.dart';
import 'package:begivenhet/misc/colors.dart';
import 'package:begivenhet/details/datails_page.dart';
import 'package:begivenhet/models/events.dart';
import 'package:begivenhet/pages/navpages/all_events_page.dart';
import 'package:begivenhet/repository/services/category_service.dart';
import 'package:begivenhet/repository/services/group_service.dart';
import 'package:begivenhet/widgets/app_large_text.dart';
import 'package:begivenhet/widgets/app_text.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../connections/no_internet.dart';
import '../../controllers/category_controller.dart';
import '../../controllers/events_controller.dart';
import '../../details/categorydetails/category_events.dart';
import '../../details/groups_details.dart';
import '../../details/see_all_categories.dart';
import '../../listViewsreusable/event_views.dart';
import '../../repository/services/events_service.dart';
import '../../shimmer_event_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  var eventsController = EventsController(EventsRepository());
  var categoryController = CategoryController(CategoryRepository());
  var groupsController = GroupController(GroupsRepository());
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    checkInternetConnectivity();
  }

  Future<void> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    setState(() {
      isConnected = connectivityResult != ConnectivityResult.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    AssetImage assetImage = const AssetImage('images/forward.png');
    Image imageForward = Image(image: assetImage);
    TabController _tabController = TabController(length: 3, vsync: this);
    return isConnected
        ? Scaffold(
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //menu texts
                Container(
                  padding: const EdgeInsets.only(top: 70, left: 20),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.menu,
                        size: 30,
                        color: Colors.black54,
                      ),
                      Expanded(child: Container()),
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.withOpacity(0.5)),
                      )
                    ],
                  ),
                ),
                //Events texts
                SizedBox(
                  height: 30,
                ),
                Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: AppLargeText(text: "Hva Skjer")),
                SizedBox(
                  height: 20,
                ),
                //tab bar

                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      labelPadding: EdgeInsets.only(left: 20, right: 20),
                      controller: _tabController,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      isScrollable: true,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicator: CirclTabIndicator(
                          color: AppColors.mainColor, radius: 4),
                      tabs: const [
                        Tab(text: "🔥 Hot"),
                        Tab(
                          text: "Upcoming",
                        ),
                        Tab(
                          text: "Organisers",
                        )
                      ],
                    ),
                  ),
                ),
                FutureBuilder(
                    future: eventsController.fetchEventsLists(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }

                      return Container(
                        padding: EdgeInsets.only(left: 20),
                        height: 300,
                        width: double.maxFinite,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            ListView.builder(
                              itemCount: 3,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                var hotevents = snapshot.data?[index];
                                return GestureDetector(
                                  onTap: () {
                                    print(
                                        'my Clicked item:${hotevents?.eventName}');

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailPage(eventItem: hotevents)),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        right: 15, top: 10),
                                    width: 200,
                                    height: 300,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              hotevents?.eventImage ?? ''),
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                );
                              },
                            ),
                            //upcoming events
                            FutureBuilder<List<EventsModel>>(
                              future: eventsController.fetchEventsLists(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return ListView.builder(
                                    itemCount: 10, // Adjust the itemCount as per your shimmer requirements
                                    itemBuilder: (context, index) {
                                      return EventListShimmer();
                                    },
                                  );
                                }
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text("Something went wrong"),
                                  );
                                }
                                if (snapshot.connectionState == ConnectionState.done) {
                                  return ListView.builder(
                                    itemCount: 6,
                                    itemBuilder: (context, index) {
                                      var dataLists = snapshot.data?[index];
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => DetailPage(eventItem: dataLists),
                                            ),
                                          );
                                        },
                                        child: EventList(
                                          eventName: dataLists?.eventName,
                                          startTime: dataLists?.eventStartTime,
                                          location: dataLists?.eventVenue,
                                          groupName: dataLists?.eventDescription,
                                          imagePath: dataLists?.eventImage,
                                        ),
                                      );
                                    },
                                  );
                                }
                                return Container();
                              },
                            )
                            ,
                            FutureBuilder(
                                future: groupsController.fetchGroupLists(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  }
                                  if (snapshot.hasError) {
                                    return Center(
                                      child: Text(snapshot.error.toString()),
                                    );
                                  }
                                  return ListView.builder(
                                      itemCount: snapshot.data?.length,
                                      itemBuilder: (context, index) {
                                        var groupList = snapshot.data?[index];
                                        return GestureDetector(
                                            onTap: () {
                                              print(
                                                  'return group: ${groupList?.name}');

                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        GroupDetails(
                                                            groupItem:
                                                                groupList)),
                                              );
                                            },
                                            child: OrganiserList(
                                                eventName: groupList?.name,
                                                imagePath: groupList?.picture));
                                      });
                                })
                          ],
                        ),
                      );
                    }),
                SizedBox(
                  height: 30,
                ),
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AppLargeText(
                        text: "Categories..",
                        size: 22,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                CategoryImageRoute()),
                          );
                        },
                        child: AppText(
                          text: "See all ",
                          color: AppColors.textColor1,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FutureBuilder(
                    future: categoryController.fetchCategorysLists(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }
                      return Container(
                        width: double.maxFinite,
                        height: 120,
                        margin: EdgeInsets.only(left: 20),
                        child: ListView.builder(
                            itemCount: 4,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (_, index) {
                              var categorySnap = snapshot.data?[index];
                              //return exmplore view
                              return GestureDetector(
                                onTap: () {

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CategoryEvents (categoryItems: categorySnap),
                                    ),
                                  );
                                 // print('event id == ${categorySnap?.id}');
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(right: 30),
                                  child: Column(
                                    children: [
                                      Container(
                                        // margin: const EdgeInsets.only(right: 50),
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Colors.white,
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  categorySnap?.picture ?? ''),
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        //width: double,
                                        child: AppText(
                                          text: categorySnap?.name ?? '',
                                          color: AppColors.textColor2,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      );
                    })
              ],
            ),
          )
        : NoitemInternetImageRoute(
            onCheckConnection: checkInternetConnectivity,
          );
  }
}

class CirclTabIndicator extends Decoration {
  final Color color;
  final double radius;

  const CirclTabIndicator({
    required this.color,
    required this.radius,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return CirclePainter(color: color, radius: radius);
  }
}

class CirclePainter extends BoxPainter {
  final Color color;
  final double radius;

  const CirclePainter({
    required this.color,
    required this.radius,
  });

  @override
  void paint(
    Canvas canvas,
    Offset offset,
    ImageConfiguration configuration,
  ) {
    Paint _paint = Paint();
    _paint.color = color;
    _paint.isAntiAlias = true;
    final Offset circleOffset = Offset(
        configuration.size!.width / 2 - radius / 2,
        configuration.size!.height - radius - radius - radius * radius);
    canvas.drawCircle(
        circleOffset + offset.translate(0, configuration.size!.height / 2),
        radius,
        _paint);
  }
}
