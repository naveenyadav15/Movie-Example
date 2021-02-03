import 'dart:math';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_provider/src/model/core/movie.dart';
import 'package:movie_provider/src/model/glitch/noInternet.dart';

import '../movieErrorTile.dart';
import 'movieDetailUi.dart';

class MovieDetailPage extends StatelessWidget {
  final String imdbId;
  final provider;
  MovieDetailPage({
    @required this.imdbId,
    @required this.provider,
  });

  Widget movies;

  loadData() async {
    var result = await provider.getMovieById(imdbId);
    result.fold((l) {
      if (l is NoInternetGlitch) {
        Color randomColor = Color.fromRGBO(Random().nextInt(255),
            Random().nextInt(255), Random().nextInt(255), 1);
        movies = MovieErrorTile(randomColor, "Unable to Connect");
      }
    },
        (r) => {
              movies = MovieDetailUi(
                movieItem: r,
              ),
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loadData(),
        builder: (context, snapshot) {
          // print("snapshot.connectionstate: ${snapshot.connectionState}");
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              else
                return movies;
          }
        },
      ),
    );
  }
}
