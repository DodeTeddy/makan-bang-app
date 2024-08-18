import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class FoodRateWidget extends StatelessWidget {
  final double rate;
  const FoodRateWidget({super.key, required this.rate});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.star,
          color: Colors.amber,
          size: 18.sp,
        ),
        Text(
          rate.toString(),
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontSize: 18.sp,
          ),
        ),
      ],
    );
  }
}
