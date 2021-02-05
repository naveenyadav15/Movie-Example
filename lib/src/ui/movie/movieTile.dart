import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_provider/src/model/core/searchMovie.dart';
import 'package:movie_provider/src/provider/movie_provider.dart';
import 'package:movie_provider/src/utils/variable.dart';
import 'package:provider/provider.dart';

import 'movieDetail/movieDetailPage.dart';

class MovieTile extends StatefulWidget {
  final Search movie;
  MovieTile({@required this.movie, });

  @override
  _MovieTileState createState() => _MovieTileState();
}

class _MovieTileState extends State<MovieTile> {
  bool _showErrorIcon = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => MovieDetailPage(
                provider: Provider.of<MovieProvider>(context, listen: false),
                imdbId: widget.movie.imdbId,
              ),
            ),
          );
        },
        child: Container(
          color: Colors.white,
          child: Stack(
            children: [
              _showErrorIcon
                  ? Center(
                      child: Icon(
                      Icons.error,
                    ))
                  : Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.movie.poster),
                          fit: BoxFit.cover,
                          onError: (e, stackTrace) {
                            print('error $e');
                            setState(() {
                              _showErrorIcon = true;
                            });
                          },
                        ),
                      ),
                    ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 30,
                  width: cWidth,
                  color: Colors.black.withOpacity(0.5),
                  child: Stack(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Icon(
                              CupertinoIcons.heart_fill,
                              color: Colors.white,
                              size: 18,
                            ),
                            // Text(
                            //   "  ${movie.imdbRating}",
                            //   style: TextStyle(color: Colors.white),
                            // ),
                            // Text(
                            //   "*",
                            //   style: TextStyle(
                            //     color: Colors.white,
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "  ${widget.movie.year}  ",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
