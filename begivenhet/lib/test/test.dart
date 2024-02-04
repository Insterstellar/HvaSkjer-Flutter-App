import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

import '../misc/my_colors.dart';
import '../misc/my_text.dart';

class NoitemInternetImageRoute extends StatefulWidget {
  NoitemInternetImageRoute();

  @override
  NoitemInternetImageRouteState createState() =>
      NoitemInternetImageRouteState();
}

class NoitemInternetImageRouteState extends State<NoitemInternetImageRoute> {
  bool finishLoading = true;

  Future<bool> _checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkInternetConnectivity(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final isConnected = snapshot.data!;
          if (isConnected) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(0),
                  child: Container(color: Colors.white)),
              body: Align(
                alignment: Alignment.center,
                child: Container(
                  alignment: Alignment.center,
                  width: 280,
                  child: Stack(
                    children: <Widget>[
                      finishLoading
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Image.asset('img_no_internet_satellite.png',
                                    width: 250, height: 250),
                                Text("Whoops!",
                                    style: MyText.display1(context)!.copyWith(
                                        color: MyColors.primary,
                                        fontWeight: FontWeight.bold)),
                                Container(height: 10),
                                Text(
                                    "No internet connections found. Check your connection or try again",
                                    textAlign: TextAlign.center,
                                    style: MyText.medium(context)
                                        .copyWith(color: MyColors.primary)),
                                Container(height: 25),
                                Container(
                                  width: 180,
                                  height: 40,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: MyColors.primary,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                    child: Text("RETRY",
                                        style: TextStyle(color: Colors.white)),
                                    onPressed: () {
                                      setState(() {
                                        finishLoading = false;
                                      });
                                      delayShowingContent();
                                    },
                                  ),
                                )
                              ],
                            )
                          : CircularProgressIndicator(),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: Text(
                  "No internet connection",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            );
          }
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text(
                "Error checking internet connectivity",
                style: TextStyle(fontSize: 20),
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  void delayShowingContent() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        finishLoading = true;
      });
    });
  }
}
