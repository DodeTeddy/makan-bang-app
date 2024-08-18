import 'package:makan_bang_app/models/menu.dart';
import 'package:makan_bang_app/providers/category_provider.dart';
import 'package:makan_bang_app/providers/search_provider.dart';

import '../constants/icons.dart';

class MenuProvider {
  CategoryProvider? categoryProvider;
  SearchProvider? searchProvider;

  MenuProvider({this.categoryProvider, this.searchProvider});

  List<Menu> menu = [
    Menu(1, 2, 'Cola', drink, 2000, 5.0),
    Menu(2, 2, 'Sprite', drink, 2000, 4.5),
    Menu(3, 2, 'Fanta', drink, 2000, 4.0),
    Menu(4, 3, 'Cheese Burger', burger, 2000, 5.0),
    Menu(5, 3, 'Beef Burger', burger, 2000, 4.2),
    Menu(6, 3, 'Chicken Burger', burger, 2000, 3.8),
    Menu(7, 4, 'BBQ Fries', frenchFries, 2000, 4.5),
    Menu(8, 4, 'Curly Fries', frenchFries, 2000, 5.0),
    Menu(9, 4, 'Spicy Fries', frenchFries, 2000, 4.0),
    Menu(10, 5, 'Chicken Ramen', ramen, 2000, 4.5),
    Menu(11, 5, 'Beef Ramen', ramen, 2000, 4.8),
    Menu(12, 5, 'Spicy Ramen', ramen, 2000, 5.0),
  ];

  List<Menu> getMenu() {
    if (categoryProvider!.categoryId != 1) {
      menu = menu
          .where((e) => e.categoryId == categoryProvider!.categoryId)
          .toList();
    }

    if (searchProvider!.search.isNotEmpty) {
      menu = menu
          .where((e) => e.foodName
              .toLowerCase()
              .contains(searchProvider!.search.toLowerCase()))
          .toList();
    }

    return menu;
  }

  List<Menu> getPopularFood() {
    return menu.where((e) => e.foodRate == 5.0).toList();
  }
}
