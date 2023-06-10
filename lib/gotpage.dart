import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Color mainColor = Colors.amber;
Color secColor = Colors.black;

class GotPage extends StatefulWidget {
  // const GotPage({super.key});

  @override
  State<GotPage> createState() => _GotPageState();
}

class _GotPageState extends State<GotPage> {
  var data;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  fetchData() async {
    var res = await http.get(Uri.parse(
        "https://api.tvmaze.com/singlesearch/shows?q=game%20of%20thrones&embed=episodes"));
    // print(res.body);
    data = jsonDecode(res.body);
    setState(() {});
  }

  showGrdiWidget() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 16, crossAxisSpacing: 16),
        itemBuilder: (context, index) {
          return Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Stack(fit: StackFit.expand, children: [
              Image.network(
                data["_embedded"]["episodes"][index]["image"]["original"],
                fit: BoxFit.cover,
              ),
              Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      data["_embedded"]["episodes"][index]["name"],
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  )),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  padding:EdgeInsets.all(8),
                  child: Text(
                      "S${data["_embedded"]["episodes"][index]["season"]}E${data["_embedded"]["episodes"][index]["number"]}",
                      style: TextStyle(color: Colors.white,
                   
                      ),
                   
                      
                      ),
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15)),
                      ),
                ),
              )
            ]),
          );
        },
        itemCount: data["_embedded"]["episodes"].length,
      ),
    );
  }

  dataBody(BuildContext context) {
    var imgUrl = data["image"]["original"];

    var body = Column(
      children: [
        Center(
          child: CircleAvatar(
            backgroundColor: mainColor,
            backgroundImage: NetworkImage(imgUrl),
            radius: 130,
          ),
        ),
        SizedBox(
          height: 25,
        ),
        Text(data["name"]),
        SizedBox(
          height: 25,
        ),
        Expanded(child: showGrdiWidget()),
      ],
    );
    return body;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: Text("got 2019"),
      ),
      body: data != null
          ? dataBody(context)
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
