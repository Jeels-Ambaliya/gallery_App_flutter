import 'package:flutter/cupertino.dart';
import 'package:gallery_app/Modal/category_Modal.dart';

class CategoryProvider extends ChangeNotifier {
  CategoryModal Index = CategoryModal(Index: 0);

  changeCategory({required int i}) {
    Index.Index = i;

    return Index;
    notifyListeners();
  }
}
