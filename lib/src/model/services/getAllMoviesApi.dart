import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:movie_provider/src/utils/constant.dart';

class AllMoviesApi {
  String endpoint = "www.omdbapi.com";
  Future<Either<Exception, String>> getMovieById(String imdbId) async {
    try {
      final queryParameters = {
        "apikey": Constants.API_KEY, // api key
        "i":imdbId,
        //  Constants.IMDB_ID // IMDB id
      };
      final uri = Uri.http(endpoint, "", queryParameters);
      final response = await http.get(uri);
      return Right(response.body);
    } catch (e) {
      return (Left(e));
    }
  }

  Future<Either<Exception, String>> getSearchedMovies(String value,{String year}) async {
    try {
      final queryParameters = {
        "apikey": Constants.API_KEY, // api key
        "s": value,
        "y": year,
      };
      final uri = Uri.http(endpoint, "", queryParameters);
      final response = await http.get(uri);
      return Right(response.body);
    } catch (e) {
      return (Left(e));
    }
  }
}
