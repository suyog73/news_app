import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:news_app_internship/widgets/slide_item.dart';

const apiUrl = "https://data.flipitnews.com/";
String apiData = '';
Map mapData = {};
List listData = [];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future apiCall() async {
    http.Response response;
    response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      setState(() {
        apiData = response.body;
        listData = json.decode(response.body);
      });
    }
  }

  @override
  void initState() {
    apiCall();
    super.initState();
  }

  PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: http.get(Uri.parse(apiUrl)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            backgroundColor: const Color(0xFF424242),
            body: RefreshIndicator(
              onRefresh: () => http.get(Uri.parse(apiUrl)),
              color: Colors.white,
              backgroundColor: Colors.black45,
              child: PageView.builder(
                controller: controller,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, i) =>
                    SlideItem(listData: listData, index: i),
                itemCount: listData.length,
              ),
            ),
          );
        } else {
          return Container(
            color: const Color(0xFF424242),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: const Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }
}

// https://data.flipitnews.com/
