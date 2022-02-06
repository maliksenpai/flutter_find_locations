import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_find_locations/api/location_api.dart';
import 'package:flutter_find_locations/bloc/locations_bloc/location_event.dart';
import 'package:flutter_find_locations/bloc/locations_bloc/location_state.dart';
import 'package:flutter_find_locations/database/location_database.dart';
import 'package:flutter_find_locations/model/place.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState>{

  List<Place> listPlaces = [];

  LocationBloc() : super(LocationInitstate()){
    on<LocationGetItems>((event, emit) async {
      emit(LocationLoadingState());
      listPlaces = await LocationApi().getPlaces(event.query, event.country);
      emit(LocationItemsReadyState(list: listPlaces));
    });
    on<LocationCheckFavoritedItems>((event, emit) async {
      listPlaces = await LocationDatabase().checkFavoritedItems(listPlaces);
      emit(LocationItemsReadyState(list: listPlaces));
    });
  }

}
