import 'dart:async';
import 'dart:html';

import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fittness_api/home_page.dart';
import 'package:fittness_api/model.dart';
import 'package:fittness_api/widget.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ThirdPage extends StatefulWidget {
  ThirdPage({Key? key, this.exercise, this.second}) : super(key: key);

  final Exercise? exercise;
  int? second;

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  AudioPlayer audioPlayer = AudioPlayer();
  AudioCache audioCache = AudioCache();
  bool isPlaying = false;
  bool isComplete = false;
  int startSound = 0;
  late Timer timer;
  String musicPath = "assets/music.mp3";

  playAudio() async {
    // await audioCache.load(musicPath);
    // await audioPlayer.play(AssetSource(musicPath));
  }

  @override
  void initState() {
    // TODO: implement initState
    // playAudio();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      var x = widget.second! - 1;

      print("${x}");

      if (timer.tick == widget.second) {
        timer.cancel();
        setState(() {
          //isPlaying = true;
          playAudio();
          showToast("WorkOut Succesfull");
          Future.delayed(Duration(seconds: 4), () {
            Navigator.of(context).pop();
          });
        });
      }
      setState(() {
        startSound = timer.tick;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 30,
            color: Colors.deepPurple,
          ),
        ),
        title: GradientText(
          'Fittness App',
          style: const TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
          colors: const [
            Colors.blue,
            Colors.pink,
            Colors.green,
          ],
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.home,
              size: 30,
              color: Colors.deepPurple,
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Center(
            child: CachedNetworkImage(
              width: double.infinity,
              // height: double.infinity,
              imageUrl: "${widget.exercise!.gif}",
              fit: BoxFit.cover,
              placeholder: (context, url) => spinkit,
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          Positioned(
              top: 80,
              left: 20,
              right: 20,
              child: Center(
                  child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.lime),
                      child: Center(
                          child: Text(
                        "$startSound",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )))))
        ],
      ),
    );
  }
}
