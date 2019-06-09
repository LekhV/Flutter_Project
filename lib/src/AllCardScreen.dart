import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:futter_product/src/PhotoModel.dart';
import 'package:futter_product/src/DetailScreen.dart';

void main() => runApp(MyHomePage());

class MyHomePage extends StatelessWidget {

final String title;

MyHomePage({Key key, this.title}) : super(key: key);

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text('All Product')
      ),
      body: FutureBuilder<List<Photo>>(
        future: fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
          ? PhotosList(photos: snapshot.data)
          : Center(child: CircularProgressIndicator());
          },
          ),
          );
          }
          }

          class PhotosList extends StatelessWidget {
            final List<Photo> photos;
            PhotosList({Key key, this.photos}) : super(key: key);

            @override
            Widget build(BuildContext context) {
              return GridView.builder(

                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 4),
                  ),
                  padding: EdgeInsets.all(30.0),
                  itemCount: photos.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image.network("http://smktesting.herokuapp.com/static/" + photos[index].img),
                      title: Text(photos[index].text,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20.0,
                        ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailScreen(todo: photos[index]),
                              ),
                              );
                              },
                              );
                              },
                              );
                              }
                              }

