import 'package:flutter/material.dart';
import 'package:flutter_weather/blocs/blocs.dart';
import 'package:flutter_weather/models/models.dart';
import 'package:test_api/test_api.dart';

class ThemeTestCondition {
  WeatherCondition condition;
  Color theme;
  Color color;

  ThemeTestCondition(this.condition, this.theme, this.color);
}

void main() {
  group('Theme Bloc Test', () {
    ThemeBloc themeBloc;

    setUp(() {
      themeBloc = ThemeBloc();
    });

    test('Default Theme', () {
      expect(themeBloc.initialState.theme, ThemeData.light());
      expect(themeBloc.initialState.color, Colors.lightBlue);
    });

    List<ThemeTestCondition> testConditions = [
      ThemeTestCondition(
          WeatherCondition.clear, Colors.orangeAccent, Colors.yellow),
      ThemeTestCondition(
          WeatherCondition.lightCloud, Colors.orangeAccent, Colors.yellow),
      ThemeTestCondition(
          WeatherCondition.hail, Colors.lightBlueAccent, Colors.lightBlue),
      ThemeTestCondition(
          WeatherCondition.snow, Colors.lightBlueAccent, Colors.lightBlue),
      ThemeTestCondition(
          WeatherCondition.sleet, Colors.lightBlueAccent, Colors.lightBlue),
      ThemeTestCondition(
          WeatherCondition.heavyCloud, Colors.blueGrey, Colors.grey),
      ThemeTestCondition(
          WeatherCondition.heavyRain, Colors.indigoAccent, Colors.indigo),
      ThemeTestCondition(
          WeatherCondition.lightRain, Colors.indigoAccent, Colors.indigo),
      ThemeTestCondition(
          WeatherCondition.showers, Colors.indigoAccent, Colors.indigo),
      ThemeTestCondition(
        WeatherCondition.thunderstorm,
        Colors.deepPurpleAccent,
        Colors.deepPurple,
      ),
    ];

    for (ThemeTestCondition testCondition in testConditions) {
      test('${testCondition.condition.toString()}', () {
        expectLater(
          themeBloc.state,
          emitsThrough(
            ThemeState(
              theme: ThemeData(primaryColor: testCondition.theme),
              color: testCondition.color,
            ),
          ),
        );

        themeBloc.dispatch(WeatherChanged(condition: testCondition.condition));
      });
    }
  });
}
