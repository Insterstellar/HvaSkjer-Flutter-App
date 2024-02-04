import 'package:begivenhet/misc/colors.dart';
import 'package:begivenhet/widgets/app_buttons.dart';
import 'package:begivenhet/widgets/app_large_text.dart';
import 'package:begivenhet/widgets/app_text.dart';
import 'package:begivenhet/widgets/responsive_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List images =[
    "concert.png",
    "teacherr.png",
    "workut.png"
  ];

  List eventsList=[
    "Discover events from our app and enjoy a pleasant time. Our app offers a wide range of events that cater to different interests and preferences. ",
    "Whether you are looking for music concerts, art exhibitions, or food festivals, our app has got you covered.",
    "Simply browse through the app, select the event that appeals to you, and select and enjoy it. With our app, you can be sure to have a memorable experience."

  ];
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount:  images.length,
          itemBuilder: (_,index){
       return Container(
         width: double.maxFinite,
         height: double.maxFinite,
         decoration: BoxDecoration(
           image: DecorationImage(
             image: AssetImage(
               "images/"+images[index]
             ),
             fit: BoxFit.cover
           )
         ),
         child: Container(
           margin: const EdgeInsets.only(top:150,left:20,right:20),
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   AppLargeText(text: "Events"),
                  AppText(text: "Hva Sjer", size: 30,),
                   SizedBox(height:20),
                  Container(
                    width: 250,
                    child: AppText(text: eventsList[index]
                      , color: AppColors.textColor2, size: 14,),
                  ),
                   SizedBox(height:20),
                  //ResponsiveButton(width: 120,isResponsive: false,)

                 AppButtons(text:"Discover",size: 50, color: AppColors.buttonBackground, backGroundColor: Colors.blueAccent, borderColor: Colors.white),

                  // AppLargeText(text: "Hva Skjer", color: Colors.red,)

                 ],
               ),
               Column(
                 children: List.generate(3, (indexDots) {
                   return Container(
                     margin: const EdgeInsets.only(bottom: 2),
                     width: 8,
                     height: index==indexDots?25:8,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(8),
                       color: index==indexDots?AppColors.mainColor:AppColors.mainColor.withOpacity(0.3)
                     ),
                   );
                 } )


               )
             ],
           ),
         ),
       );

      }),
    );
  }
}
