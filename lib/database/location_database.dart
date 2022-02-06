import 'package:flutter_find_locations/model/place.dart';
import 'package:sqflite/sqflite.dart';

class LocationDatabase {
  static final LocationDatabase _locationDatabase = LocationDatabase._internal();
  late Database database;

  factory LocationDatabase() {
    return _locationDatabase;
  }

  LocationDatabase._internal();

  Future initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = databasesPath + "location.db";
    database = await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE IF NOT EXISTS location (id TEXT PRIMARY KEY, displayName TEXT, lat TEXT, lng TEXT)");
    });
  }

  Future<List<Place>> getFavoritedItems() async {
    List<Place> list = [];
    var queryList = await database.query("location");
    for (var e in queryList) {
      Place place = Place(
        place_id: e["id"].toString(),
        displayName: e["displayName"].toString(),
        lat: e["lat"].toString(),
        lng: e["lng"].toString(),
        favorited: true
      );
      list.add(place);
    }
    return list;
  }

  Future<List<Place>> checkFavoritedItems(List<Place> listPlace) async {
    var queryList = await database.query("location");
    listPlace.forEach((element) {element.favorited = false;});
    for (var e in queryList) {
      Place place = Place(
          place_id: e["id"].toString(),
          displayName: e["displayName"].toString(),
          lat: e["lat"].toString(),
          lng: e["lng"].toString(),
          favorited: true
      );
      var indexElement = listPlace.indexWhere((element) => element.place_id == place.place_id);
      if(indexElement != -1){
        listPlace[indexElement].favorited = true;
      }
    }
    return listPlace;
  }

  Future favoriteItem(Place place) async {
    await database.insert(
        "location",
        {
          "id": place.place_id,
          "displayName": place.displayName,
          "lat": place.lat,
          "lng": place.lng,
        },
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future unFavoritePlace(Place place) async {
    await database.delete(
      "location",
      where: "id = ${place.place_id}"
    );
  }
}
