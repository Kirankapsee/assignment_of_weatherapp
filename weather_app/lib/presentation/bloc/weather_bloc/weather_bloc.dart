import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/core/constants.dart';

import '../tempreture_cubit /cubit/tempreture_state.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherLoading());

      try {
        WeatherFactory wf = WeatherFactory(Api_Key, language: Language.ENGLISH);
        // Position position = await Geolocator.getCurrentPosition();

        Weather weather =
            await wf.currentWeatherByLocation(event.position.latitude, event.position.longitude);
        print(weather);
        emit(WeatherLoaded(weather));
      } catch (e) {
        emit(WeatherFailure());
      }
      void convertTemperature(double temperature, bool isCelsius) {
        if (isCelsius) {
          double fahrenheit = (temperature * 9 / 5) + 32;
          emit(TemperatureConversion(fahrenheit, false) as WeatherState);
        } else {
          double celsius = (temperature - 32) * 5 / 9;
          emit(TemperatureConversion(celsius, true) as WeatherState);
        }
      }
    });
  }
}
