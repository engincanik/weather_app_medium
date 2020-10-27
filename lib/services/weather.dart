import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hms_weather/services/position.dart';
import 'package:hms_weather/services/networking.dart';

const apiKey = 'b5099f37350670a79e9c5c785a0f8325';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper =
        NetworkHelper(url: '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Position position = Position();
    await position.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        url:
            '$openWeatherMapURL?lat=${position.latitude}&lon=${position.longitude}&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  String getWeatherSVGNetwork(int condition) {
    if (condition < 300) {
      // return SvgPicture.asset('images/storm.svg', width: 70, height: 70,);
      return 'https://www.flaticon.com/svg/static/icons/svg/3026/3026385.svg';
    } else if (condition < 400) {
      // return SvgPicture.asset('images/rain.svg', width: 70, height: 70,);
      return 'https://www.flaticon.com/svg/static/icons/svg/899/899693.svg';
    } else if (condition < 600) {
      // return SvgPicture.asset('images/umbrella.svg️', width: 70, height: 70,);
      return 'https://www.flaticon.com/svg/static/icons/svg/2921/2921803.svg';
    } else if (condition < 700) {
      // return SvgPicture.asset('images/snowflake.svg'️, width: 70, height: 70,);
      return 'https://www.flaticon.com/svg/static/icons/svg/2834/2834554.svg';
    } else if (condition < 800) {
      // return SvgPicture.asset('images/fog.svg', width: 70, height: 70,);
      return 'https://www.flaticon.com/svg/static/icons/svg/2446/2446001.svg';
    } else if (condition == 800) {
      return 'https://www.flaticon.com/svg/static/icons/svg/146/146199.svg';
    } else if (condition <= 804) {
      // return 'images/cloud.svg️';
      return 'https://www.flaticon.com/svg/static/icons/svg/899/899681.svg';
    } else {
      // return '🤷‍';
      return 'https://www.flaticon.com/svg/static/icons/svg/2471/2471920.svg';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

  SvgPicture getBackground(int condition, int temp) {
    if (condition < 300) {
      return SvgPicture.asset('images/storm_bg.svg');
      // return [Colors.pink.shade600, Colors.orange.shade400];
    } else if (condition < 400) {
      return SvgPicture.asset('images/storm_bg.svg');
      // return [Colors.green.shade300, Colors.purple.shade400];
    } else if (condition < 600) {
      return SvgPicture.asset('images/umbrella_bg.svg');
      // return [Colors.green.shade300, Colors.purple.shade400];
    } else if (condition < 700) {
      return SvgPicture.asset('images/snowman_bg.svg');
      // return [Colors.red.shade400, Colors.teal.shade400];
    } else if (condition < 800) {
      return SvgPicture.asset('images/cloudy_bg.svg');
      // return [Colors.green.shade300, Colors.purple.shade400];
    } else if (condition == 800 && temp >= 20) {
      return SvgPicture.asset('images/very_hot_bg.svg');
    } else if (condition == 800 && temp < 20) {
      return SvgPicture.asset('images/sunny_bg.svg');
      // return [Colors.blue.shade600, Colors.yellow.shade400];
    } else if (condition <= 804) {
      return SvgPicture.asset('images/cloudy_bg.svg');
      // return [Colors.green.shade300, Colors.purple.shade400];
    } else {
      return SvgPicture.asset('images/sunny_bg.svg');
      // return [Colors.green.shade300, Colors.purple.shade400];
    }
  }

  List<Color> getBackgroundColor(int condition) {
    if (condition < 300) {
      // return SvgPicture.asset('images/storm_bg.svg');
      return [Colors.pink.shade600, Colors.orange.shade400];
    } else if (condition < 400) {
      // return SvgPicture.asset('images/storm_bg.svg');
      return [Colors.green.shade300, Colors.purple.shade400];
    } else if (condition < 600) {
      // return SvgPicture.asset('images/umbrella_bg.svg');
      return [Colors.green.shade300, Colors.purple.shade400];
    } else if (condition < 700) {
      // return SvgPicture.asset('images/snowman_bg.svg');
      return [Colors.red.shade400, Colors.tealAccent.shade400];
    } else if (condition < 800) {
      // return 'images/fog.svg';
      return [Colors.green.shade300, Colors.purple.shade400];
    } else if (condition == 800) {
      // return SvgPicture.asset('images/sunny_bg.svg');
      return [Colors.blue.shade600, Colors.yellow.shade400];
    } else if (condition <= 804) {
      // return SvgPicture.asset('images/cloudy_bg.svg');
      return [Colors.green.shade300, Colors.purple.shade400];
    } else {
      // return SvgPicture.asset('images/sunny_bg.svg');
      return [Colors.green.shade300, Colors.purple.shade400];
    }
  }
}
