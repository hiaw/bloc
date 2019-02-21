import 'package:flutter_weather/blocs/blocs.dart';
import 'package:flutter_weather/models/models.dart';
import 'package:flutter_weather/repositories/repositories.dart';
import 'package:mockito/mockito.dart';
import 'package:test_api/test_api.dart';

class MockWeatherApiClient extends Mock implements WeatherApiClient {}

void main() {
  group('Weather Bloc', () {
    WeatherBloc weatherBloc;
    MockWeatherApiClient weatherApiClient;
    WeatherRepository weatherRepository;

    setUp(() {
      weatherApiClient = MockWeatherApiClient();
      weatherRepository = WeatherRepository(weatherApiClient: weatherApiClient);
      weatherBloc = WeatherBloc(weatherRepository: weatherRepository);
    });

    test('initial state', () {
      expect(weatherBloc.initialState, TypeMatcher<WeatherEmpty>());
    });

    test('Fetch Weather: wrong city', () {
      when(weatherApiClient.getLocationId('test'))
          .thenThrow(Exception('error getting locationId for city'));

      var expected = [
        TypeMatcher<WeatherEmpty>(),
        TypeMatcher<WeatherLoading>(),
        TypeMatcher<WeatherError>(),
      ];

      expectLater(weatherBloc.state, emitsInOrder(expected));

      weatherBloc.dispatch(FetchWeather(city: "test"));
    });

    test('Fetch Weather: correct city', () {
      const woeid = 1234;
      const cityName = 'test';

      when(weatherApiClient.getLocationId(cityName))
          .thenAnswer((_) => Future.value(woeid));
      when(weatherApiClient.fetchWeather(woeid))
          .thenAnswer((_) => Future.value(Weather(
                condition: WeatherCondition.clear,
                formattedCondition: "clear",
                minTemp: 0,
                temp: 20,
                maxTemp: 40,
                locationId: woeid,
                created: "created",
                lastUpdated: DateTime.now(),
                location: cityName,
              )));

      var expected = [
        TypeMatcher<WeatherEmpty>(),
        TypeMatcher<WeatherLoading>(),
        TypeMatcher<WeatherLoaded>(),
      ];

      expectLater(
        weatherBloc.state,
        emitsInOrder(expected),
      ).then((_) {
        verify(weatherApiClient.fetchWeather(woeid)).called(1);
      });

      weatherBloc.dispatch(FetchWeather(city: cityName));
    });
  });
}
