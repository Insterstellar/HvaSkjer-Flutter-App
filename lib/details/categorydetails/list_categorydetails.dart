import 'package:flutter/material.dart';
import '../../misc/my_text.dart';
import 'category_events.dart';


// ignore: must_be_immutable
class ListCategory extends StatelessWidget {
  final int index;
  final String? categoryName;
  final String? imagePath;
  final VoidCallback onPressed;


  const ListCategory({
    Key? key,
    required this.index,
    required this.categoryName,
    required this.imagePath,
    required this.onPressed,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 180,
        child: Stack(
          children: <Widget>[
            Image.network(
              imagePath??'',
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withOpacity(0.3),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    categoryName??'',
                    style: MyText.title(context)!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 30,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black.withOpacity(0.1),
                        padding: EdgeInsets.symmetric(horizontal: 35),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(color: Colors.white, width: 2),
                        ),
                      ),
                      child: Text(
                        "${index} Events",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: onPressed,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
