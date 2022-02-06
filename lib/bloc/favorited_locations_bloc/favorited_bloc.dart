import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_find_locations/bloc/favorited_locations_bloc/favorited_event.dart';
import 'package:flutter_find_locations/bloc/favorited_locations_bloc/favorited_state.dart';
import 'package:flutter_find_locations/database/location_database.dart';
import 'package:flutter_find_locations/model/place.dart';

class FavoritedBloc extends Bloc<FavoritedEvent, FavoritedState>{

  late List<Place> list;

  FavoritedBloc() : super(FavoritedInitState()){
    on<GetFavoritedLocationsEvent>((event, emit) async {
      emit(FavoritedLoadingState());
      list = await LocationDatabase().getFavoritedItems();
      emit(FavoritedReadyState(list: list));
    });
  }

}