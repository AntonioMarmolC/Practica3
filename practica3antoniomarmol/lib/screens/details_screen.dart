import 'package:flutter/material.dart';
import 'package:movies_app/models/cast.dart';
import 'package:movies_app/models/movie_popular.dart';
import 'package:movies_app/widgets/widgets.dart';

import '../models/movie.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie peli = ModalRoute.of(context)?.settings.arguments as Movie;
    // recogemos instancia de peli para que la podamos enviar como argumento
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topRight,
              colors: <Color>[
                Color.fromARGB(255, 94, 131, 233),
                Color.fromARGB(255, 255, 255, 255)
              ]),
        ),
        child: CustomScrollView(
          slivers: [
            _CustomAppBar(movie: peli),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  _PosterAndTitile(movie: peli),
                  _Overview(
                    movie: peli,
                  ),
                  CastingCards(peli.id),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Movie movie;
  const _CustomAppBar({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Exactament igual que la AppBaer però amb bon comportament davant scroll
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black12,
          padding: const EdgeInsets.only(bottom: 10),
          child: Text(
            movie.title,
            style: TextStyle(fontSize: 16),
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.fullBackPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitile extends StatelessWidget {
  final Movie movie;
  const _PosterAndTitile({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: AssetImage('assets/loading.gif'),
              image: NetworkImage(movie.fullPosterPath),
              height: 150,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Container(
            width: 220,
            child: Column(
              children: [
                Text(
                  movie.title,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.titleLarge,
                  maxLines: 1,
                ),
                Text(
                  movie.originalTitle,
                  overflow: TextOverflow.ellipsis,
                  style: textTheme.subtitle1,
                  maxLines: 1,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
                  child: Row(
                    children: [
                      const Icon(Icons.star,
                          size: 30, color: Color.fromARGB(255, 249, 213, 31)),
                      const SizedBox(width: 5),
                      Text(movie.voteAverage.toString(),
                          style: textTheme.titleMedium),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final Movie movie;
  const _Overview({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}
