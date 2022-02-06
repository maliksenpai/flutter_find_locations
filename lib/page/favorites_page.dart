import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_find_locations/bloc/favorited_locations_bloc/favorited_bloc.dart';
import 'package:flutter_find_locations/bloc/favorited_locations_bloc/favorited_event.dart';
import 'package:flutter_find_locations/bloc/favorited_locations_bloc/favorited_state.dart';
import 'package:flutter_find_locations/database/location_database.dart';
import 'package:flutter_find_locations/page/detail_page.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {

  late FavoritedBloc favoritedBloc;

  @override
  void initState() {
    favoritedBloc = BlocProvider.of(context);
    favoritedBloc.add(GetFavoritedLocationsEvent());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorited Locations"),
      ),
      body: Container(
        child: BlocBuilder(
          bloc: favoritedBloc,
          builder: (context, state) {
            if (state is FavoritedLoadingState) {
              return CircularProgressIndicator();
            } else if (state is FavoritedReadyState) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: state.list.length,
                  itemBuilder: (context, index) {
                    var place = state.list[index];
                    return InkWell(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DetailPage(place: place))
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(child: Text(place.displayName)),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("${place.lat.substring(0,4)} - ${place.lng.substring(0,4)}"),
                                  place.favorited ?
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        place.favorited = false;
                                        LocationDatabase().unFavoritePlace(place);
                                      });
                                    },
                                    icon: Icon(Icons.star, color: Colors.yellow,),
                                  ) :
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        place.favorited = true;
                                        LocationDatabase().favoriteItem(place);
                                      });
                                    },
                                    icon: Icon(Icons.star, color: Colors.grey),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
