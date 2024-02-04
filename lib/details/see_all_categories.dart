import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';


import '../controllers/category_controller.dart';
import '../misc/my_colors.dart';
import '../repository/services/category_service.dart';
import 'categorydetails/category_events.dart';
import 'categorydetails/list_categorydetails.dart';
import 'datails_page.dart';

class CategoryImageRoute extends StatefulWidget {

  CategoryImageRoute();

  @override
  CategoryImageRouteState createState() => new CategoryImageRouteState();
}


class CategoryImageRouteState extends State<CategoryImageRoute> {
  var categoryController = CategoryController(CategoryRepository());


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarBrightness: Brightness.dark
          ),
          backgroundColor: MyColors.primary,
          title: Text("Categories", style: TextStyle(color: MyColors.grey_10)),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_outlined, color: MyColors.grey_10),
            onPressed: () {
              Navigator.pop(context);
            },
          ),

      ),
      body: FutureBuilder(
        future: categoryController.fetchCategorysLists(),
        builder: (context, snapshot) {

          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  color: Colors.white,
                  height: 200, // Specify the desired height of the shimmer container
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!, // Specify the base color of the shimmer
                    highlightColor: Colors.grey[100]!, // Specify the highlight color of the shimmer
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          color: Colors.white, // Specify the color of the container
                        ),
                      ),
                    ),
                  ),
                )

                ;


              }
              if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              var allCategory=snapshot.data?[index];
              var eventTotal=allCategory?.eventsList;
              return GestureDetector(
                onTap: () {



                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CategoryEvents(categoryItems: allCategory)),
                  );
                },
// make the listcategory return a button and make it clickable to open categoryevents class
                child: ListCategory(
                    index: eventTotal?.length?? 0,
                    categoryName: allCategory?.name,
                    imagePath: allCategory?.picture, onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CategoryEvents(categoryItems: allCategory)),
                  );

                },
                  ),
              );
            },
          );
        }
      ),
    );
  }
}

