import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/presentation/bloc/tempreture_cubit%20/cubit/tempreture_cubit.dart';
import 'package:weather_app/presentation/bloc/tempreture_cubit%20/cubit/tempreture_state.dart';
import 'package:weather_app/presentation/bloc/weather_bloc/weather_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isCelsius = true;

  double convertTemperature(double celsius) {
    if (isCelsius) {
      return celsius;
    } else {
      return (celsius * 9 / 5) + 32;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TemperatureCubit(),
      child: Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Align(
                  alignment: const AlignmentDirectional(3, -0.3),
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration:
                        const BoxDecoration(shape: BoxShape.circle, color: Colors.deepPurple),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(-3, -0.3),
                  child: Container(
                    height: 300,
                    width: 300,
                    decoration:
                        const BoxDecoration(shape: BoxShape.circle, color: Colors.deepOrangeAccent),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0, -1.2),
                  child: Container(
                    height: 300,
                    width: 600,
                    decoration:
                        const BoxDecoration(shape: BoxShape.rectangle, color: Colors.amberAccent),
                  ),
                ),
                BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                    child: Container(
                      decoration: const BoxDecoration(color: Colors.transparent),
                    )),
                BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is WeatherLoaded) {
                      return SingleChildScrollView(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '📍${state.weather.areaName}',
                                style: const TextStyle(
                                    color: Colors.white, fontWeight: FontWeight.w300),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Hey !',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              GetWeatherIcon(code: state.weather.weatherConditionCode!),
                              BlocBuilder<TemperatureCubit, TemperatureState>(
                                builder: (context, state1) {
                                  return Column(
                                    children: [
                                      Center(
                                          child: Text(
                                        (isCelsius)
                                            ? '${state.weather.temperature!.celsius!.round()}°C'
                                            : '${state.weather.temperature!.fahrenheit!.round()}°F ',
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 55,
                                            fontWeight: FontWeight.w600),
                                      )),
                                      ElevatedButton(
                                        onPressed: () {
                                          // isCelsius = true;
                                          tempretureConversion();
                                        },
                                        child: Text((isCelsius)
                                            ? 'Convert to Fahrenheit'
                                            : 'Convert to Celsius'),
                                      )
                                    ],
                                  );
                                },
                              ),
                              Center(
                                  child: Text(
                                state.weather.weatherMain!.toUpperCase(),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),
                              )),
                              Center(
                                  child: Text(
                                DateFormat('EEEE dd . ').add_jm().format(state.weather.date!),
                                // 'Friday 16 . 09.41am',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 16, fontWeight: FontWeight.w300),
                              )),
                              const SizedBox(
                                height: 40,
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    'assets/images/Sun.png',
                                    scale: 20,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Sunrise',
                                          style: TextStyle(
                                              color: Colors.white, fontWeight: FontWeight.w300),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          DateFormat().add_jm().format(state.weather.sunrise!),
                                          // '5:35 pm'

                                          style: const TextStyle(
                                              color: Colors.white, fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Spacer(),
                                  SingleChildScrollView(
                                    child: Expanded(
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/Sunstar.png',
                                            scale: 20,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Sunset',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w300),
                                              ),
                                              const SizedBox(
                                                height: 3,
                                              ),
                                              Text(
                                                DateFormat().add_jm().format(state.weather.sunset!),
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w700),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Divider(
                                    color: Colors.grey,
                                  )),
                              // SizedBox(
                              //   height: 20,
                              // ),
                              SingleChildScrollView(
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/Thermometer.png',
                                      scale: 20,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(left: 30),
                                          child: Text(
                                            'Temp max',
                                            style: TextStyle(
                                                color: Colors.white, fontWeight: FontWeight.w300),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 30),
                                          child: Text(
                                            "${state.weather.tempMax!.celsius!.round()}°C",
                                            style: const TextStyle(
                                                color: Colors.white, fontWeight: FontWeight.w700),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Spacer(),
                                    SingleChildScrollView(
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'assets/images/Cloud.png',
                                            scale: 20,
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  'Temp min',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w300),
                                                ),
                                                const SizedBox(
                                                  height: 3,
                                                ),
                                                Text(
                                                  "${state.weather.tempMin!.celsius!.round()}°C",
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void tempretureConversion() {
    setState(() {
      //   // Toggle the temperature unit
      isCelsius = !isCelsius;
    });
  }
}

class GetWeatherIcon extends StatelessWidget {
  const GetWeatherIcon({
    super.key,
    required this.code,
  });

  final int code;

  @override
  Widget build(BuildContext context) {
    switch (code) {
      case > 200 && <= 300:
        return Image.asset('assets/images/Thunderstorm.png');
      case > 300 && <= 400:
        return Image.asset('assets/images/Cloudrain.png');
      case > 500 && <= 600:
        return Image.asset('assets/images/Rain.png');
      case > 700 && <= 800:
        return Image.asset('assets/images/Snow.png');
      case == 800:
        return Image.asset('assets/images/Wind.png');
      case > 200 && <= 300:
        return Image.asset('assets/images/Sun.png');
      default:
        return Image.asset('assets/images/Cloudsun.png');
    }
  }
}
