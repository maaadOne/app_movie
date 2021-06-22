import 'package:app_movie/movies/models/movie.dart';
import 'package:app_movie/movies/widgets/poster_hero.dart';
import 'package:app_movie/src/theme/pallette.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MovieDescription extends StatelessWidget {
  const MovieDescription({Key key, @required this.movie}) : super(key: key);

  final Movie movie;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          movie.title,
          style:
              Theme.of(context).textTheme.headline1.copyWith(color: whiteColor),
        ),
        titleSpacing: 0,
        iconTheme: IconThemeData(color: whiteColor),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  child: Container(
                    height: 150.0,
                    width: 120.0,
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://image.tmdb.org/t/p/original${movie.posterPath}",
                      fit: BoxFit.contain,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                        return PosterHero(
                          poster:
                              "https://image.tmdb.org/t/p/original${movie.posterPath}",
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        );
                      }),
                    );
                  },
                ),
                SizedBox(width: 8.0),
                Flexible(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "${movie.title}",
                          style: Theme.of(context)
                              .textTheme
                              .headline1
                              .copyWith(fontSize: 30),
                        ),
                        SizedBox(height: 5.0),
                        Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.greenAccent,
                          ),
                          child: Text(
                            "Popularity: ${movie.popularity}",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.amberAccent,
                          ),
                          child: Text(
                            "Vote average: ${movie.voteAverage}",
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Text(
                          "Release date: " + movie.releaseDate,
                          style: Theme.of(context)
                              .textTheme
                              .headline2
                              .copyWith(color: darkGreyFontColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Divider(height: 20),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Overview",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  SizedBox(height: 10),
                  Text(
                    movie.overview,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
