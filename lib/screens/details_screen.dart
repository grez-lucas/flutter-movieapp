import 'package:flutter/material.dart';

import '../widgets/app_widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Cambiar luego por una instancia de movie

    final String movie =
        ModalRoute.of(context)!.settings.arguments.toString() ?? 'no-movie';

    return Scaffold(
        body: CustomScrollView(slivers: [
      _CustomAppBar(),
      SliverList(
        delegate: SliverChildListDelegate([
          _PosterAndTitle(),
          _Overview(),
          CastingCards(),
        ]),
      )
    ]));
  }
}

class _Overview extends StatelessWidget {
  const _Overview({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
          style: TextStyle(fontSize: 16, height: 1.5, color: Colors.white70),
          "Magna do qui irure aliqua exercitation. Laboris tempor magna anim eu nulla pariatur eu velit. Est mollit pariatur occaecat voluptate officia Lorem. Cillum ullamco occaecat exercitation adipisicing do proident et laborum ullamco dolor tempor magna mollit duis. Exercitation velit esse commodo ad duis esse officia tempor aliquip pariatur et et labore. Occaecat aliqua qui adipisicing non tempor in nostrud. Aliquip exercitation minim eu elit ad aute veniam."),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  const _PosterAndTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: const FadeInImage(
                height: 150,
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage('https://picsum.photos/300/400'),
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 20),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'movie.title',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  'movie.originalTitle',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Row(
                  children: [
                    Icon(Icons.star_outline, size: 15, color: Colors.grey),
                    SizedBox(width: 5),
                    Text(
                      'movie.voteAverage',
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
  });

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
          child: const Text(
            'Title ',
            style: const TextStyle(fontSize: 20),
          ),
        ),
        background: const FadeInImage(
          fit: BoxFit.cover,
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(
            'https://picsum.photos/500/300',
          ),
        ),
      ),
    );
  }
}