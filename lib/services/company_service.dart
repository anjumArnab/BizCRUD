import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:restapi_crud/model/company.dart';

const String baseUrl = "https://retoolapi.dev/0KqRcK/company";

Future<List<Company>?> getAllCompanies() async {
  try {
    final response = await http.get(Uri.parse(baseUrl));
    
    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((company) => Company.fromJson(company)).toList();
    }
    return null;
  } catch (e) {
    log("Error fetching companies: $e");
    return null;
  }
}

Future<Company?> createCompany(Company company) async {
  try {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(company.toJson()),
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      return Company.fromJson(jsonDecode(response.body));
    }
    return null;
  } catch (e) {
    log("Error creating company: $e");
    return null;
  }
}

Future<List<Company>?> searchCompany(String query) async {
  try {
    final response = await http.get(Uri.parse("$baseUrl?companyName=$query"));
    
    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((company) => Company.fromJson(company)).toList();
    }
    return null;
  } catch (e) {
    log("Error searching companies: $e");
    return null;
  }
}

Future<Company?> updateCompany(int id, Company company) async {
  try {
    final response = await http.put(
      Uri.parse("$baseUrl/$id"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(company.toJson()),
    );

    if (response.statusCode == 200) {
      return Company.fromJson(jsonDecode(response.body));
    }
    return null;
  } catch (e) {
    log("Error updating company: $e");
    return null;
  }
}

Future<bool> updateCompanyPartially(int id, Map<String, dynamic> updatedData) async {
  try {
    final response = await http.patch(
      Uri.parse("$baseUrl/$id"),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(updatedData),
    );

    return response.statusCode == 200;
  } catch (e) {
    log("Error updating company partially: $e");
    return false;
  }
}

Future<bool> deleteCompany(int id) async {
  try {
    final response = await http.delete(Uri.parse("$baseUrl/$id"));
    return response.statusCode == 204 || response.statusCode == 200;
  } catch (e) {
    log("Error deleting company: $e");
    return false;
  }
}
