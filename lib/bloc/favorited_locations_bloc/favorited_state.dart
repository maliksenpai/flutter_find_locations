import 'package:flutter_find_locations/model/place.dart';

class FavoritedState {}

class FavoritedInitState extends FavoritedState{}

class FavoritedLoadingState extends FavoritedState{}

class FavoritedReadyState extends FavoritedState{

  List<Place> list;

  FavoritedReadyState({required this.list});

}