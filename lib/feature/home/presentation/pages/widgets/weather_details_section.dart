import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather/core/animations/slide_transition_animation.dart';
import 'package:weather/core/utils/app_colors.dart';
import 'package:weather/core/utils/constants.dart';
import 'package:weather/core/widgets/custom_divider_widget.dart';
import 'package:weather/feature/home/data/models/weather_model/weather_model.dart';
import 'package:weather/feature/home/presentation/pages/widgets/weather_details_section_item.dart';

class WeatherDetailsSection extends StatelessWidget {
  const WeatherDetailsSection({
    Key? key,
    required this.weatherModel,
    required this.index,
  }) : super(key: key);

  final WeatherModel weatherModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return SlideTransitionAnimation(
      duration: const Duration(milliseconds: 700),
      begin: const Offset(0.5, 0),
      end: Offset.zero,
      curve: Curves.easeIn,
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: 20.h, horizontal: Constants.defaultPadding),
        decoration: BoxDecoration(
          color: AppColors.transparentWithOpacity10,
          borderRadius: BorderRadius.circular(20.h),
        ),
        padding: EdgeInsets.all(15.h),
        width: double.infinity,
        child: Row(
          children: [
            WeatherDetailsSectionItem(
              title: 'UV INDEX',
              value: index == 0
                  ? weatherModel.current!.uv!.toInt().toString()
                  : weatherModel.forecast!.forecastday![index].day!.uv
                      .toString(),
              icon: Icons.sunny,
              iconColor: AppColors.yellow,
            ),
            const CustomDividerWidget(),
            WeatherDetailsSectionItem(
              title: 'WIND',
              value: index == 0
                  ? '${weatherModel.current!.windMph} m/h'
                  : '${weatherModel.forecast!.forecastday![index].day!.maxwindMph} m/h',
              icon: FontAwesomeIcons.wind,
              iconColor: Colors.indigoAccent,
            ),
            const CustomDividerWidget(),
            WeatherDetailsSectionItem(
              title: 'HUMIDITY',
              value: index == 0
                  ? '${weatherModel.current!.humidity!.toInt()}%'
                  : '${weatherModel.forecast!.forecastday![index].day!.avghumidity}',
              icon: Icons.water_drop,
              iconColor: AppColors.blueAccent,
            ),
          ],
        ),
      ),
    );
  }
}
