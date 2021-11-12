import 'dart:convert';
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
    return listData;
  }

  @override
  void initState() {
    apiCall();
    super.initState();
  }

  PageController controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF424242),
      body: listData == null
          ? const CircularProgressIndicator()
          : RefreshIndicator(
              onRefresh: () => apiCall(),
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
  }
}

// https://data.flipitnews.com/
