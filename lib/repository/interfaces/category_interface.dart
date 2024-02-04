import 'package:begivenhet/models/category_model.dart';

abstract class CategoryInterface {
  Future<List<CategoryModel>>getAllCategory();
  Future<String> patchCompletedCategory(CategoryModel categoryModel);
  Future<String> putCompletedCategory(CategoryModel categoryModel);
  Future<String> deleteCategory(CategoryModel categoryModel);
  Future<String> postCategory(CategoryModel categoryModel);
}