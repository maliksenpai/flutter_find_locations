class LocationEvent {}

class LocationGetItems extends LocationEvent {

  String? query;
  String? country;

  LocationGetItems({this.query, this.country});
}

class LocationCheckFavoritedItems extends LocationEvent{}