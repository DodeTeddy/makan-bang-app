import 'package:makan_bang_app/constants/icons.dart';
import 'package:makan_bang_app/constants/images.dart';

class Category {
  final int id;
  final String categoryName;
  final String categoryImage;

  Category(
    this.id,
    this.categoryName,
    this.categoryImage,
  );

  static List<Category> getCategories() {
    return <Category>[
      Category(1, 'All', fryingPan),
      Category(2, 'Drink', drink),
      Category(3, 'Burger', burger),
      Category(4, 'French Fries', frenchFries),
      Category(5, 'Ramen', ramen),
    ];
  }
}
