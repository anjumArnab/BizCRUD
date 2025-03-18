import 'package:flutter/material.dart';
import 'package:restapi_crud/model/company.dart';
import 'package:restapi_crud/services/company_service.dart';

class CompanyProvider with ChangeNotifier {
  List<Company> _companies = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Company> get companies => _companies;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchCompanies() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();
    
    final result = await getAllCompanies();
    if (result != null) {
      _companies = result;
    } else {
      _errorMessage = "Failed to load companies.";
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addCompany(Company company) async {
    final newCompany = await createCompany(company);
    if (newCompany != null) {
      _companies.add(newCompany);
      notifyListeners();
    }
  }

  Future<void> updateCompanyInfo(int id, Company updatedCompany) async {
    final result = await updateCompany(id, updatedCompany);
    if (result != null) {
      final index = _companies.indexWhere((company) => company.id == id);
      if (index != -1) {
        _companies[index] = result;
        notifyListeners();
      }
    }
  }

  Future<void> deleteCompanyById(int id) async {
    final success = await deleteCompany(id);
    if (success) {
      _companies.removeWhere((company) => company.id == id);
      notifyListeners();
    }
  }

  Future<void> searchCompanies(String query) async {
    _isLoading = true;
    notifyListeners();
    
    final result = await searchCompany(query);
    if (result != null) {
      _companies = result;
    } else {
      _errorMessage = "No matching companies found.";
    }
    _isLoading = false;
    notifyListeners();
  }
}
