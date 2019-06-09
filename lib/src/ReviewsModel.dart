import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<List<Reviews>> fetchReviews(http.Client client) async {
  final response = await client.get('http://smktesting.herokuapp.com/api/reviews/1');
  return compute(parseReviews, response.body);
  }

// A function that converts a response body into a List<Photo>
List<Reviews> parseReviews(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Reviews>((json) => Reviews.fromJson(json)).toList();
  }

  class Reviews {
    int id;
    int product;
    int rate;
    String text;
    CreatedBy createdBy;
    String createdAt;

    Reviews({ this.id,this.product, this.rate,  this.text, this.createdAt,this.createdBy});

    factory Reviews.fromJson(Map<String, dynamic> json) {

      return Reviews(
        id: json['id'] as int,
        product: json['product'] as int,
        rate:  json[ 'rate'] as int,
        text: json['text'] as String,
        createdAt: json['created_at'] as String,
        createdBy: CreatedBy.fromJson(json['created_by'])
        );
        }
        }

        class CreatedBy{
          int id;
          String username;
          CreatedBy({
            this.id,
            this.username,
            });
            factory CreatedBy.fromJson(Map<String, dynamic> json){
              return CreatedBy(
                id: json['id'] as int,
                username: json['username'] as String,
                );
                }
                }