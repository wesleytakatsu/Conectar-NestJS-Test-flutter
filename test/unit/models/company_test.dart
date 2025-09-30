import 'package:flutter_test/flutter_test.dart';
import 'package:conectar_app/models/company.dart';

void main() {
  group('Company Model Tests', () {
    group('fromJson', () {
      test('should create Company from valid JSON', () {
        // Arrange
        final json = {
          'id': '1',
          'razaoSocial': 'Empresa Teste Ltda',
          'nomeFantasia': 'Empresa Teste',
          'cnpj': '12.345.678/0001-90',
          'email': 'contato@empresateste.com',
          'telefone': '(11) 1234-5678',
          'endereco': 'Rua Teste, 123',
          'cidade': 'São Paulo',
          'estado': 'SP',
          'cep': '01234-567',
          'status': 'ativo',
          'conectaPlus': true,
          'createdAt': '2023-01-01T10:00:00.000Z',
          'updatedAt': '2023-01-02T10:00:00.000Z',
        };

        // Act
        final company = Company.fromJson(json);

        // Assert
        expect(company.id, equals('1'));
        expect(company.razaoSocial, equals('Empresa Teste Ltda'));
        expect(company.nomeFantasia, equals('Empresa Teste'));
        expect(company.cnpj, equals('12.345.678/0001-90'));
        expect(company.email, equals('contato@empresateste.com'));
        expect(company.telefone, equals('(11) 1234-5678'));
        expect(company.endereco, equals('Rua Teste, 123'));
        expect(company.cidade, equals('São Paulo'));
        expect(company.estado, equals('SP'));
        expect(company.cep, equals('01234-567'));
        expect(company.status, equals('ativo'));
        expect(company.conectaPlus, equals(true));
        expect(company.createdAt, equals(DateTime.parse('2023-01-01T10:00:00.000Z')));
        expect(company.updatedAt, equals(DateTime.parse('2023-01-02T10:00:00.000Z')));
      });

      test('should create Company from minimal JSON with defaults', () {
        // Arrange
        final json = {
          'id': '1',
          'razaoSocial': 'Empresa Teste Ltda',
          'cnpj': '12.345.678/0001-90',
          'createdAt': '2023-01-01T10:00:00.000Z',
          'updatedAt': '2023-01-02T10:00:00.000Z',
        };

        // Act
        final company = Company.fromJson(json);

        // Assert
        expect(company.id, equals('1'));
        expect(company.razaoSocial, equals('Empresa Teste Ltda'));
        expect(company.cnpj, equals('12.345.678/0001-90'));
        expect(company.status, equals('ativo')); // Default value
        expect(company.conectaPlus, equals(false)); // Default value
        expect(company.nomeFantasia, isNull);
        expect(company.email, isNull);
        expect(company.telefone, isNull);
        expect(company.endereco, isNull);
        expect(company.cidade, isNull);
        expect(company.estado, isNull);
        expect(company.cep, isNull);
      });

      test('should handle null optional fields gracefully', () {
        // Arrange
        final json = {
          'id': '1',
          'razaoSocial': 'Empresa Teste Ltda',
          'nomeFantasia': null,
          'cnpj': '12.345.678/0001-90',
          'email': null,
          'telefone': null,
          'endereco': null,
          'cidade': null,
          'estado': null,
          'cep': null,
          'status': 'inativo',
          'conectaPlus': false,
          'createdAt': '2023-01-01T10:00:00.000Z',
          'updatedAt': '2023-01-02T10:00:00.000Z',
        };

        // Act
        final company = Company.fromJson(json);

        // Assert
        expect(company.nomeFantasia, isNull);
        expect(company.email, isNull);
        expect(company.telefone, isNull);
        expect(company.endereco, isNull);
        expect(company.cidade, isNull);
        expect(company.estado, isNull);
        expect(company.cep, isNull);
        expect(company.status, equals('inativo'));
        expect(company.conectaPlus, equals(false));
      });
    });

    group('toJson', () {
      test('should convert Company to JSON correctly', () {
        // Arrange
        final company = Company(
          id: '1',
          razaoSocial: 'Empresa Teste Ltda',
          nomeFantasia: 'Empresa Teste',
          cnpj: '12.345.678/0001-90',
          email: 'contato@empresateste.com',
          telefone: '(11) 1234-5678',
          endereco: 'Rua Teste, 123',
          cidade: 'São Paulo',
          estado: 'SP',
          cep: '01234-567',
          status: 'ativo',
          conectaPlus: true,
          createdAt: DateTime.parse('2023-01-01T10:00:00.000Z'),
          updatedAt: DateTime.parse('2023-01-02T10:00:00.000Z'),
        );

        // Act
        final json = company.toJson();

        // Assert
        expect(json['id'], equals('1'));
        expect(json['razaoSocial'], equals('Empresa Teste Ltda'));
        expect(json['nomeFantasia'], equals('Empresa Teste'));
        expect(json['cnpj'], equals('12.345.678/0001-90'));
        expect(json['email'], equals('contato@empresateste.com'));
        expect(json['telefone'], equals('(11) 1234-5678'));
        expect(json['endereco'], equals('Rua Teste, 123'));
        expect(json['cidade'], equals('São Paulo'));
        expect(json['estado'], equals('SP'));
        expect(json['cep'], equals('01234-567'));
        expect(json['status'], equals('ativo'));
        expect(json['conectaPlus'], equals(true));
        expect(json['createdAt'], equals('2023-01-01T10:00:00.000Z'));
        expect(json['updatedAt'], equals('2023-01-02T10:00:00.000Z'));
      });

      test('should convert Company with null values to JSON correctly', () {
        // Arrange
        final company = Company(
          id: '1',
          razaoSocial: 'Empresa Teste Ltda',
          cnpj: '12.345.678/0001-90',
          status: 'ativo',
          conectaPlus: false,
          createdAt: DateTime.parse('2023-01-01T10:00:00.000Z'),
          updatedAt: DateTime.parse('2023-01-02T10:00:00.000Z'),
        );

        // Act
        final json = company.toJson();

        // Assert
        expect(json['id'], equals('1'));
        expect(json['razaoSocial'], equals('Empresa Teste Ltda'));
        expect(json['cnpj'], equals('12.345.678/0001-90'));
        expect(json['status'], equals('ativo'));
        expect(json['conectaPlus'], equals(false));
        expect(json['nomeFantasia'], isNull);
        expect(json['email'], isNull);
        expect(json['telefone'], isNull);
        expect(json['endereco'], isNull);
        expect(json['cidade'], isNull);
        expect(json['estado'], isNull);
        expect(json['cep'], isNull);
      });
    });

    group('copyWith', () {
      test('should create a copy with updated values', () {
        // Arrange
        final original = Company(
          id: '1',
          razaoSocial: 'Empresa Original Ltda',
          cnpj: '12.345.678/0001-90',
          status: 'ativo',
          conectaPlus: false,
          createdAt: DateTime.parse('2023-01-01T10:00:00.000Z'),
          updatedAt: DateTime.parse('2023-01-02T10:00:00.000Z'),
        );

        // Act
        final copy = original.copyWith(
          razaoSocial: 'Empresa Atualizada Ltda',
          nomeFantasia: 'Empresa Nova',
          status: 'inativo',
          conectaPlus: true,
        );

        // Assert
        expect(copy.id, equals(original.id));
        expect(copy.razaoSocial, equals('Empresa Atualizada Ltda'));
        expect(copy.nomeFantasia, equals('Empresa Nova'));
        expect(copy.cnpj, equals(original.cnpj));
        expect(copy.status, equals('inativo'));
        expect(copy.conectaPlus, equals(true));
        expect(copy.createdAt, equals(original.createdAt));
        expect(copy.updatedAt, equals(original.updatedAt));
      });

      test('should create a copy without changes when no parameters provided', () {
        // Arrange
        final original = Company(
          id: '1',
          razaoSocial: 'Empresa Teste Ltda',
          cnpj: '12.345.678/0001-90',
          status: 'ativo',
          conectaPlus: false,
          createdAt: DateTime.parse('2023-01-01T10:00:00.000Z'),
          updatedAt: DateTime.parse('2023-01-02T10:00:00.000Z'),
        );

        // Act
        final copy = original.copyWith();

        // Assert
        expect(copy.id, equals(original.id));
        expect(copy.razaoSocial, equals(original.razaoSocial));
        expect(copy.cnpj, equals(original.cnpj));
        expect(copy.status, equals(original.status));
        expect(copy.conectaPlus, equals(original.conectaPlus));
        expect(copy.createdAt, equals(original.createdAt));
        expect(copy.updatedAt, equals(original.updatedAt));
      });
    });

    group('Constructor', () {
      test('should create Company with required parameters', () {
        // Act
        final company = Company(
          id: '1',
          razaoSocial: 'Empresa Teste Ltda',
          cnpj: '12.345.678/0001-90',
          status: 'ativo',
          conectaPlus: false,
          createdAt: DateTime.parse('2023-01-01T10:00:00.000Z'),
          updatedAt: DateTime.parse('2023-01-02T10:00:00.000Z'),
        );

        // Assert
        expect(company.id, equals('1'));
        expect(company.razaoSocial, equals('Empresa Teste Ltda'));
        expect(company.cnpj, equals('12.345.678/0001-90'));
        expect(company.status, equals('ativo'));
        expect(company.conectaPlus, equals(false));
        expect(company.nomeFantasia, isNull);
        expect(company.email, isNull);
        expect(company.telefone, isNull);
        expect(company.endereco, isNull);
        expect(company.cidade, isNull);
        expect(company.estado, isNull);
        expect(company.cep, isNull);
      });
    });
  });
}