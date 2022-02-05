import 'package:flutter_find_locations/model/place.dart';

class LocationState {}

class LocationInitstate extends LocationState {}

class LocationLoadingState extends LocationState {}

class LocationItemsReadyState extends LocationState {
  List<Place> list;

  LocationItemsReadyState({required this.list});
}
