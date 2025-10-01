import 'package:dio/dio.dart';
import '../models/company.dart';

class CompanyService {
  final Dio _dio;
  
  CompanyService(this._dio);

  Future<Company> createCompany(Map<String, dynamic> companyData) async {
    try {
      final response = await _dio.post('/companies', data: companyData);
      return Company.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        throw Exception('CNPJ já cadastrado');
      } else if (e.response?.statusCode == 400) {
        throw Exception('Dados inválidos');
      } else if (e.response?.statusCode == 401) {
        throw Exception('Token de acesso inválido');
      } else if (e.response?.statusCode == 403) {
        throw Exception('Apenas administradores podem criar empresas');
      }
      throw Exception('Erro ao criar empresa: ${e.message}');
    }
  }

  Future<List<Company>> getCompanies({
    String? status,
    bool? conectaPlus,
    String? sortBy,
    String? order,
    String? search,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (status != null) queryParams['status'] = status;
      if (conectaPlus != null) queryParams['conectaPlus'] = conectaPlus.toString();
      if (sortBy != null) queryParams['sortBy'] = sortBy;
      if (order != null) queryParams['order'] = order;
      if (search != null && search.isNotEmpty) queryParams['search'] = search;

      final response = await _dio.get('/companies', queryParameters: queryParams);
      final List<dynamic> companiesJson = response.data;
      return companiesJson.map((json) => Company.fromJson(json)).toList();
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw Exception('Token de acesso inválido');
      } else if (e.response?.statusCode == 403) {
        throw Exception('Apenas administradores podem listar empresas');
      }
      throw Exception('Erro ao carregar empresas: ${e.message}');
    }
  }

  Future<Company> getCompany(String id) async {
    try {
      final response = await _dio.get('/companies/$id');
      return Company.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw Exception('Empresa não encontrada');
      } else if (e.response?.statusCode == 401) {
        throw Exception('Token de acesso inválido');
      } else if (e.response?.statusCode == 403) {
        throw Exception('Apenas administradores podem visualizar empresas');
      }
      throw Exception('Erro ao carregar empresa: ${e.message}');
    }
  }

  Future<Company> updateCompany(String id, Map<String, dynamic> companyData) async {
    try {
      final response = await _dio.patch('/companies/$id', data: companyData);
      return Company.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw Exception('Empresa não encontrada');
      } else if (e.response?.statusCode == 409) {
        throw Exception('CNPJ já cadastrado por outra empresa');
      } else if (e.response?.statusCode == 400) {
        throw Exception('Dados inválidos');
      } else if (e.response?.statusCode == 401) {
        throw Exception('Token de acesso inválido');
      } else if (e.response?.statusCode == 403) {
        throw Exception('Apenas administradores podem atualizar empresas');
      }
      throw Exception('Erro ao atualizar empresa: ${e.message}');
    }
  }

  Future<void> deleteCompany(String id) async {
    try {
      await _dio.delete('/companies/$id');
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw Exception('Empresa não encontrada');
      } else if (e.response?.statusCode == 401) {
        throw Exception('Token de acesso inválido');
      } else if (e.response?.statusCode == 403) {
        throw Exception('Apenas administradores podem deletar empresas');
      }
      throw Exception('Erro ao deletar empresa: ${e.message}');
    }
  }
}