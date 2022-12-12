import 'package:atelierul_digital_tema5/actions/index.dart';
import 'package:atelierul_digital_tema5/data/movie_api.dart';
import 'package:atelierul_digital_tema5/epics/movie_epics.dart';
import 'package:atelierul_digital_tema5/presentation/home_page.dart';
import 'package:atelierul_digital_tema5/presentation/movie_details.dart';
import 'package:atelierul_digital_tema5/reducers/reducer.dart';
import 'package:atelierul_digital_tema5/src/models/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart';
import 'package:redux/redux.dart';
import 'package:redux_epics/redux_epics.dart';

void main() {
  final Client client = Client();
  final MovieApi api = MovieApi(client);
  final AppEpics epics = AppEpics(api);
  final Store<AppState> store = Store<AppState>(
    reducer,
    initialState: const AppState(),
    middleware: <Middleware<AppState>>[
      EpicMiddleware<AppState>(epics.epic),
    ],
  )..dispatch(const GetMovie());
  runApp(
    MyApp(
      store: store,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.store});

  final Store<AppState> store;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Tema 6',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: <String, WidgetBuilder>{'movieDetails': (BuildContext context) => const MovieDetails()},
        home: const HomePage(),
      ),
    );
  }
}
