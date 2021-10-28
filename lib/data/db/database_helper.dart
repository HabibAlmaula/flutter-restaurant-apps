import 'package:restaurant_app/data/models/restaurant.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;
  static const _tableFavorite = 'fav_restaurant';

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  Future<Database> _initializeDB() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/restaurant.db',
      onCreate: (db, version) async {
        await db.execute(''' CREATE TABLE $_tableFavorite (
          id varchar PRIMARY KEY,
          name varchar,
          description varchar,
          pictureId varchar,
          city varchar,
          rating double
          )''');
      },
      version: 1,
    );

    return db;
  }

  Future<Database?> get database async {
    _database ??= await _initializeDB();

    return _database;
  }

  Future<void> addToFavourite(Restaurant restaurant) async {
    final db = await database;
    await db!.insert(_tableFavorite, restaurant.toJson(restaurant));
  }

  Future<List<Restaurant>> getFavouriteRestaurant() async {
    final db = await database;
    List<Map<String, dynamic>> restaurantList = await db!.query(_tableFavorite);
    return restaurantList.map((e) => Restaurant.fromJson(e)).toList();
  }

  Future<Map> getFavouriteById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> restaurantList = await db!.query(
      _tableFavorite,
      where: 'id = ?',
      whereArgs: [id],
    );

    if(restaurantList.isNotEmpty){
      return restaurantList.first;
    }else{
      return {};
    }
  }

  Future<void> removeFavourite(String id) async{
    final db = await database;

    await db!.delete(_tableFavorite, where: 'id = ?', whereArgs: [id]);
  }
}
