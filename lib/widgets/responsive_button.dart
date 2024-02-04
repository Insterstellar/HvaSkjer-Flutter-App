import 'package:begivenhet/misc/colors.dart';
import 'package:begivenhet/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResponsiveButton extends StatelessWidget {
  bool? isResponsive;
  double? width;
  //double hieght;

  ResponsiveButton({Key? key,this.width = 120, this.isResponsive = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const AssetImage assetImage = AssetImage('images/forward.png');

    return Expanded(
      child: Container(
        width: isResponsive == true ? double.maxFinite : width,
        height: 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.mainColor,
        ),
        child: Row(
          mainAxisAlignment: isResponsive == true ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
          children: [
            if (isResponsive == true)
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: AppText(text: "Attend", color: Colors.white),
              )
            else
              Container(),
            Image(image: assetImage),
          ],
        ),
      ),
    );
  }
}
