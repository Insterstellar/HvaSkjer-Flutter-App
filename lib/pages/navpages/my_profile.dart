import 'package:begivenhet/pages/about_page.dart';
import 'package:begivenhet/widgets/re_usable_select_no_photo_button.dart';
import 'package:flutter/material.dart';
import '../../login/login_user.dart';
import '../../login/sign_up_form.dart';
import '../../misc/my_colors.dart';
import '../../misc/my_text.dart';
import '../../upload/upload_events.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen();

  @override
  ProfileScreenState createState() => new ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.grey_5,
      appBar:
          PreferredSize(child: Container(), preferredSize: Size.fromHeight(0)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            ),

            Divider(height: 0),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UploadEvents()),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                child: Row(
                  children: <Widget>[
                    Text("Manage Events",
                        style: MyText.medium(context).copyWith(
                            color: MyColors.grey_80,
                            fontWeight: FontWeight.w300)),
                    Spacer(),
                    Icon(Icons.event_rounded, color: MyColors.grey_60),
                    Container(width: 10)
                  ],
                ),
              ),
            ),

            Divider(height: 0),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                child: Row(
                  children: <Widget>[
                    Text("Rate Us",
                        style: MyText.medium(context).copyWith(
                            color: MyColors.grey_80,
                            fontWeight: FontWeight.w300)),
                    Spacer(),
                    Icon(Icons.rate_review_outlined, color: MyColors.grey_60),
                    Container(width: 10)
                  ],
                ),
              ),
            ),
            Divider(height: 0),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => About()),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                child: Row(
                  children: <Widget>[
                    Text("About",
                        style: MyText.medium(context).copyWith(
                            color: MyColors.grey_80,
                            fontWeight: FontWeight.w300)),
                    Spacer(),
                    Icon(Icons.info_outline, color: MyColors.grey_60),
                    Container(width: 10)
                  ],
                ),
              ),
            ),
            Divider(height: 0),
            //Container(height: 25),
            Container(
              margin: EdgeInsets.all(20),
              width: double.infinity,
              height: 55,
              child: SelectButton(
                textLabel: "Login",
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                ),
              ),
            ),
            Divider(height: 0),
          ],
        ),
      ),
    );
  }
}
