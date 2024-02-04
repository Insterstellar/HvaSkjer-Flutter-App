import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnotherPage extends StatelessWidget {
  const AnotherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor:  const Color(0xFFfefcff),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 40,right: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 60,
                    height: 60,
                    child: Icon(Icons.add),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Color(0xFF716f72),
                        width: 1

                      )
                    ),

                ),
                SizedBox(width: 20,),
                Flexible(child:
                Container(
                  height: 60,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black
                  ) ,
                  child: Container(
                    padding: const EdgeInsets.only(left: 20,right: 20),
                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Next Page", style: TextStyle(fontSize: 20,
                            color: Colors.white
                        ),),
                        Icon(Icons.skip_next, color: Colors.white,)
                      ],
                    ),
                  ),
                )
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
