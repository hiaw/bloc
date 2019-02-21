import 'package:flutter_weather/blocs/blocs.dart';
import 'package:test_api/test_api.dart';

void main() {
  group('Settings Bloc Test', () {
    SettingsBloc settingsBloc;

    setUp(() {
      settingsBloc = SettingsBloc();
    });

    test('Initial state should be celsius', () {
      expect(
        settingsBloc.initialState.temperatureUnits,
        TemperatureUnits.celsius,
      );
    });

    test('toggle temperature settings', () {
      final List<SettingsState> expected = [
        SettingsState(temperatureUnits: TemperatureUnits.celsius),
        SettingsState(temperatureUnits: TemperatureUnits.fahrenheit),
        SettingsState(temperatureUnits: TemperatureUnits.celsius),
      ];

      expectLater(settingsBloc.state, emitsInOrder(expected));

      settingsBloc.dispatch(TemperatureUnitsToggled());
      settingsBloc.dispatch(TemperatureUnitsToggled());
    });
  });
}
