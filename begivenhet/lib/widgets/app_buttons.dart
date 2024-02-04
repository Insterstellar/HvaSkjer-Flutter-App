import 'package:flutter/material.dart';
import '../misc/colors.dart';
import '../pages/navpages/main_page.dart';
import '../widgets/app_text.dart';

class AppButtons extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final Color color;
  final Color backGroundColor;
  final double size;
  final bool isIcon;
  final Color borderColor;

  const AppButtons({
    Key? key,
    this.text,
    this.icon,
    required this.size,
    required this.color,
    required this.backGroundColor,
    this.isIcon = false,
    required this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
       // print('Button clicked!');
      },
      child: Container(
        width: 120,
        height: size,
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(5),
          color: backGroundColor,
        ),
        child: isIcon
            ? Icon(icon, color: color)
            : Center(
          child: AppText(
            text: text ?? '',
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ),
    );
  }
}
