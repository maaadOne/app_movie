import 'dart:convert';

import 'package:app_movie/movies/models/movie.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
part 'movie_event.dart';
part 'movie_state.dart';

// const _postLimit = 20;
const _apikey = "fb629bbdc120af68330e42cf82afb65f";

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final http.Client httpClient;

  MovieBloc({@required this.httpClient}) : super(const MovieState());

  @override
  Stream<Transition<MovieEvent, MovieState>> transformEvents(
    Stream<MovieEvent> events,
    TransitionFunction<MovieEvent, MovieState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<MovieState> mapEventToState(MovieEvent event) async* {
    if (event is MovieFetched) {
      yield await _mapPostFetchedToState(state);
    } else if (event is MovieRefresh) {
      yield await _mapMoviesRefreshToState(state);
    }
  }

  Future<MovieState> _mapPostFetchedToState(MovieState state) async {
    if (state.hasReachedMax) return state;
    try {
      if (state.status == MovieStatus.initial) {
        final movies = await _fetchMovies();
        return state.copyWith(
          status: MovieStatus.success,
          movies: movies,
          hasReachedMax: false,
        );
      }
      print(state.movies.length ~/ 20);
      final movies = await _fetchMovies((state.movies.length ~/ 20) + 1);
      return movies.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: MovieStatus.success,
              movies: List.of(state.movies)..addAll(movies),
              hasReachedMax: false,
            );
    } on Exception {
      return state.copyWith(status: MovieStatus.failure);
    }
  }

  Future<MovieState> _mapMoviesRefreshToState(MovieState state) async {
    if (state.hasReachedMax) return state;
    try {
      final movies = await _fetchMovies();
      return state.copyWith(
        status: MovieStatus.success,
        movies: movies,
        hasReachedMax: false,
      );
    } on Exception {
      return state.copyWith(status: MovieStatus.failure);
    }
  }

  Future<List<Movie>> _fetchMovies([int startIndex = 1]) async {
    final response = await httpClient.get(
      Uri.https(
        'api.themoviedb.org',
        '/3/movie/popular',
        <String, String>{'api_key': _apikey, 'page': '$startIndex'},
      ),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final jBody = body["results"] as List;
      return jBody.map((dynamic json) {
        final t = json["genre_ids"] as List;
        return Movie(
          adult: json["adult"] as bool,
          backdropPath: json["backdrop_path"] as String,
          genreIds: t.map((i) {
            return i.toInt() as int;
          }).toList() as List<int>,
          id: json["id"] as int,
          originalLanguage: json["original_language"] as String,
          originalTitle: json["original_title"] as String,
          overview: json["overview"] as String,
          popularity: json["popularity"].toDouble() as double,
          posterPath: json["poster_path"] as String,
          releaseDate: json["release_date"] as String,
          title: json["title"] as String,
          video: json["video"] as bool,
          voteAverage: json["vote_average"].toDouble() as double,
          voteCount: json["vote_count"] as int,
        );
      }).toList();
    } else if (response.statusCode == 422) {
      return List.empty();
    }
    throw Exception('error fetching posts');
  }
}
