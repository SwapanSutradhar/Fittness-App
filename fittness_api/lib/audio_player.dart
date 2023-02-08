import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class MyAudioPlayer extends StatefulWidget {
  const MyAudioPlayer({super.key});

  @override
  State<MyAudioPlayer> createState() => _MyAudioPlayerState();
}

class _MyAudioPlayerState extends State<MyAudioPlayer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: ElevatedButton(onPressed: (){
        final player=AudioCache();
        player.play('happyday1.mp3');
      }, child: Text('Click Me')),),
    );
  }
}