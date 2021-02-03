import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_provider/src/provider/auth_provider.dart';
import 'package:movie_provider/src/provider/movie_provider.dart';
import 'package:movie_provider/src/ui/movie/movieHome.dart';
import 'package:movie_provider/src/utils/error.dart';
import 'package:movie_provider/src/utils/preferences.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const routeArgs = '/home-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider.value(
        value: MovieProvider(),
        builder: (context, _) => ShowAllMovies(),
      ),
    );
  }
}
