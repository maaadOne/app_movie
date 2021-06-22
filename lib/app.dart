import 'package:flutter/material.dart';
import 'movies/movies.dart';
import 'src/theme/theme.dart';

class App extends MaterialApp {
  App()
      : super(
          debugShowCheckedModeBanner: false,
          home: MoviesPage(),
          theme: appLightTheme(),
        );
}
