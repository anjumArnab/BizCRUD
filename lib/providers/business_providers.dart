import 'package:flutter/material.dart';
import '../services/Business_service.dart';
import '../model/business.dart';

class BusinessProvider with ChangeNotifier {
  List<Business> _companies = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Business> get companies => _companies;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchCompanies() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    final result = await getAllBusiness();
    if (result != null) {
      _companies = result;
    } else {
      _errorMessage = "Failed to load business.";
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> addBusiness(Business business) async {
    final newBusiness = await createBusiness(business);
    if (newBusiness != null) {
      _companies.add(newBusiness);
      notifyListeners();
    }
  }

  Future<void> updateBusinessInfo(int id, Business updatedBusiness) async {
    final result = await updateBusiness(id, updatedBusiness);
    if (result != null) {
      final index = _companies.indexWhere((Business) => Business.id == id);
      if (index != -1) {
        _companies[index] = result;
        notifyListeners();
      }
    }
  }

  Future<void> deleteBusinessById(int id) async {
    final success = await deleteBusiness(id);
    if (success) {
      _companies.removeWhere((Business) => Business.id == id);
      notifyListeners();
    }
  }

  Future<void> searchCompanies(String query) async {
    _isLoading = true;
    notifyListeners();

    final result = await searchBusiness(query);
    if (result != null) {
      _companies = result;
    } else {
      _errorMessage = "No matching companies found.";
    }
    _isLoading = false;
    notifyListeners();
  }
}
