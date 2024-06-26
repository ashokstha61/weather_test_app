import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/core/utils/constants.dart';
import 'package:weather/core/widgets/logo_widget.dart';
import 'package:weather/core/widgets/splash_widget.dart';
import 'package:weather/feature/onboarding/presentation/views/widgets/container_details_widget.dart';

class OnBoardingViewBody extends StatelessWidget {
  const OnBoardingViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashWidget(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: 40.h,
            left: Constants.defaultPadding,
            right: Constants.defaultPadding,
            bottom: Constants.defaultPadding,
          ),
          child: Column(
            children: const [
              LogoWidget(),
              Spacer(),
              ContainerDetailsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
