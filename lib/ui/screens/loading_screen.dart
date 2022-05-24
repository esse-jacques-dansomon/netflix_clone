import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:netflix_clone/ui/screens/home_screen.dart';
import 'package:provider/provider.dart';

import '../../repositories/data_reposirory.dart';
import '../../shared/constants.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  initState(){
    super.initState();
    initData();
  }

  Future<void> initData() async {
    super.initState();
    final dataProvider = Provider.of<DataRepository>(context, listen: false);
    await dataProvider.initData();
    Navigator.pushReplacement(
        context, MaterialPageRoute(
        builder: (context){
          return const HomeScreen();
        }
    ));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: gjBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/netflix.png"),
          const SpinKitCircle(
            size: 38,
            color: Colors.red,
            duration: Duration(seconds: 4),
          ),
        ],
      ),
    );
  }
}
