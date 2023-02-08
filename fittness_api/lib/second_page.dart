import 'package:fittness_api/model.dart';
import 'package:fittness_api/third_page.dart';
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:audioplayers/audioplayers.dart';


class SecondPage extends StatefulWidget {
  SecondPage({Key? key, this.exercise}) : super(key: key);

  final Exercise? exercise;
  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  int second = 1;
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
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Image.network(
              "${widget.exercise!.thumbnail}",
              height: double.infinity,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SleekCircularSlider(
                  min: 1,
                  max: 10,
                  initialValue: second.toDouble(),
                  onChange: (double value) {
                    setState(() {
                      second = value.toInt();
                      print("second is $second");
                    });
                    // callback providing a value while its being changed (with a pan gesture)
                  },
                  innerWidget: (double value) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("${second.toStringAsFixed(0)}",
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.deepOrange,
                                  fontWeight: FontWeight.bold)),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: ElevatedButton(
                              onPressed: () {
                                print("$second");
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ThirdPage(
                                          exercise: widget.exercise,
                                          second: second,
                                        )));
                                  final player=AudioCache();
                                  player.play('happyday1.mp3');
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  "Start",
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.deepPurple,
                                  backgroundColor: Colors.deepPurple),
                            ),
                          )
                        ],
                      ),
                    );
                    // use your custom widget inside the slider (gets a slider value from the callback)
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
