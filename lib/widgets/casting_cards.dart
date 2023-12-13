import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/app_models.dart';
import '../providers/app_providers.dart';

class CastingCards extends StatelessWidget {
  const CastingCards({
    required this.movieId,
    super.key,
  });

  final int movieId;

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);


    // Check if we have the cast of the movie in memory
    return FutureBuilder(
        future: moviesProvider.getMovieCast(movieId),
        builder: (_, AsyncSnapshot<List<Cast>> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              constraints: const BoxConstraints(maxWidth: 150),
              width: double.infinity,
              height: 180,
              child: const CupertinoActivityIndicator(),
              

            );
          }

          final List<Cast> cast = snapshot.data!;

          return Container(
              margin: const EdgeInsets.only(bottom: 30),
              width: double.infinity,
              height: 180,
              child: ListView.builder(
                  itemCount: cast.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, int index) =>
                      _CastingCard(castMember: cast[index])));
        });
  }
}

class _CastingCard extends StatelessWidget {
  const _CastingCard({
    super.key,
    required this.castMember,
  });

  final Cast castMember;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 110,
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/loading.gif'),
                image: NetworkImage(castMember.fullProfilePath),
                height: 120,
                width: 110,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              castMember.name,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 2,
            )
          ],
        ));
  }
}
