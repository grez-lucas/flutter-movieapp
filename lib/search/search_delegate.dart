import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/app_models.dart';
import '../providers/app_providers.dart';

class MovieSearchDelegate extends SearchDelegate<Movie> {
  Timer? _debounceTimer;
  final Duration _debounceTime = const Duration(milliseconds: 500);

  @override
  String? get searchFieldLabel => 'Search movies';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context));
  }

  @override
  Widget buildResults(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    return FutureBuilder(
        future: moviesProvider.searchMovies(query),
        builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final List<Movie> movies = snapshot.data!;

          return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (_, int index) =>
                  _MovieResultItem(movie: movies[index]));
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Cancel the previous timer if it's still running
    _debounceTimer?.cancel();

    // Start a new timer
    _debounceTimer = Timer(_debounceTime, () {
      // Call the provider method here
    });

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    if (query.isEmpty) {
      return Container(
        child: const Center(
          child: Icon(Icons.movie_creation_outlined,
              size: 130, color: Colors.white),
        ),
      );
    }

    return FutureBuilder(
        future: moviesProvider.searchMovies(query),
        builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final List<Movie> movies = snapshot.data!;

          return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (_, int index) => _MovieItem(movie: movies[index]));
        });
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}

class _MovieItem extends StatelessWidget {
  const _MovieItem({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FadeInImage(
        placeholder: const AssetImage('assets/no-image.jpg'),
        image: NetworkImage(movie.fullPosterImg),
        width: 50,
        fit: BoxFit.contain,
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.white),
      title: Text(
        movie.title,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(movie.releaseDate.year.toString(),
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.grey)),
      onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
    );
  }
}

class _MovieResultItem extends StatelessWidget {
  const _MovieResultItem({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(2),
      style: ListTileStyle.list,
      leading: FadeInImage(
        placeholder: const AssetImage('assets/no-image.jpg'),
        image: NetworkImage(movie.fullPosterImg),
        width: 100,
        fit: BoxFit.contain,
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.white),
      title: Text(
        movie.title,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontSize: 15),
      ),
      subtitle: Text(movie.releaseDate.year.toString(),
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.grey)),
      onTap: () => Navigator.pushNamed(context, 'details', arguments: movie),
    );
  }
}
