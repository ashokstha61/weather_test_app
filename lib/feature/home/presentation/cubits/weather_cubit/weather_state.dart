import 'package:weather/feature/home/data/models/weather_model/weather_model.dart';

abstract class CommonState {
  const CommonState();
}

class CommonInitialState extends CommonState {}

class CommonLoadingState extends CommonState {}

class CommonSuccessState extends CommonState {
  final WeatherModel weatherModel;

  const CommonSuccessState(this.weatherModel);
}

class CommonErrorState extends CommonState {
  final String error;

  const CommonErrorState(this.error);
}


