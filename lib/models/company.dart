class Company {
  final String id;
  final String razaoSocial;
  final String? nomeFantasia;
  final String cnpj;
  final String? email;
  final String? telefone;
  final String? endereco;
  final String? cidade;
  final String? estado;
  final String? cep;
  final String status;
  final bool conectaPlus;
  final DateTime createdAt;
  final DateTime updatedAt;

  Company({
    required this.id,
    required this.razaoSocial,
    this.nomeFantasia,
    required this.cnpj,
    this.email,
    this.telefone,
    this.endereco,
    this.cidade,
    this.estado,
    this.cep,
    required this.status,
    required this.conectaPlus,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      razaoSocial: json['razaoSocial'],
      nomeFantasia: json['nomeFantasia'],
      cnpj: json['cnpj'],
      email: json['email'],
      telefone: json['telefone'],
      endereco: json['endereco'],
      cidade: json['cidade'],
      estado: json['estado'],
      cep: json['cep'],
      status: json['status'] ?? 'ativo',
      conectaPlus: json['conectaPlus'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'razaoSocial': razaoSocial,
      'nomeFantasia': nomeFantasia,
      'cnpj': cnpj,
      'email': email,
      'telefone': telefone,
      'endereco': endereco,
      'cidade': cidade,
      'estado': estado,
      'cep': cep,
      'status': status,
      'conectaPlus': conectaPlus,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Company copyWith({
    String? id,
    String? razaoSocial,
    String? nomeFantasia,
    String? cnpj,
    String? email,
    String? telefone,
    String? endereco,
    String? cidade,
    String? estado,
    String? cep,
    String? status,
    bool? conectaPlus,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Company(
      id: id ?? this.id,
      razaoSocial: razaoSocial ?? this.razaoSocial,
      nomeFantasia: nomeFantasia ?? this.nomeFantasia,
      cnpj: cnpj ?? this.cnpj,
      email: email ?? this.email,
      telefone: telefone ?? this.telefone,
      endereco: endereco ?? this.endereco,
      cidade: cidade ?? this.cidade,
      estado: estado ?? this.estado,
      cep: cep ?? this.cep,
      status: status ?? this.status,
      conectaPlus: conectaPlus ?? this.conectaPlus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}