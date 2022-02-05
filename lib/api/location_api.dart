import 'package:flutter_find_locations/model/place.dart' as model;
import 'package:osm_nominatim/osm_nominatim.dart';

class LocationApi{

  Future<List<model.Place>> getPlaces(String? query, String? country) async {
    List<model.Place> list = [];
    var result = await Nominatim.searchByName(
      query: query,
      country: country,
      limit: 50,
      addressDetails: true,
      extraTags: true,
      nameDetails: true,
    );
    result.forEach((element) {
      model.Place place = model.Place(place_id: element.placeId.toString(), lat: element.lat.toString(), lng: element.lon.toString(), displayName: element.displayName);
      list.add(place);
    });
    return list;
  }

}