import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../models/app_models.dart';

class CardSwiper extends StatelessWidget {
  const CardSwiper({
    super.key,
    required this.size,
    required this.movies,
  });

  final Size size;
  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: size.height * 0.5,
        child: Swiper(
            itemCount: movies.length,
            layout: SwiperLayout.STACK,
            itemWidth: size.width * 0.6,
            itemHeight: size.height * 0.4,
            itemBuilder: (BuildContext context, int index) {
              
              final Movie movie = movies[index];

              return ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage(
                  placeholder: const AssetImage('assets/loading.gif'),
                  image: NetworkImage(movie.fullPosterImg),
                  fit: BoxFit.cover,
                ),
              );
            }));
  }
}
