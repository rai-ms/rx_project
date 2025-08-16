import 'package:flutter/material.dart';
import 'package:rx_project/core/utils/app_colors.dart';
import 'package:rx_project/core/utils/app_image.dart';
import 'package:rx_project/core/utils/app_style.dart';
import 'package:rx_project/core/utils/size_utils.dart';
import 'package:rx_project/core/utils/utility_helper.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.msuGreen,
      body: Center(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'No Internet Connection',
                style: AppStyles.larger.semiBold.white,
              ),
              UtilityHelper.assetImage(
                width: Space.w(context),
                path: AppAssets.noInternet,
                fit: BoxFit.fitWidth,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
