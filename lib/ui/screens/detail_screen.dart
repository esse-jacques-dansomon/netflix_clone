import 'package:flutter/material.dart';
import 'package:netflix_clone/models/DetailsMovie.dart';
import 'package:netflix_clone/models/Image.dart';
import 'package:netflix_clone/models/movie.dart';
import 'package:netflix_clone/ui/screens/videos_movies.dart';
import 'package:netflix_clone/ui/widgets/movie_card.dart';
import 'package:provider/provider.dart';

import '../../models/Acteur.dart';
import '../../repositories/data_reposirory.dart';
import '../../shared/constants.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;
  const MovieDetailsScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataRepository>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: gjBackgroundColor,

        appBar: AppBar(
          backgroundColor: gjBackgroundColor,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(
                  height: 392,
                  width: double.infinity,
                  child: MovieCard(movie: movie),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 15, bottom: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(movie.title.toUpperCase(), style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w400),),
                      const SizedBox(height: 5),
                      Text('Genres : Drames, Aventures, Amour, Guerre ${movie.id}', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),),
                      const SizedBox(height: 5),
                      FutureBuilder<DetailsMovie>(
                        future: dataProvider.getDetailsMovie( movieId: movie.id),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return  Row(
                              children: [
                                Container(
                                  height: 20,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Center(child: Text('${snapshot.data!.releaseDate.year}', style: TextStyle(fontSize: 16, color: Colors.white),)),
                                ),
                                const SizedBox(width: 10),
                                Text('Recommande a ${snapshot.data!.voteAverage} sur 10', style: TextStyle(fontSize: 16, color: Colors.white),),
                              ],
                            );
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                      const SizedBox(height: 15),
                      ElevatedButton(onPressed: () {
                        showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            isScrollControlled: true,
                            isDismissible: true,
                            context: context,
                            builder: (context) {
                              return VideoApp();
                            });
                      },
                        style:  ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white),
                          foregroundColor: MaterialStateProperty.all(Colors.black),
                          elevation: MaterialStateProperty.all(0),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),)),), child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(Icons.play_arrow, color: Colors.black,),
                            SizedBox(width: 10),
                            Text('Lecture', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      ElevatedButton(onPressed: () {  },
                        style:  ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.grey),
                          foregroundColor: MaterialStateProperty.all(Colors.white),
                          elevation: MaterialStateProperty.all(0),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),)),), child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: const [
                            Icon(Icons.download),
                            SizedBox(width: 10),
                            Text('Telecharger vide0', style: TextStyle( fontWeight: FontWeight.bold, fontSize: 18),),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text('Synopsis :'.toUpperCase(), style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),),
                      const SizedBox(height: 5),
                      Text(movie.description, style: const TextStyle(fontSize: 16, color: Colors.white),),
                      const SizedBox(height: 15),
                      Text('CASTING :'.toUpperCase(), style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),),
                      const SizedBox(height: 15),
                      ConstrainedBox(constraints: const BoxConstraints(maxHeight: 300),
                        child:  FutureBuilder<List<Acteur>>(
                          future: dataProvider.getActeursByMovie(movieId: movie.id),
                          builder: (context, snapshot){
                            if (snapshot.data != null){
                              return ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only( right: 10),
                                    child: Card(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 200.5,
                                            width: 150,
                                            child: Image.network(snapshot.data![index].profilePath, fit: BoxFit.cover,),
                                          ),
                                          SizedBox(
                                            width: 150,
                                            child: Padding(padding: const EdgeInsets.only(left:10),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children:  [
                                                  SizedBox(height: 4),
                                                  Text(snapshot.data![index].name, style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold ),),
                                                  Text(snapshot.data![index].character, style: TextStyle(fontSize: 15,fontWeight: FontWeight.w400 ), maxLines: 10,),

                                                ],
                                              ),),
                                          )

                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else if (snapshot.hasError) {
                              return const Text('erreur', style: TextStyle(fontSize: 16, color: Colors.white),);
                            }
                            return const CircularProgressIndicator();

                          },
                        ),
                      ),
                      FutureBuilder<List<ImageGalerie>>(
                          future: dataProvider.getImagesByMovie(movieId: movie.id),
                          builder: (context, snapshot){
                            if (snapshot.hasData && snapshot.data!.isNotEmpty){
                              return  ConstrainedBox(
                                  constraints: const BoxConstraints(maxHeight: 370),
                                  child: Column(
                                      children: [
                                        const SizedBox(height: 15),
                                        Text('GALERIE :'.toUpperCase(), style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),),
                                        const SizedBox(height: 15),
                                        Expanded(child:  ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: snapshot.data?.length ?? 1,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.only( right: 10),
                                              child: Image.network(movie.posterUrl(), fit: BoxFit.cover,),
                                            );
                                          },
                                        ))
                                      ]
                                  )


                              );
                            }
                            else if(snapshot.data?.length == 0){
                              return const Padding(
                                padding:  EdgeInsets.all(8.0),
                                child: Center(child: Text('No Galerie', style: TextStyle(color: Colors.white, fontSize: 20),)),
                              );
                            }
                            else if (snapshot.hasError) {
                              return const Text('erreur', style: TextStyle(fontSize: 16, color: Colors.white),);
                            }
                            return const CircularProgressIndicator();
                          }
                      ),

                    ],
                  ),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
