import 'package:flutter/foundation.dart';
import '../models/company.dart';
import '../services/company_service.dart';

class CompanyController extends ChangeNotifier {
  final CompanyService _companyService;
  
  List<Company> _companies = [];
  bool _isLoading = false;
  String? _error;

  CompanyController(this._companyService);

  List<Company> get companies => _companies;
  bool get isLoading => _isLoading;
  String? get error => _error;

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _error = error;
    notifyListeners();
  }

  Future<bool> createCompany({
    required String razaoSocial,
    String? nomeFantasia,
    required String cnpj,
    String? email,
    String? telefone,
    String? endereco,
    String? cidade,
    String? estado,
    String? cep,
    String? status,
    bool? conectaPlus,
  }) async {
    try {
      _setLoading(true);
      _setError(null);

      final companyData = <String, dynamic>{
        'razaoSocial': razaoSocial,
        'cnpj': cnpj,
      };

      if (nomeFantasia != null && nomeFantasia.isNotEmpty) {
        companyData['nomeFantasia'] = nomeFantasia;
      }
      if (email != null && email.isNotEmpty) {
        companyData['email'] = email;
      }
      if (telefone != null && telefone.isNotEmpty) {
        companyData['telefone'] = telefone;
      }
      if (endereco != null && endereco.isNotEmpty) {
        companyData['endereco'] = endereco;
      }
      if (cidade != null && cidade.isNotEmpty) {
        companyData['cidade'] = cidade;
      }
      if (estado != null && estado.isNotEmpty) {
        companyData['estado'] = estado;
      }
      if (cep != null && cep.isNotEmpty) {
        companyData['cep'] = cep;
      }
      if (status != null) {
        companyData['status'] = status;
      }
      if (conectaPlus != null) {
        companyData['conectaPlus'] = conectaPlus;
      }

      final company = await _companyService.createCompany(companyData);
      _companies.add(company);
      notifyListeners();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> loadCompanies({
    String? status,
    bool? conectaPlus,
    String? sortBy,
    String? order,
    String? search,
  }) async {
    try {
      _setLoading(true);
      _setError(null);

      final companies = await _companyService.getCompanies(
        status: status,
        conectaPlus: conectaPlus,
        sortBy: sortBy,
        order: order,
        search: search,
      );

      _companies = companies;
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  Future<Company?> getCompany(String id) async {
    try {
      _setLoading(true);
      _setError(null);

      return await _companyService.getCompany(id);
    } catch (e) {
      _setError(e.toString());
      return null;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> updateCompany(String id, Map<String, dynamic> companyData) async {
    try {
      _setLoading(true);
      _setError(null);

      final updatedCompany = await _companyService.updateCompany(id, companyData);
      
      final index = _companies.indexWhere((c) => c.id == id);
      if (index != -1) {
        _companies[index] = updatedCompany;
        notifyListeners();
      }
      
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> deleteCompany(String id) async {
    try {
      _setLoading(true);
      _setError(null);

      await _companyService.deleteCompany(id);
      
      _companies.removeWhere((c) => c.id == id);
      notifyListeners();
      
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  void clearError() {
    _setError(null);
  }
}