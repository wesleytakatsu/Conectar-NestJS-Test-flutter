import 'package:flutter_test/flutter_test.dart';
import 'package:conectar_app/models/user.dart';

void main() {
  group('User Model Tests', () {
    group('fromJson', () {
      test('should create User from valid JSON', () {
        // Arrange
        final json = {
          'id': '1',
          'name': 'John Doe',
          'email': 'john@example.com',
          'role': 'admin',
          'createdAt': '2023-01-01T10:00:00.000Z',
          'updatedAt': '2023-01-02T10:00:00.000Z',
          'photoURL': 'https://example.com/photo.jpg',
          'isGoogleUser': true,
        };

        // Act
        final user = User.fromJson(json);

        // Assert
        expect(user.id, equals('1'));
        expect(user.name, equals('John Doe'));
        expect(user.email, equals('john@example.com'));
        expect(user.role, equals('admin'));
        expect(user.createdAt, equals(DateTime.parse('2023-01-01T10:00:00.000Z')));
        expect(user.updatedAt, equals(DateTime.parse('2023-01-02T10:00:00.000Z')));
        expect(user.photoURL, equals('https://example.com/photo.jpg'));
        expect(user.isGoogleUser, equals(true));
      });

      test('should create User from minimal JSON', () {
        // Arrange
        final json = {
          'id': '1',
          'name': 'John Doe',
          'email': 'john@example.com',
          'role': 'user',
        };

        // Act
        final user = User.fromJson(json);

        // Assert
        expect(user.id, equals('1'));
        expect(user.name, equals('John Doe'));
        expect(user.email, equals('john@example.com'));
        expect(user.role, equals('user'));
        expect(user.createdAt, isNull);
        expect(user.updatedAt, isNull);
        expect(user.photoURL, isNull);
        expect(user.isGoogleUser, equals(false));
      });

      test('should handle empty or null values gracefully', () {
        // Arrange
        final json = {
          'id': '',
          'name': '',
          'email': '',
        };

        // Act
        final user = User.fromJson(json);

        // Assert
        expect(user.id, equals(''));
        expect(user.name, equals(''));
        expect(user.email, equals(''));
        expect(user.role, equals('user')); // Default value
        expect(user.isGoogleUser, equals(false)); // Default value
      });
    });

    group('toJson', () {
      test('should convert User to JSON correctly', () {
        // Arrange
        final user = User(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
          role: 'admin',
          createdAt: DateTime.parse('2023-01-01T10:00:00.000Z'),
          updatedAt: DateTime.parse('2023-01-02T10:00:00.000Z'),
          photoURL: 'https://example.com/photo.jpg',
          isGoogleUser: true,
        );

        // Act
        final json = user.toJson();

        // Assert
        expect(json['id'], equals('1'));
        expect(json['name'], equals('John Doe'));
        expect(json['email'], equals('john@example.com'));
        expect(json['role'], equals('admin'));
        expect(json['createdAt'], equals('2023-01-01T10:00:00.000Z'));
        expect(json['updatedAt'], equals('2023-01-02T10:00:00.000Z'));
        expect(json['photoURL'], equals('https://example.com/photo.jpg'));
        expect(json['isGoogleUser'], equals(true));
      });

      test('should convert User with null values to JSON correctly', () {
        // Arrange
        final user = User(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
          role: 'user',
        );

        // Act
        final json = user.toJson();

        // Assert
        expect(json['id'], equals('1'));
        expect(json['name'], equals('John Doe'));
        expect(json['email'], equals('john@example.com'));
        expect(json['role'], equals('user'));
        expect(json['createdAt'], isNull);
        expect(json['updatedAt'], isNull);
        expect(json['photoURL'], isNull);
        expect(json['isGoogleUser'], isNull);
      });
    });

    group('Constructor', () {
      test('should create User with required parameters', () {
        // Act
        final user = User(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
          role: 'user',
        );

        // Assert
        expect(user.id, equals('1'));
        expect(user.name, equals('John Doe'));
        expect(user.email, equals('john@example.com'));
        expect(user.role, equals('user'));
        expect(user.createdAt, isNull);
        expect(user.updatedAt, isNull);
        expect(user.photoURL, isNull);
        expect(user.isGoogleUser, isNull);
      });

      test('should create User with all parameters', () {
        // Arrange
        final createdAt = DateTime.now();
        final updatedAt = DateTime.now();

        // Act
        final user = User(
          id: '1',
          name: 'John Doe',
          email: 'john@example.com',
          role: 'admin',
          createdAt: createdAt,
          updatedAt: updatedAt,
          photoURL: 'https://example.com/photo.jpg',
          isGoogleUser: true,
        );

        // Assert
        expect(user.id, equals('1'));
        expect(user.name, equals('John Doe'));
        expect(user.email, equals('john@example.com'));
        expect(user.role, equals('admin'));
        expect(user.createdAt, equals(createdAt));
        expect(user.updatedAt, equals(updatedAt));
        expect(user.photoURL, equals('https://example.com/photo.jpg'));
        expect(user.isGoogleUser, equals(true));
      });
    });
  });
}