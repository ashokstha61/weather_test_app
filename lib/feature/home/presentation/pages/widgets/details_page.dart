import 'package:flutter/material.dart';
import 'package:weather/core/animations/slide_transition_animation.dart';
import 'package:weather/core/functions/change_gradient_color.dart';
import 'package:weather/core/utils/app_styles.dart';
import 'package:weather/core/widgets/gradient_container_widget.dart';
import 'package:weather/feature/home/data/models/weather_model/weather_model.dart';
import 'package:weather/feature/home/presentation/pages/widgets/basic_weather_details_section.dart';
import 'package:weather/core/widgets/app_bar_widget.dart';
import 'package:weather/feature/home/presentation/pages/widgets/weather_details_section.dart';

class DetailsPageView extends StatelessWidget {
  const DetailsPageView({
    super.key,
    required this.weatherModel,
    required this.pageController,
  });

  final WeatherModel weatherModel;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      itemCount: weatherModel.forecast!.forecastday!.length,
      itemBuilder: (context, index) {
        return GradientContainerWidget(
          colors: changeGradientColor(
            weatherName: index == 0
                ? weatherModel.current!.condition!.text!
                : weatherModel
                    .forecast!.forecastday![index].day!.condition!.text!,
          ),
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              AppBarWidget(
                title: SlideTransitionAnimation(
                  duration: const Duration(milliseconds: 700),
                  begin: const Offset(0.5, 0),
                  end: Offset.zero,
                  curve: Curves.easeIn,
                  child: Text(
                    '📍 ${weatherModel.location!.name!}',
                    style: AppStyles.textStyle25,
                  ),
                ),
              ),
              BasicWeatherDetailsSection(
                weatherModel: weatherModel,
                index: index,
              ),
              WeatherDetailsSection(
                weatherModel: weatherModel,
                index: index,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      },
    );
  }
}
