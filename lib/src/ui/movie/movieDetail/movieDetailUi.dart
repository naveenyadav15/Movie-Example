import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_provider/src/model/core/movie.dart';
import 'package:movie_provider/src/ui/widgets/common.dart';
import 'package:movie_provider/src/utils/variable.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class MovieDetailUi extends StatelessWidget {
  final MovieModel movieItem;
  MovieDetailUi({@required this.movieItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Flexible(
                flex: 7,
                child: Container(
                  // height: cHeight * 0.7,
                  color: Colors.black.withOpacity(0.4),
                  child: Stack(
                    children: [
                      Container(
                        height: cHeight * 0.7, width: cWidth,
                        child: CachedNetworkImage(
                          imageUrl: movieItem.poster,
                          fit: BoxFit.fill,
                        ),
                        // cacheImage(movieItem.poster,
                        // height: cHeight * 0.65, width: cWidth,),
                      ),
                      Container(
                        height: cHeight * 0.7,
                        width: cWidth,
                        color: Colors.black.withOpacity(0.2),
                      ),
                      topAppBar(context),
                      bottomTimeContainer(),
                    ],
                  ),
                ),
              ),
              bottomContainer(context),
            ],
          ),
          Container(
            padding: EdgeInsets.only(top: cHeight * 0.665, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  heroTag: "play${movieItem.imdbId}",
                  onPressed: () {},
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Icon(
                    Icons.play_arrow_rounded,
                  ),
                ),
                SizedBox(
                  width: cWidth * 0.04,
                ),
                FloatingActionButton(
                  heroTag: "download${movieItem.imdbId}",
                  onPressed: () {},
                  backgroundColor: Theme.of(context).primaryColor,
                  child: Icon(
                    Icons.download_rounded,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  topAppBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.share,
                  size: 20,
                  color: Colors.white,
                ),
                onPressed: () {},
                // onPressed: () => Navigator.pop(context),
              ),
              IconButton(
                icon: Icon(
                  CupertinoIcons.heart_fill,
                  size: 20,
                  color: Colors.white,
                ),
                onPressed: () {},
                // onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  bottomTimeContainer() {
    bool ratingA = true;
    double rating = 0.0;
    try {
      rating = double.parse(movieItem?.imdbRating);

      rating /= 2.0;
    } catch (err) {
      print("error: $err");
      ratingA = false;
    }
    print("rating is: $rating");
    return Container(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          width: cWidth,
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              !ratingA
                  ? Container(
                      child: MPText(
                        text: "Rating: N/A",
                        color: Colors.white,
                        textAlign: TextAlign.left,
                      ),
                    )
                  : Row(
                      children: [
                        SmoothStarRating(
                          allowHalfRating: true,
                          onRated: (v) {},
                          starCount: 5,
                          rating: rating,
                          isReadOnly: true,
                          color: Colors.amber,
                          borderColor: Colors.amber,
                        ),
                        MPText(
                          text: movieItem?.ratings[0]?.value ?? "" + " ",
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
              MPText(
                text: movieItem.title,
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.left,
              ),
              Row(
                children: [
                  MPText(
                    text: movieItem.genre.split(",")[0] + "  ",
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.calendar_today,
                    size: 14,
                    color: Colors.white,
                  ),
                  MPText(
                    text: movieItem.year + "  ",
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.access_time_sharp,
                    size: 14,
                    color: Colors.white,
                  ),
                  MPText(
                    text: movieItem.runtime + "  ",
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bottomContainer(BuildContext context) {
    return Flexible(
      flex: 3,
      child: Container(
        child: Stack(
          children: [
            Container(
              width: cWidth,
              color: Colors.black.withOpacity(0.6),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.remove_red_eye_rounded,
                        color: Colors.white.withOpacity(0.7),
                      ),
                      SizedBox(
                        width: cWidth * 0.04,
                      ),
                      FlatButton(
                        onPressed: () {},
                        color: Colors.white,
                        child: MPText(
                          text: "Reviews",
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        width: cWidth * 0.04,
                      ),
                      FlatButton(
                        onPressed: () {},
                        color: Theme.of(context).primaryColor,
                        child: Row(
                          children: [
                            Icon(
                              Icons.video_call_rounded,
                              color: Colors.white,
                            ),
                            MPText(
                              text: "Trailer",
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: cHeight * 0.02,
                  ),
                  MPText(
                    text: movieItem.plot,
                    maxLines: 15,
                    fontSize: 16,
                    color: Colors.white,
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: cHeight * 0.04,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: Colors.white,
                          ),
                          child: MPText(
                            text: "CC",
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          width: cWidth * 0.08,
                        ),
                        MPText(
                          text: movieItem.language,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
