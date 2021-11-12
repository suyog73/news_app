import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class SlideItem extends StatelessWidget {
  final List listData;
  final int index;

  const SlideItem({Key? key, required this.listData, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.35,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        listData[index]['banner_link'].toString(),
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 22.0,
                  child: Container(
                    alignment: Alignment.center,
                    width: 90.0,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Color(0xFF424242),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(13),
                        topRight: Radius.circular(13),
                      ),
                    ),
                    child: Text(
                      'NewsApp',
                      style: TextStyle(
                        color: Colors.grey[400],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                children: [
                  Text(
                    listData[index]['title'].toString(),
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 23.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    listData[index]['content'].toString(),
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                listData[index]['more_info']['text'],
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
              Link(
                uri: Uri.parse('https://www.google.co.in/'),
                builder: (context, openLink) {
                  return InkWell(
                    onTap: () {
                      openUrl(listData, index);
                    },
                    child: Text(
                      listData[index]['more_info']['link'],
                      style: const TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 16,
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}

openUrl(listData, index) {
  String url = listData[index]['more_info']['link'];
  launch(url);
}
