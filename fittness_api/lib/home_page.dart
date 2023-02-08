import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:fittness_api/model.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fittness_api/second_page.dart';
import 'package:fittness_api/widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String link =
      "https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json?fbclid=IwAR2gsu4SRvRRFkHK8JPTWHZXmaNP0dtpOG6h7ep4zQp7WaamX5S1UaSrc3A";

  List<Exercise> allData = [];
  late Exercise exercise;
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  bool isLoading = false;
  fetchData() async {
    try {
      setState(() {
        isLoading = true;
      });
      var responce = await http.get(Uri.parse(link));
      // print("status code is ${responce.statusCode}");
      if (responce.statusCode == 200) {
        var data = jsonDecode(responce.body);
        for (var i in data["exercises"]) {
          exercise = Exercise(
              id: i["id"],
              title: i["title"],
              thumbnail: i["thumbnail"],
              seconds: i["seconds"],
              gif: i["gif"]);
          setState(() {
            allData.add(exercise);
          });
        }
        setState(() {
          isLoading = false;
        });
      }
      setState(() {
        isLoading = false;
      });
      //

    } catch (maria) {
      setState(() {
        isLoading = false;
      });
      // print("the problem is $maria");
      showToast("Somthing wrong bro");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading == true,
      blur: 0.5,
      opacity: 0.5,
      progressIndicator: const CircularProgressIndicator(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          leading: Icon(
            Icons.menu,
            size: 30,
            color: Colors.deepPurple,
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
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: allData.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SecondPage(
                              exercise: allData[index],
                            )));
                  },
                  child: Container(
                    height: 300,
                    child: Stack(
                      children: [
                        /*Image(image: NetworkImage('${allData[index].thumbnail}')),*/
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                            width: double.infinity,
                            imageUrl: "${allData[index].thumbnail}",
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Image.asset(
                                "images/User.png",
                                fit: BoxFit.cover,
                                width: double.infinity),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.only(left: 20, top: 10),
                            child: GradientText(
                              '${allData[index].title}',
                              style: const TextStyle(fontSize: 28.0, shadows: [
                                Shadow(
                                  offset: Offset(3.0, 3.0),
                                  blurRadius: 2.0,
                                  color: Colors.pink,
                                )
                              ]),
                              colors: const [
                                Colors.blue,
                                Colors.white,
                                Colors.green,
                              ],
                            ),
                            height: 70,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20)),
                                gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.white12,
                                      Colors.white24,
                                      Colors.white30
                                    ])),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}

showToast(String title) {
  return Fluttertoast.showToast(
      msg: title,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}
