import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:futter_product/src/PhotoModel.dart';
import 'package:futter_product/src/ReviewsModel.dart';

class DetailScreen extends StatelessWidget {
  final Photo todo;
  final String title;
  int id;
  String stringId;

  DetailScreen({Key key, @required this.todo, this.title, this.id,this.stringId}) : super(key: key);

  Future<List<Reviews>> fetchReviews(http.Client client) async {

    final response = await client.get('http://smktesting.herokuapp.com/api/reviews/' + stringId);
    return compute(parseReviews, response.body);
    }

    @override
    Widget build(BuildContext context) {
    // Use the Todo to create our UI
    id = todo.id;
    stringId= id.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text(todo.title),
        ),
        body: //Container(
          Column(
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Container(
                  child: Column(
                    children: <Widget>[
                      new Container(  padding: const EdgeInsets.only( bottom: 4.0, top: 4.0),
                        child: new Text(todo.title,style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20.0,),
                        ),
                        ),
                        new Container( padding: const EdgeInsets.only( bottom: 4.0, top: 4.0),
                        child: new Image.network("http://smktesting.herokuapp.com/static/" + todo.img)),
                        new Container( padding: const EdgeInsets.only( bottom: 4.0, top: 4.0),
                        child: new Text("Product Description", style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16.0),
                          ),
                          ),
                          new Container( child: new Text(todo.text, style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.0),
                            ),
                            ),
                            new Container( padding: const EdgeInsets.only( bottom: 4.0, top: 4.0),
                            child: new Text("Reviews:", style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20.0,
                              ),
                              ),
                              ),
                              ]
                              ),
                              ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Container(
                                  child: new FutureBuilder<List<Reviews>>(
                                    future: fetchReviews(http.Client()),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) print(snapshot.error);
                                      return snapshot.hasData
                                      ? ReviewsList(reviews: snapshot.data)
                                      : Center(child: CircularProgressIndicator());
                                      },
                                      ),
                                      ),
                                      ),
                                      ],
                                      ),
                                      );
                                      }
                                      }

    class ReviewsList extends StatelessWidget {
      final List<Reviews> reviews;
      final List<CreatedBy> createdBy2;
      ReviewsList({Key key, this.reviews, this.createdBy2}) : super(key: key);

      @override
      Widget build(BuildContext context) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
            childAspectRatio: MediaQuery.of(context).size.width /
            (MediaQuery.of(context).size.height / 10),
            ),
            padding: EdgeInsets.all(10.0),
            itemCount: reviews.length,
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.only(left: 20.0, bottom: 4.0, top: 4.0),
                decoration: new BoxDecoration(
                  border: new Border.all(color: Colors.blueAccent,  width: 1.0),
                  borderRadius: BorderRadius.circular(25.7),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Container( padding: const EdgeInsets.only(left: 5.0, bottom: 4.0, top: 4.0),
                      child: new Text("Created At:  " + reviews[index].createdAt)),
                      new Container( padding: const EdgeInsets.only(left: 5.0, bottom: 4.0, top: 4.0),
                      child: new Text("Comment:  " + reviews[index].text)),
                      //new Container(  child: new Text(reviews[index].createdBy.username)),
                      ],
                      ),
                      ),
                      ],
                      ),
                      );
                      },
                      );
                      }
                      }