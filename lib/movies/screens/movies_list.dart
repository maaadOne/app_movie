import 'package:app_movie/movies/bloc/movie_bloc.dart';
import 'package:app_movie/movies/widgets/bottom_loader.dart';
import 'package:app_movie/src/theme/pallette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'movie_list_item.dart';

class MoviesList extends StatefulWidget {
  @override
  _MoviesListState createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  final _scrollController = ScrollController();
  MovieBloc _movieBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _movieBloc = context.read<MovieBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieBloc, MovieState>(
      builder: (context, state) {
        switch (state.status) {
          case MovieStatus.failure:
            return const Center(child: Text('Failed to fetch movies'));
          case MovieStatus.success:
            if (state.movies.isEmpty) {
              return const Center(child: Text('No more movies'));
            }
            return Scrollbar(
              thickness: 3,
              child: RefreshIndicator(
                onRefresh: _onRefresh,
                child: ListView.separated(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
                  itemBuilder: (BuildContext context, int index) {
                    return index >= state.movies.length
                        ? BottomLoader()
                        : MovieListItem(movie: state.movies[index]);
                  },
                  itemCount: state.hasReachedMax
                      ? state.movies.length
                      : state.movies.length + 1,
                  controller: _scrollController,
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(height: 10.0),
                ),
              ),
            );
          default:
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
                color: azureColor,
              ),
            );
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) _movieBloc.add(MovieFetched());
  }

  Future<void> _onRefresh() async {
    _movieBloc.add(MovieRefresh());
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
