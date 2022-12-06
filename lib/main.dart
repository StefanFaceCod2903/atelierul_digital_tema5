import 'package:atelierul_digital_tema5/data/movie_api.dart';
import 'package:atelierul_digital_tema5/src/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tema 6',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{'movieDetails': (BuildContext context) => const MovieDetails()},
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  List<Movie> _movies = <Movie>[];
  int _currentPage = 1;
  bool _isLoading = true;
  Future<void> _getMovies() async {
    final Client client = Client();
    final MovieApi movieApi = MovieApi(client);
    _movies = await movieApi.getMovies(_currentPage);
    setState(() {
      _isLoading = false;
      _currentPage++;
    });
  }

  void onScroll() {
    final double offset = _scrollController.offset;
    final double maxScroll = _scrollController.position.maxScrollExtent;
    if (offset >= maxScroll - MediaQuery.of(context).size.height && !_isLoading) {
      _getMovies();
    }
  }

  @override
  void initState() {
    super.initState();
    _getMovies();
    _scrollController.addListener(onScroll);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Infinite Movies!')),
      body: _isLoading == false
          ? CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(childCount: _movies.length, (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'movieDetails', arguments: _movies[index]);
                      },
                      child: Image.network(
                        _movies[index].image,
                      ),
                    );
                  }),
                ),
                SliverToBoxAdapter(
                  child: Builder(
                    builder: (BuildContext context) {
                      if (_isLoading) {
                        return Center(
                          child: LoadingAnimationWidget.staggeredDotsWave(
                            color: Colors.blue,
                            size: 50,
                          ),
                        );
                      } else {
                        return const SizedBox(
                          width: 100,
                          height: 100,
                        );
                      }
                    },
                  ),
                )
              ],
            )
          : Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.blue,
                size: 50,
              ),
            ),
    );
  }
}

class MovieDetails extends StatelessWidget {
  const MovieDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments! as Movie;
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: Column(
        children: <Widget>[
          Title(color: Colors.red, child: Text(movie.torrents[0].quality)),
          Text(movie.descriptionFull),
        ],
      ),
    );
  }
}
