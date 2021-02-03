import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:movie_provider/src/model/core/movie.dart';
import 'package:movie_provider/src/model/core/searchMovie.dart';
import 'package:movie_provider/src/model/glitch/glitch.dart';
import 'package:movie_provider/src/model/helper/movieHelper.dart';

class MovieProvider extends ChangeNotifier {
  final _helper = MovieHelper();
  final _streamSearchController =
      StreamController<Either<Glitch, SearchMovieModel>>();
  Stream<Either<Glitch, SearchMovieModel>> get searchStream {
    return _streamSearchController.stream;
  }

  getMovieById(String imdbId) async {
    return await _helper.getMovieById(imdbId);
  }

  getSearchedMovies(String value, {String year}) async {
    final movieHelperResult = await _helper.getSearchedMovies(value,year: year);
    _streamSearchController.add(movieHelperResult);
  }
}
