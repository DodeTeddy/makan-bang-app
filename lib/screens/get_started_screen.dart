import 'package:flutter/material.dart';
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import 'package:makan_bang_app/constants/images.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../widgets/language_dropdown_widget.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: 2.h,
            left: 3.w,
            right: 3.w,
          ),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MAKAN BANG APP',
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      const LanguageDropdownWidget(isOnPrimary: true),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        fryingPan,
                        width: 60.w,
                      ),
                      Text(
                        AppLocalizations.of(context).slogan.toUpperCase(),
                        style: TextStyle(
                          fontSize: 22.sp,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context).promotion,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontSize: 17.sp,
                              height: 0.2.h,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                      ElevatedButton.icon(
                        label: Text(
                          AppLocalizations.of(context).start,
                          style: TextStyle(fontSize: 18.sp),
                        ),
                        icon: const Icon(Icons.arrow_forward),
                        iconAlignment: IconAlignment.end,
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(80.w, 6.h),
                        ),
                        onPressed: () => Navigator.pushNamedAndRemoveUntil(
                            context, '/home', (_) => false),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
