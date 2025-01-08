import 'dart:convert';
import 'dart:developer';

import 'package:restapi_crud/model/company.dart';
import 'package:http/http.dart' as http;

class CompanyService {
  String baseUrl = "https://retoolapi.dev/4mRvYN/";

  getAllCompanies() async {
    try {
      List<Company> allCompanies = [];
      var response = await http.get(Uri.parse(baseUrl + 'company'));

      if (response.statusCode == 200) {
        var data = response.body;

        var jsonData = jsonDecode(data);

        print(jsonData);

        for (var company in jsonData) {
          Company newCompnay = Company.fromJson(company);
          allCompanies.add(newCompnay);
        }

        return allCompanies;
      } else {
        throw Exception(
            "Error occured with status code ${response.statusCode} and the message is ${response.body}");
      }
    } catch (e) {
      print("Error occured: ${e.toString()}");
    }
  }

  createCompany(Company company) async {
    log("create company is called");
    try {
      var response = await http.post(Uri.parse(baseUrl + 'company'),
          body: company.toJson());

      log("The response is ${response.body}");

      if (response.statusCode == 201 || response.statusCode == 200) {
        print(
            "The company is suceesfully created with the following details:  ${response.body}");
      } else {
        throw Exception(
            "Error occured with status code ${response.statusCode} and the message is ${response.body}");
      }
    } catch (e) {
      print("Error occured: ${e.toString()}");
    }
  }

  updateCompanyPartially(Map<String, dynamic> updatedData, int id)async{

    try {
      var response = await http.patch(Uri.parse(baseUrl + 'company' + '/$id'), body: updatedData);

      log("the responses status code os ${response.statusCode}");

      if (response.statusCode == 201 || response.statusCode == 200) {
        print(
            "The company is suceesfully deleted with the following details:  ${response.body}");
      } else {
        throw Exception(
            "Error occured with status code ${response.statusCode} and the message is ${response.body}");
      }
    } catch (e) {
      print("Error occured: ${e.toString()}");
    }



  }

  updateCompany(Company company, int id) async {
    try {
      var response = await http.put(Uri.parse(baseUrl + 'company' + '/$id'), body: company.toJson());

      log("the responses status code os ${response.statusCode}");

      if (response.statusCode == 201 || response.statusCode == 200) {
        print(
            "The company is suceesfully deleted with the following details:  ${response.body}");
      } else {
        throw Exception(
            "Error occured with status code ${response.statusCode} and the message is ${response.body}");
      }
    } catch (e) {
      print("Error occured: ${e.toString()}");
    }
  }

  deleteCompany(int id) async {
    try {
      var response = await http.delete(Uri.parse(baseUrl + 'company' + '/$id'));

      if (response.statusCode == 204 || response.statusCode == 200) {
        print(
            "The company is suceesfully deleted with the following details:  ${response.body}");
      } else {
        throw Exception(
            "Error occured with status code ${response.statusCode} and the message is ${response.body}");
      }
    } catch (e) {
      print("Error occured: ${e.toString()}");
    }
  }
}