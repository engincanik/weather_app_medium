import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hms_weather/services/weather.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({this.locationWeather});

  final locationWeather;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherModel weather = WeatherModel();
  int temperature;
  String cityName;
  String weatherMessage;
  double newHeight;
  String weatherSVG = '';
  SvgPicture svgBG;
  List<Color> backgroundColors = [Colors.white, Colors.blueGrey];

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  double getScreenSafeHeight() {
    double height = MediaQuery.of(context).size.height;
    var padding = MediaQuery.of(context).padding;
    newHeight = height - padding.top - padding.bottom;
    return newHeight;
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherSVG = 'https://www.flaticon.com/svg/static/icons/svg/2471/2471920.svg';
        cityName = 'There is an error.';
        svgBG = SvgPicture.asset('images/404-error.svg');
        return;
      }
      var temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      weatherMessage = weather.getMessage(temperature);
      var condition = weatherData['weather'][0]['id'];
      weatherSVG = weather.getWeatherSVGNetwork(condition);
      svgBG = weather.getBackground(condition, temperature);
      backgroundColors = weather.getBackgroundColor(condition);
      cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: backgroundColors[0],
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 150.0,
                  decoration: BoxDecoration(
                    color: backgroundColors[1],
                    border: Border.all(
                      color: backgroundColors[1],
                    ),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: FlatButton(
                                onPressed: () async {
                                  var weatherData = await weather.getLocationWeather();
                                  updateUI(weatherData);
                                },
                                child: Icon(
                                  Icons.near_me,
                                  size: 50.0,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                '$cityName',
                                style: TextStyle(
                                  fontSize: 25.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '$temperature°',
                            style: TextStyle(
                              fontSize: 50,
                            ),
                          ),
                          SvgPicture.network(
                            weatherSVG,
                            height: 70,
                            width: 70,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  child: svgBG,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
