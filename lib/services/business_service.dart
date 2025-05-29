import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:restapi_crud/model/business.dart';

const String baseUrl = "https://retoolapi.dev/0KqRcK/Business";

Future<List<Business>?> getAllBusiness() async {
  try {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData
          .map((businessJson) => Business.fromJson(businessJson))
          .toList();
    }
    return null;
  } catch (e) {
    log("Error fetching companies: $e");
    return null;
  }
}

Future<Business?> createBusiness(Business business) async {
  try {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(business.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return Business.fromJson(jsonDecode(response.body));
    }
    return null;
  } catch (e) {
    log("Error creating Business: $e");
    return null;
  }
}

Future<List<Business>?> searchBusiness(String query) async {
  try {
    final response = await http.get(Uri.parse("$baseUrl?BusinessName=$query"));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData
          .map((businessJson) => Business.fromJson(businessJson))
          .toList();
    }
    return null;
  } catch (e) {
    log("Error searching companies: $e");
    return null;
  }
}

Future<Business?> updateBusiness(int id, Business business) async {
  try {
    final response = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(business.toJson()),
    );

    if (response.statusCode == 200) {
      return Business.fromJson(jsonDecode(response.body));
    }
    return null;
  } catch (e) {
    log("Error updating Business: $e");
    return null;
  }
}

Future<bool> updateBusinessPartially(
    int id, Map<String, dynamic> updatedData) async {
  try {
    final response = await http.patch(
      Uri.parse("$baseUrl/$id"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updatedData),
    );

    return response.statusCode == 200;
  } catch (e) {
    log("Error updating Business partially: $e");
    return false;
  }
}

Future<bool> deleteBusiness(int id) async {
  try {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));
    return response.statusCode == 204 || response.statusCode == 200;
  } catch (e) {
    log("Error deleting Business: $e");
    return false;
  }
}
