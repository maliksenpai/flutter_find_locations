import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_find_locations/bloc/favorited_locations_bloc/favorited_event.dart';
import 'package:flutter_find_locations/bloc/locations_bloc/location_bloc.dart';
import 'package:flutter_find_locations/bloc/locations_bloc/location_event.dart';
import 'package:flutter_find_locations/database/location_database.dart';
import 'package:flutter_find_locations/page/main_page.dart';

import 'bloc/favorited_locations_bloc/favorited_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initApp();
  runApp(const MyApp());
}

Future initApp() async {
  await LocationDatabase().initDatabase();
  LocationDatabase().getFavoritedItems();
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocationBloc()..add(LocationGetItems(query: "hastane", country: null))),
        BlocProvider(create: (context) => FavoritedBloc()..add(GetFavoritedLocationsEvent()))
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        home: MainPage(),
      ),
    );
  }
}