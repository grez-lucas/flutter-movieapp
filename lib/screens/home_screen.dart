import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/app_providers.dart';
import '../widgets/app_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Go to the widget tree, search for the movie provider and get the instance
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: true);


    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search_outlined),
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(children: [
            CardSwiper(size: size, movies: moviesProvider.onDisplayMovies),
            MovieSlider(size: size, movies: moviesProvider.popularMovies),
          ]),
        ),
      ),
    );
  }
}
