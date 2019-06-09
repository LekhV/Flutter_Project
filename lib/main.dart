import 'package:flutter/material.dart';
import 'package:futter_product/src/AllCardScreen.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Post {
  final String username;
  final String password;

  Post({this.username, this.password});
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      username: json['username'],
      password: json['password'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["username"] = username;
    map["password"] = password;

    return map;
  }
}

Future<Post> createPost(String url, {Map body}) async {
  return http.post(url, body: body).then((http.Response response) {
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
      }
      return Post.fromJson(json.decode(response.body));

      });
      }

      void main() {
        runApp(MaterialApp(
          title: 'Product',
          home: FirstRoute(),
          ));
          }

          class FirstRoute extends StatelessWidget {
            final Future<Post> post;
            FirstRoute({Key key, this.post}) : super(key: key);

            static final CreateRegisterURL = 'http://smktesting.herokuapp.com/api/register/';
            static final CreateLoginURL = 'http://smktesting.herokuapp.com/api/login/';

            TextEditingController usernameControler = new TextEditingController();
            TextEditingController passwordControler = new TextEditingController();

            @override

            Widget build(BuildContext context) {
              return Scaffold(
                body: Center(
                  child: Container(
                    color: Colors.blue[900],
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        TextField(
                          decoration: new InputDecoration(
                            contentPadding:
                            const EdgeInsets.only(left: 20.0, bottom: 12.0, top: 8.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueAccent[200], width: 2.0),
                              borderRadius: BorderRadius.circular(25.7),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue[900], width: 10.0),
                                borderRadius: BorderRadius.circular(25.7),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Enter UserName',
                                ),
                                controller: usernameControler,
                                ),

                                TextField(
                                  obscureText: true,
                                  decoration: new InputDecoration(
                                    contentPadding:
                                    const EdgeInsets.only(left: 20.0, bottom: 8.0, top: 8.0),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.blueAccent[200], width: 2.0),
                                      borderRadius: BorderRadius.circular(25.7),
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: Colors.blue[900], width: 10.0),
                                        borderRadius: BorderRadius.circular(25.7),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Enter Password'
                                        ),
                                        controller: passwordControler,
                                        ),

                                        ButtonTheme(
                                          minWidth: 200.0,
                                          child: RaisedButton(
                                            child: Text(" Sign Up"),
                                            color: Colors.blue[100],
                                            onPressed: () async {
                                              if (usernameControler.text.length == 0 || passwordControler.text.length == 0) {
                                                return showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      content: Text("Please enter UserName or Password"),
                                                      );
                                                      },
                                                      );
                                              }else{
                                              Post newPost = new Post(
                                                username: usernameControler.text, password: passwordControler.text);
                                                Post p = await createPost(CreateRegisterURL,
                                                body: newPost.toMap());
                                                print(p.username);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => MyHomePage(),
                                                    ),
                                                    );
                                                    }
                                                    return showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                          content: Text("Sign Up Successfully"),
                                                          );
                                                          },
                                                          );
                                                          },
                                                          ),
                                                          ),

                                                    ButtonTheme(
                                                    minWidth: 200.0,
                                                    child: RaisedButton(
                                                      child: Text("Sign In"),
                                                      color: Colors.blue[100],
                                                      onPressed: () async {
                                                        if (usernameControler.text.length == 0 || passwordControler.text.length == 0) {
                                                          return showDialog(
                                                            context: context,
                                                            builder: (context) {
                                                              return AlertDialog(
                                                                content: Text("Please enter UserName or Password"),
                                                                );
                                                                },
                                                                );
                                                                }else{
                                                                  Post newPost = new Post(
                                                          username: usernameControler.text, password: passwordControler.text);
                                                          Post p = await createPost(CreateLoginURL,
                                                          body: newPost.toMap());
                                                          print(p.username);
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) => MyHomePage(),
                                                              ),
                                                              );
                                                                }
                                                              return showDialog(
                                                                context: context,
                                                                builder: (context) {
                                                                  return AlertDialog(
                                                                    content: Text("Sign In Successfully"),
                                                                    );
                                                                    },
                                                                    );
                                                                    },
                                                                    ),
                                                                    ),

                                                              ButtonTheme(
                                                                minWidth: 200.0,
                                                                child: RaisedButton(
                                                                  child: Text("Without registering"),
                                                                  color: Colors.blue[100],
                                                                  onPressed: () {
                                                                    Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder: (context) => MyHomePage(),
                                                                        ),
                                                                        );
                                                                        },
                                                                 /* onPressed: () {
                                                                    return showDialog(
                                                                      context: context,
                                                                      builder: (context) {
                                                                        return AlertDialog(
                                                                          content: Text(usernameControler.text),
                                                                          );
                                                                        },
                                                                        );
                                                                  },*/
                                                                        ),
                                                                        ),
                                                                        ],
                                                                        ),
                                                                        ),
                                                                        ),
                                                                        );
                                                                        }
                                                                        }
