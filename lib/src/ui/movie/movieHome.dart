import 'dart:math';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_provider/src/model/glitch/noInternet.dart';
import 'package:movie_provider/src/provider/auth_provider.dart';
import 'package:movie_provider/src/provider/movie_provider.dart';
import 'package:movie_provider/src/ui/widgets/popupMenu.dart';
import 'package:movie_provider/src/utils/constant.dart';
import 'package:movie_provider/src/utils/error.dart';
import 'package:movie_provider/src/utils/preferences.dart';
import 'package:movie_provider/src/utils/variable.dart';
import 'package:provider/provider.dart';

import 'movieErrorTile.dart';
import 'movieList.dart';

class ShowAllMovies extends StatefulWidget {
  @override
  _ShowAllMoviesState createState() => _ShowAllMoviesState();
}

class _ShowAllMoviesState extends State<ShowAllMovies> with AfterLayoutMixin {
  var provider;
  Widget movies;
  TextEditingController _searchTextController = TextEditingController();
  String phoneNumber = "";
  String uId = "";
  String title = Constants.appTitle;
  _signOut(BuildContext context) async {
    try {
      Navigator.pop(context);
      Provider.of<AuthProvider>(context, listen: false).signOut();
      setState(() {});
      await Preferences.clearPreference();
    } catch (e) {
      showErrorDialog(context, e.toString());
    }
  }

  getData() async {
    phoneNumber = await Preferences.getPhoneNumber() ?? "";
    uId = await Preferences.getUserId() ?? "";
    setState(() {});
  }

  @override
  void afterFirstLayout(BuildContext context) {
    provider.getSearchedMovies(defaultSearch);

    provider.searchStream.listen((snapshot) {
      snapshot.fold((l) {
        if (l is NoInternetGlitch) {
          Color randomColor = Color.fromRGBO(Random().nextInt(255),
              Random().nextInt(255), Random().nextInt(255), 1);
          movies = MovieErrorTile(randomColor, "Unable to Connect");
        }
      },
          (r) => {
                movies = MovieList(
                  searchMovieModel: r,
                  provider: provider,
                ),
              });
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    provider = Provider.of<MovieProvider>(context, listen: false);

    getData();
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  bool expandSearch = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text(uId),
              accountName: Text(phoneNumber),
              currentAccountPicture: CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),
            InkWell(
              onTap: () {
                _signOut(context);
              },
              child: ListTile(
                title: Text('Sign Out'),
              ),
            )
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          title = Constants.appTitle;
          return provider.getSearchedMovies(defaultSearch);
        },
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: false,
              floating: true,
              expandedHeight: 58,
              title: Text(title),
              actions: [
                expandSearch
                    ? searchFeild()
                    : IconButton(
                        icon: Icon(
                          CupertinoIcons.search,
                        ),
                        color: Colors.white,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          setState(() {
                            expandSearch = !expandSearch;
                          });
                        },
                      ),
                PopupMenuCheck(updateYearFunc: (String year) {
                  provider.getSearchedMovies(
                    title == Constants.appTitle ? defaultSearch : title,
                    year: year,
                  );
                }),
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  Container(
                    child: movies == null
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : movies,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  searchFeild() {
    return Container(
      height: 45.0,
      width: cWidth * 0.7,
      margin: EdgeInsets.only(
        top: 10.0,
        right: 16.0,
        bottom: 5.0,
      ),
      decoration: BoxDecoration(
          color: Color.fromARGB(50, 255, 255, 255),
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(
              CupertinoIcons.search,
            ),
            color: Colors.white,
            highlightColor: Colors.transparent,
            onPressed: () {
              setState(() {
                expandSearch = !expandSearch;
              });
            },
          ),
          Container(
            child: Expanded(
              flex: 1,
              child: TextFormField(
                autofocus: true,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Ex- Star wars",
                  hintStyle: TextStyle(color: Colors.white54),
                ),
                textInputAction: TextInputAction.search,
                onChanged: (value) {
                  print(
                      "_searchTextController.text: ${_searchTextController.text} && $value");

                  searchFunction();
                },
                controller: _searchTextController,
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.check,
            ),
            color: Colors.white,
            highlightColor: Colors.transparent,
            onPressed: () {
              setState(() {
                expandSearch = !expandSearch;
              });
              searchFunction();
              _searchTextController.clear();
            },
          ),
        ],
      ),
    );
  }

  searchFunction() {
    String val = _searchTextController.text.trim();
    if (val == "" || val == null) {
    } else {
      if (val.length > 3) {
        title = val;
        return provider.getSearchedMovies(_searchTextController.text.trim());
      }
    }
  }
}
