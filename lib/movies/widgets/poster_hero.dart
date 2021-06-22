import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PosterHero extends StatelessWidget {
  const PosterHero({
    Key key,
    @required this.poster,
    @required this.onTap,
  }) : super(key: key);

  final String poster;
  final VoidCallback onTap;

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Hero(
          tag: poster,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: CachedNetworkImage(
                imageUrl: poster,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
