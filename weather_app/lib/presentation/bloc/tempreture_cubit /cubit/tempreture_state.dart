import 'package:equatable/equatable.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/presentation/bloc/weather_bloc/weather_bloc.dart';

abstract class TemperatureState extends Equatable {
  const TemperatureState();

  @override
  List<Object?> get props => [];
}

class TemperatureConversion extends TemperatureState {
  // final Weather weather;
  final double temperature;
  final bool isCelsius;



  const TemperatureConversion(this.temperature, this.isCelsius, );

  @override
  List<Object?> get props => [temperature, isCelsius];
}
