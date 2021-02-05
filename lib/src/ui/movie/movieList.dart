import 'package:flutter/material.dart';
import 'package:movie_provider/src/model/core/searchMovie.dart';
import 'package:movie_provider/src/utils/variable.dart';

import 'movieTile.dart';

class MovieList extends StatelessWidget {
  final SearchMovieModel searchMovieModel;
  MovieList({
    @required this.searchMovieModel,
  });

  final double itemHeight = (cHeight - kToolbarHeight - 24) / 2;
  final double itemWidth = cWidth / 2;
  @override
  Widget build(BuildContext context) {
    int _len = searchMovieModel?.search?.length ?? 0;
    return GridView.count(padding: EdgeInsets.all(0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      childAspectRatio: (itemWidth / itemHeight),
      children: List.generate(_len, (index) {
        return MovieTile(
          movie: searchMovieModel.search[index],
        );
      }),
    );
  }
}
