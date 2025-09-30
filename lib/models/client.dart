class Client {
  final String razaoSocial;
  final String cnpj;
  final String nomeFachada;
  final String tags;
  final String status;
  final String conectaPlus;

  Client({
    required this.razaoSocial,
    required this.cnpj,
    required this.nomeFachada,
    this.tags = '',
    required this.status,
    required this.conectaPlus,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      razaoSocial: json['razaoSocial'] ?? '',
      cnpj: json['cnpj'] ?? '',
      nomeFachada: json['nomeFachada'] ?? '',
      tags: json['tags'] ?? '',
      status: json['status'] ?? '',
      conectaPlus: json['conectaPlus'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'razaoSocial': razaoSocial,
      'cnpj': cnpj,
      'nomeFachada': nomeFachada,
      'tags': tags,
      'status': status,
      'conectaPlus': conectaPlus,
    };
  }
}