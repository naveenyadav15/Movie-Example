import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:movie_provider/src/model/core/movie.dart';
import 'package:movie_provider/src/model/core/searchMovie.dart';
import 'package:movie_provider/src/model/glitch/glitch.dart';
import 'package:movie_provider/src/model/glitch/noInternet.dart';
import 'package:movie_provider/src/model/services/getAllMoviesApi.dart';

class MovieHelper {
  final api = AllMoviesApi();
  Future<Either<Glitch, MovieModel>> getMovieById(String imdbId,) async {
    final apiResult = await api.getMovieById(imdbId);
    return apiResult.fold((l) {
      // There can be many types of error, but for simplicity, we are going
      // to assume only NoInternetGlitch
      return Left(NoInternetGlitch());
    }, (r) {
      final movie = MovieModel.fromMap(jsonDecode(r));
      return Right(movie);
    });
  }

  Future<Either<Glitch, SearchMovieModel>> getSearchedMovies(String value,{String year} ) async {
    final apiResult = await api.getSearchedMovies(value,year: year);
    return apiResult.fold((l) {
      
      return Left(NoInternetGlitch());
    }, (r) {
      final movieList = SearchMovieModel.fromMap(jsonDecode(r));
      return Right(movieList);
    });
  }
}
