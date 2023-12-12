import 'package:flutter/material.dart';

import '../models/app_models.dart';

class MovieSlider extends StatelessWidget {
  const MovieSlider({
    super.key,
    required this.size,
    required this.movies,
  });

  final Size size;
  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: size.height * 0.4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text("Popular Movies",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 40),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: movies.length,
                    itemBuilder: (_, int index) =>  _MoviePoster(movie: movies[index])),
              ),
            )
          ],
        ));
  }
}

class _MoviePoster extends StatelessWidget {
  const _MoviePoster({
    super.key,
    required this.movie,
  });

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 130,
        height: 190,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, 'details', arguments: 'movie-1'),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FadeInImage(
                  height: MediaQuery.of(context).size.height * 0.25,
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movie.fullPosterImg),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              movie.title,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            )
          ],
        ));
  }
}
