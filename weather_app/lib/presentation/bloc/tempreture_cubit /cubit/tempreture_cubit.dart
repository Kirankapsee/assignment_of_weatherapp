import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:weather/weather.dart';
import 'package:weather_app/presentation/bloc/tempreture_cubit%20/cubit/tempreture_state.dart';
import 'package:weather_app/presentation/bloc/weather_bloc/weather_bloc.dart';

class TemperatureCubit extends Cubit<TemperatureState> {
  TemperatureCubit() : super(TemperatureConversion(0, true)); // Initial state with Celsius

  void convertTemperature(double temperature, bool isCelsius) {
    if (isCelsius) {
      double fahrenheit = (temperature * 9 / 5) + 32;
      emit(TemperatureConversion(
        fahrenheit,
        false,
      ));
    } else {
      double celsius = (temperature - 32) * 5 / 9;
      emit(TemperatureConversion(celsius, true));
    }
  }
}
