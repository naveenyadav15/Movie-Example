// To parse this JSON data, do
//
//     final searchMovieModel = searchMovieModelFromMap(jsonString);

import 'dart:convert';

SearchMovieModel searchMovieModelFromMap(String str) => SearchMovieModel.fromMap(json.decode(str));

String searchMovieModelToMap(SearchMovieModel data) => json.encode(data.toMap());

class SearchMovieModel {
    SearchMovieModel({
        this.search,
        this.totalResults,
        this.response,
    });

    final List<Search> search;
    final String totalResults;
    final String response;

    factory SearchMovieModel.fromMap(Map<String, dynamic> json) => SearchMovieModel(
        search: json["Search"] == null ? null : List<Search>.from(json["Search"].map((x) => Search.fromMap(x))),
        totalResults: json["totalResults"] == null ? null : json["totalResults"],
        response: json["Response"] == null ? null : json["Response"],
    );

    Map<String, dynamic> toMap() => {
        "Search": search == null ? null : List<dynamic>.from(search.map((x) => x.toMap())),
        "totalResults": totalResults == null ? null : totalResults,
        "Response": response == null ? null : response,
    };
}

class Search {
    Search({
        this.title,
        this.year,
        this.imdbId,
        this.type,
        this.poster,
    });

    final String title;
    final String year;
    final String imdbId;
    final Type type;
    final String poster;

    factory Search.fromMap(Map<String, dynamic> json) => Search(
        title: json["Title"] == null ? null : json["Title"],
        year: json["Year"] == null ? null : json["Year"],
        imdbId: json["imdbID"] == null ? null : json["imdbID"],
        type: json["Type"] == null ? null : typeValues.map[json["Type"]],
        poster: json["Poster"] == null ? null : json["Poster"],
    );

    Map<String, dynamic> toMap() => {
        "Title": title == null ? null : title,
        "Year": year == null ? null : year,
        "imdbID": imdbId == null ? null : imdbId,
        "Type": type == null ? null : typeValues.reverse[type],
        "Poster": poster == null ? null : poster,
    };
}

enum Type { MOVIE, SERIES }

final typeValues = EnumValues({
    "movie": Type.MOVIE,
    "series": Type.SERIES
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
