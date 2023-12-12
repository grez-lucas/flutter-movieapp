import 'package:flutter/material.dart';

import '../models/app_models.dart';
import '../widgets/app_widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Cambiar luego por una instancia de movie

    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
        body: CustomScrollView(slivers: [
      _CustomAppBar(movie: movie),
      SliverList(
        delegate: SliverChildListDelegate([
          _PosterAndTitle(movie: movie),
          _Overview(movie: movie),
          CastingCards(),
        ]),
      )
    ]));
  }
}

class _Overview extends StatelessWidget {
  const _Overview({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Text(
        movie.overview,
        style: TextStyle(fontSize: 16, height: 1.5, color: Colors.white70),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  const _PosterAndTitle({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: FadeInImage(
                height: 150,
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  movie.originalTitle,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Row(
                  children: [
                    Icon(Icons.star_outline, size: 15, color: Colors.grey),
                    SizedBox(width: 5),
                    Text(
                      movie.voteAverage.toString(),
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                )
              ],
            )
          ],
        ));
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: false,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.zero,
        title: Container(
          padding: EdgeInsets.only(bottom: 10),
          color: Colors.black12,
          alignment: Alignment.bottomCenter,
          width: double.infinity,
          child: Text(
            '${movie.title} (${movie.releaseDate.year})',
            style: const TextStyle(fontSize: 20),
          ),
        ),
        background: FadeInImage(
          fit: BoxFit.cover,
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(
            movie.fullBackdropPath,
          ),
        ),
      ),
    );
  }
}
