import 'dart:convert';

import 'package:begivenhet/data/urls.dart';
import 'package:begivenhet/models/category_model.dart';
import 'package:begivenhet/repository/interfaces/category_interface.dart';
import 'package:http/http.dart' as http;

class CategoryRepository implements CategoryInterface{
  String baseUrl='https://hva-skjer.herokuapp.com';


  @override
  Future<String> deleteCategory(CategoryModel categoryModel) {
    // TODO: implement deleteCategory
    throw UnimplementedError();
  }

  //return
  @override
  Future<List<CategoryModel>> getAllCategory() async {

    List<CategoryModel> categoryLists=[];
    var url = Uri.parse('$baseUrl/api/v1/category/all');
    var response =await http.get(url);
    var body = json.decode(response.body);

    for(var i=0; i< body.length; i++){
      categoryLists.add(CategoryModel.fromJson(body[i]));

    }
    return categoryLists;
  }

  @override
  Future<String> patchCompletedCategory(CategoryModel categoryModel) {
    // TODO: implement patchCompletedCategory
    throw UnimplementedError();
  }

  @override
  Future<String> postCategory(CategoryModel categoryModel) {
    // TODO: implement postCategory
    throw UnimplementedError();
  }

  @override
  Future<String> putCompletedCategory(CategoryModel categoryModel) {
    // TODO: implement putCompletedCategory
    throw UnimplementedError();
  }

}