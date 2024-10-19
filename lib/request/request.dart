import 'dart:convert';
import 'package:cbu/models/models.dart';
import 'package:http/http.dart' as http;

class CBRequest {
  Future<List<CBModel>> getRequest() async {
    final response = await http
        .get(Uri.parse('https://cbu.uz/uzc/arkhiv-kursov-valyut/json/'));
    final json = jsonDecode(response.body).cast<Map<String, dynamic>>();
    return json.map<CBModel>((json) => CBModel.fromJson(json)).toList();
  }
}
class Hello{}
class OnlineService {
  Future<List<Quote>> getQuotes() async {
    final response = await http
        .get(Uri.parse('https://jsonguide.technologychannel.org/quotes.json'));
    final json = jsonDecode(response.body).cast<Map<String, dynamic>>();
    return json.map<Quote>((json)=> Quote.fromJson(json)).toList();
  }
}
