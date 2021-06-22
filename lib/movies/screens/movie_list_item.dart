import 'package:app_movie/movies/models/movie.dart';
import 'package:app_movie/src/theme/pallette.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'movie_description.dart';

class MovieListItem extends StatelessWidget {
  const MovieListItem({Key key, this.movie}) : super(key: key);

  final Movie movie;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(builder: (BuildContext context) {
            return MovieDescription(movie: movie);
          }),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 3,
              offset: Offset(1, 1),
            ),
          ],
          color: Colors.white,
        ),
        child: Row(
          children: [
            Container(
              height: 100.0,
              width: 75.0,
              child: CachedNetworkImage(
                imageUrl:
                    "https://image.tmdb.org/t/p/original${movie.posterPath}",
                fit: BoxFit.contain,
                placeholder: (context, img) {
                  return Container(
                    height: 100.0,
                    width: 75.0,
                    child: Image.asset("assets/images/placeholder.jpg"),
                  );
                },
              ),
            ),
            SizedBox(width: 8.0),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${movie.title}",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  SizedBox(height: 5.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                      SizedBox(width: 20.0),
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
                    ],
                  ),
                  SizedBox(height: 5.0),
                  Text(
                    "Release date: ${movie.releaseDate}",
                    style: Theme.of(context)
                        .textTheme
                        .headline2
                        .copyWith(color: darkGreyFontColor),
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
