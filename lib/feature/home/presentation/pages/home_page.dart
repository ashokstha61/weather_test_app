import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather/core/utils/app_colors.dart';
import 'package:weather/core/utils/app_styles.dart';
import 'package:weather/core/utils/constants.dart';
import 'package:weather/feature/home/presentation/pages/widgets/home_view_body.dart';
import 'package:weather/feature/home/presentation/pages/widgets/location_button.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          Constants.weather,
          style: AppStyles.textStyle25.copyWith(
            color: AppColors.black,
          ),
        ),
        actions: const [
          LocationButton(),
        ],
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: AppColors.transparent,
        ),
      ),
      body: const HomeViewBody(),
    );
  }
}
