import 'package:app_movie/src/theme/pallette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'bloc/movie_bloc.dart';
import 'screens/movies_list.dart';

class MoviesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Popular Movies',
          style:
              Theme.of(context).textTheme.headline1.copyWith(color: whiteColor),
        ),
      ),
      body: BlocProvider(
        create: (_) => MovieBloc(httpClient: http.Client())
          ..add(
            MovieFetched(),
          ),
        child: MoviesList(),
      ),
    );
  }
}
