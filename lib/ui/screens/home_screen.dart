import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix_clone/repositories/data_reposirory.dart';
import 'package:netflix_clone/ui/screens/detail_screen.dart';
import 'package:provider/provider.dart';
import '../../shared/constants.dart';
import '../widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {
  //données externes
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
  }

  void getMovies()  async {

  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataRepository>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: gjBackgroundColor,
        appBar: AppBar(
          backgroundColor: gjBackgroundColor,
          leading: Image.asset("assets/images/Logo.png"),
        ),
        body: ListView(
          children: [
            SizedBox(
                height: 500,
                width: double.maxFinite,
                child: dataProvider.popularMovies.isEmpty
                    ? const Center(
                        child: Text("Indisponibilités du film"),
                      )
                    : MovieCard(movie:dataProvider.popularMovies[0]),
                    ),
            const SizedBox(
              height: 15
            ),
            //Text Film text tendances Actuelles
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                'Tendances Actuelles',
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            const SizedBox(
                height: 15
            ),
            SizedBox(
                height: 187,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: dataProvider.popularMovies.isEmpty ? 0 : dataProvider.popularMovies .length,
                  itemBuilder: ((context, index) => InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(
                          builder: (context){
                            return MovieDetailsScreen(movie: dataProvider.popularMovies[index]);
                      }
                      ), );
                    },
                    child: Container(
                          width: 125,
                          margin: const EdgeInsets.only(right: 10),
                          child: Center(child: Image.network(dataProvider.popularMovies[index].posterUrl(),
                        fit:BoxFit.cover,
                      ),),
                        ),
                  )),
                )),
            const SizedBox(
              height: 15,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                "Actuellement au cinéma",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
                height: 375,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: dataProvider.nowPlayings  == null ? 0 : dataProvider.nowPlayings .length,
                  itemBuilder: ((context, index) => InkWell(
                    onTap: (){
                      Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context){
                              return MovieDetailsScreen(movie: dataProvider.nowPlayings[index]);
                            }
                        ), );
                    },
                    child: Container(
                          width: 250,
                          margin: const EdgeInsets.only(right: 10),
                          child: Center(child: Image.network(dataProvider.nowPlayings[index].posterUrl(),
                        fit:BoxFit.cover,
                      ),),
                        ),
                  )),
                )),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                "Ils arrivent bientot",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
                height: 187,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: dataProvider.comingSoon == null ? 0 : dataProvider.comingSoon.length,
                  itemBuilder: ((context, index) => InkWell(
                    onTap: (){
                      Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context){
                              return MovieDetailsScreen(movie: dataProvider.comingSoon[index]);
                            }
                        ), );
                    },
                    child: Container(
                          width: 125,
                          margin: const EdgeInsets.only(right: 10),
                          child: Center(child:
                          Image.network(dataProvider.popularMovies[index].posterUrl(),
                            fit:BoxFit.cover,
                          ),

                          ),
                        ),
                  )),
                )),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                "Animations",
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
                height: 187,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: dataProvider.topRated  == null ? 0 : dataProvider.topRated.length,
                  itemBuilder: ((context, index) => InkWell(
                    onTap: (){
                      Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context){
                              return MovieDetailsScreen(movie: dataProvider.topRated[index]);
                            }
                        ), );
                    },
                    child: Container(
                      width: 125,
                      margin: const EdgeInsets.only(right: 10),
                      child: Center(child:
                      Image.network(dataProvider.topRated[index].posterUrl(),
                        fit:BoxFit.cover ),

                      ),
                    ),
                  )),
                )),
          ],
        ),
      ),
    );
  }
}
