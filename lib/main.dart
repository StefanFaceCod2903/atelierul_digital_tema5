import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

void main() {
  runApp(const MyApp());
}

///
class MyApp extends StatelessWidget {
  ///
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tema 5 simpla',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

///
class HomePage extends StatefulWidget {
  ///
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scrollController = ScrollController();
  final List<Movie> _movies = [];
  int _currentPage = 1;
  bool isLoading = true;
  Future<void> _getMovies() async {
    isLoading = true;
    final url = 'https://yts.mx/api/v2/list_movies.json/?page=$_currentPage';
    final response = await get(Uri.parse(url));
    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final data = body['data'] as Map<String, dynamic>;
    final moviesMap = data['movies'] as List<dynamic>;
    for (final item in moviesMap) {
      _movies.add(Movie.fromJson(item as Map<String, dynamic>));
    }
    setState(() {
      isLoading = false;
      _currentPage++;
    });
  }

  void onScroll() {
    final offset = scrollController.offset;
    final maxScroll = scrollController.position.maxScrollExtent;
    if (offset >= maxScroll - MediaQuery.of(context).size.height && !isLoading) {
      _getMovies();
    }
  }

  @override
  void initState() {
    super.initState();
    _getMovies();
    scrollController.addListener(onScroll);
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Infinite Movies!')),
      body: isLoading == false
          ? CustomScrollView(
              controller: scrollController,
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(childCount: _movies.length, (context, index) {
                    return Row(
                      children: [
                        Image.network(
                          _movies[index].image,
                          scale: 2,
                        ),
                        Expanded(
                          child: Text(
                            _movies[index].title,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    );
                  }),
                ),
                SliverToBoxAdapter(
                  child: Builder(
                    builder: (BuildContext context) {
                      if (isLoading) {
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

///This class is used as a model for parsing json
class Movie {
  ///
  Movie(this.title, this.image, this.year);

  ///this is a constructor that converts a map to movie object
  Movie.fromJson(Map<String, dynamic> json)
      : title = json['title'] as String,
        image = json['medium_cover_image'] as String,
        year = json['year'] as int;

  ///
  final String title;

  ///
  final String image;

  ///
  final int year;
}
