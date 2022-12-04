import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_app/providers/movies_provider.dart';
import 'package:movies_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../models/movie.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 30, 108, 245),
        title: const Text('Cartellera'),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                showSearch(
                    context: context,
                    delegate: BuscarPeli(moviesProvider.onDisplayMovie));
              },
              icon: const Icon(Icons.search_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: <Color>[
                  Color.fromARGB(255, 94, 131, 233),
                  Color.fromARGB(255, 255, 255, 255)
                ]),
          ),
          height: 705,
          child: Column(
            children: [
              // Targetes principals
              CardSwiper(movies: moviesProvider.onDisplayMovie),
              // Slider de pel·licules
              MovieSlider(movies: moviesProvider.onDisplayPopular),
              // Poodeu fer la prova d'afegir-ne uns quants, veureu com cada llista és independent
            ],
          ),
        ),
      ),
    );
  }
}

// Este metodo esta hecho con ayuda
// ya que estabamos algunos en llamada
class BuscarPeli extends SearchDelegate {
  final List<Movie> pelis;
  BuscarPeli(this.pelis);

  @override
  List<Widget>? buildActions(BuildContext context) {}

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
        itemCount: pelis.length,
        itemBuilder: (context, index) {
          final suggestion = pelis[index].title;

          return ListTile(
            title: Text(suggestion),
            onTap: () {
              query = suggestion;
              for (int i = 0; i < pelis.length; i++) {
                if (pelis[i].title == query) {
                  Movie pelicula = pelis[i];
                  Navigator.pushNamed(context, 'details', arguments: pelicula);
                }
              }
              showResults(context);
            },
          );
        });
  }
}
