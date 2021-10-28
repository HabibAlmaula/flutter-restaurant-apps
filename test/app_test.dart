import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:restaurant_app/data/models/detail_restaurant.dart';
import 'package:restaurant_app/data/models/restaurant.dart';
import 'package:restaurant_app/data/service/api_service.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:mockito/mockito.dart';

import 'app_test.mocks.dart';

@GenerateMocks([DatabaseProvider, ApiService])
void main() {
  group('App Test', () {
    late ContentDetailRestaurant restaurant;
    late ApiService apiService;
    late DatabaseProvider databaseProvider;

    setUp(() {
      restaurant = ContentDetailRestaurant(
          id: 'qwerty212',
          name: 'Fremilt House',
          description: 'Mondays Only',
          city: 'Surakarta',
          address: 'Jl.Matoa Raya',
          rating: 4.2,
          pictureId: 'image_jpg');
      apiService = MockApiService();
      databaseProvider = MockDatabaseProvider();
    });

    test('Should pass getting restaurant detail from API', () async {
      when(apiService.getDetailRestaurant(restaurant.id)).thenAnswer((_) async {
        return DetailRestaurant(
          error: false,
          message: 'success',
          restaurant: restaurant,
        );
      });
      expect(await apiService.getDetailRestaurant(restaurant.id),
          isA<DetailRestaurant>());
    });

    test('Should pass getting faovourite restaurant', () {
      when(databaseProvider.restaurant).thenAnswer((realInvocation) {
        var rest = Restaurant(
            id: restaurant.id,
            name: restaurant.name,
            description: restaurant.description,
            pictureId: restaurant.pictureId,
            city: restaurant.city,
            rating: restaurant.rating);

        List<Restaurant> restaurants = [rest];
        return restaurants;
      });
      expect(databaseProvider.restaurant, isA<List<Restaurant>>());
    });

    test('Should pass when parsing json', () {
      var response =
          ContentDetailRestaurant.fromJson(restaurant.toJson(restaurant));

      expect(response.name, restaurant.name);
    });
  });
}
