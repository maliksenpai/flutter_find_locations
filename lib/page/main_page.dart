import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_find_locations/api/location_api.dart';
import 'package:flutter_find_locations/bloc/locations_bloc/location_bloc.dart';
import 'package:flutter_find_locations/bloc/locations_bloc/location_event.dart';
import 'package:flutter_find_locations/bloc/locations_bloc/location_state.dart';
import 'package:flutter_find_locations/database/location_database.dart';
import 'package:flutter_find_locations/model/place.dart';
import 'package:flutter_find_locations/page/detail_page.dart';
import 'package:flutter_find_locations/view/main_drawer.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late LocationBloc locationBloc;
  TextEditingController textEditingController = TextEditingController();

  @override
  initState() {
    locationBloc = BlocProvider.of(context);
    locationBloc.add(LocationCheckFavoritedItems());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search Places")),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            alignment: Alignment.center,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: TextField(
                    controller: textEditingController,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () => {
                    locationBloc.add(LocationGetItems(query: textEditingController.text))
                  },
                )
              ],
            ),
          ),
          BlocBuilder(
            bloc: locationBloc,
            builder: (context, state) {
              if (state is LocationLoadingState) {
                return CircularProgressIndicator();
              } else if (state is LocationItemsReadyState) {
                return Flexible(
                  child: Padding(
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
                  ),
                );
              } else {
                return Container();
              }
            },
          )
        ],
      ),
    );
  }
}
