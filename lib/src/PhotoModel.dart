import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client.get('http://smktesting.herokuapp.com/api/products/');
  // Use the compute function to run parsePhotos in a separate isolate
  return compute(parsePhotos, response.body);
  }
// A function that converts a response body into a List<Photo>
List<Photo> parsePhotos(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
  }

  class Photo {
    final int id;
    final String title;
    final String text;
    final String img;
    final String img2;

    Photo({ this.id, this.title, this.text, this.img,this.img2});

    factory Photo.fromJson(Map<String, dynamic> json) {
      return Photo(
        id: json['id'] as int,
        title: json['title'] as String,
        img:  json[ 'img'] as String,
        text: json['text'] as String,
        );
        }
        }
