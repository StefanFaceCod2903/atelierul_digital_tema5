import 'package:atelierul_digital_tema5/src/models/index.dart';
import 'package:flutter/material.dart';

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
