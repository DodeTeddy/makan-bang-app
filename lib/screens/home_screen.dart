import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:makan_bang_app/models/category.dart';
import 'package:makan_bang_app/models/menu.dart';
import 'package:makan_bang_app/providers/category_provider.dart';
import 'package:makan_bang_app/providers/menu_provider.dart';
import 'package:makan_bang_app/providers/search_provider.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../utilities/debounce.dart';
import '../widgets/food_rate_widget.dart';
import '../widgets/language_dropdown_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final debounce = Debounce(milliseconds: 1000);
    List<Category> categories = Category.getCategories();

    /* Header Section */
    Widget headerSection() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context).greeting('Dode'),
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const LanguageDropdownWidget(),
              ],
            ),
            Text(
              AppLocalizations.of(context).eat,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontSize: 16.sp,
                  ),
            ),
          ],
        ),
      );
    }

    /* Filter Section */
    Widget filterSection() {
      return Column(
        children: [
          Consumer<SearchProvider>(
            builder: (context, _, __) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: AppLocalizations.of(context).hintText,
                    hintStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 16.sp,
                        ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onChanged: (value) => debounce.run(
                    () {
                      context.read<SearchProvider>().setSearch(value);
                    },
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 2.h),
          Consumer<CategoryProvider>(
            builder: (_, categoryProvider, __) {
              return SizedBox(
                height: 5.h,
                width: double.infinity,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () => context
                          .read<CategoryProvider>()
                          .setCategoryId(index, categories[index].id),
                      child: Container(
                        margin: EdgeInsets.only(
                          left: index == 0 ? 5.w : 2.w,
                          right: index == categories.length - 1 ? 5.w : 0,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 3.w,
                          vertical: 1.h,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: categoryProvider.index == index
                              ? Theme.of(context).colorScheme.secondary
                              : Theme.of(context).colorScheme.primary,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Image.asset(
                              categories[index].categoryImage,
                              width: 8.w,
                              height: 8.h,
                            ),
                            SizedBox(width: 1.w),
                            Text(
                              categories[index].categoryName,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 15.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          )
        ],
      );
    }

    /* Menu Section */
    Widget menuSection() {
      return Consumer<MenuProvider>(builder: (_, menuProvider, __) {
        List<Menu> menus = menuProvider.getMenu();

        return SizedBox(
          height: 25.h,
          width: double.infinity,
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: menus.length,
            itemBuilder: (_, index) {
              return Container(
                width: 40.w,
                margin: EdgeInsets.only(
                  left: index == 0 ? 5.w : 2.w,
                  right: index == menus.length - 1 ? 5.w : 0,
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: 3.w,
                  vertical: 1.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      menus[index].foodImage,
                      width: 25.w,
                    ),
                    SizedBox(height: 1.h),
                    Text(
                      menus[index].foodName,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 18.sp,
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            menus[index].foodPrice.toString(),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 18.sp,
                            ),
                          ),
                          FoodRateWidget(rate: menus[index].foodRate),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        );
      });
    }

    /* Popular Food Section */
    Widget popularFoodSection() {
      return Consumer<MenuProvider>(builder: (_, menuProvider, __) {
        List<Menu> popularFood = menuProvider.getPopularFood();

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context).popularFood,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              ...List.generate(
                popularFood.length,
                (index) {
                  return Container(
                    margin: EdgeInsets.only(
                      top: 1.5.h,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          popularFood[index].foodImage,
                          width: 15.w,
                        ),
                        SizedBox(width: 3.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                popularFood[index].foodName,
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 18.sp,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    popularFood[index].foodPrice.toString(),
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                  FoodRateWidget(
                                      rate: popularFood[index].foodRate),
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      });
    }

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            headerSection(),
            SizedBox(height: 3.h),
            filterSection(),
            SizedBox(height: 3.h),
            menuSection(),
            SizedBox(height: 3.h),
            popularFoodSection(),
            SizedBox(height: 3.h),
          ],
        ),
      ),
    );
  }
}
