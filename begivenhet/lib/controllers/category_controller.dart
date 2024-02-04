import 'package:begivenhet/models/category_model.dart';
import 'package:begivenhet/repository/services/category_service.dart';

class CategoryController {

  final CategoryRepository _categoryRepository;
  CategoryController(this._categoryRepository);

  Future<List<CategoryModel>>fetchCategorysLists() async {
    return _categoryRepository.getAllCategory();
  }
}