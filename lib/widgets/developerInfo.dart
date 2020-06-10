import 'package:flutter/material.dart';

class DeveloperInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

     RouteSettings settings = ModalRoute.of(context).settings;
     String photoUrl = settings.arguments;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: new Text(
          'Developer',
          style: TextStyle(
            fontFamily: 'Nunito',
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Hero(
              tag: 'Developer',
              child: Container(
                height: size.height * 0.4,
                decoration: new BoxDecoration(
                  image: DecorationImage(
                    image: new NetworkImage(photoUrl),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Go',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
                Text(
                  'Corona',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
                Text(
                  'Go',
                  style: TextStyle(
                    fontFamily: 'Nunito',
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
