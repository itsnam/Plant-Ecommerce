import 'dart:convert';

import 'package:http/http.dart';
import 'package:plantial/features/Url/url.dart';
import 'package:plantial/models/product.dart';

Future<List<Product>> getPlants({int page = 0, itemsPerPage = 6, sortBy = 'createdAt'}) async {
  final response = await get(Uri.parse(apiPlants).replace(
    queryParameters: {
      'page' : page.toString(),
      'itemsPerPage' : itemsPerPage.toString(),
      'sortBy' : sortBy,
    }
  ));
  if(response.statusCode == 200){
    final List result = json.decode(response.body);
    return result.map((e) => Product.fromJson(e)).toList();
  }else{
    throw Exception("Failed to load data");
  }
}