import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../models/company.dart';

class CompanyEditCard extends StatefulWidget {
  final double maxWidth;
  final Company company;
  final Future<void> Function({
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
  }) onUpdate;

  const CompanyEditCard({
    super.key,
    required this.maxWidth,
    required this.company,
    required this.onUpdate,
  });

  @override
  CompanyEditCardState createState() => CompanyEditCardState();
}

class CompanyEditCardState extends State<CompanyEditCard> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _razaoSocialController;
  late final TextEditingController _nomeFantasiaController;
  late final TextEditingController _cnpjController;
  late final TextEditingController _emailController;
  late final TextEditingController _telefoneController;
  late final TextEditingController _enderecoController;
  late final TextEditingController _cidadeController;
  late final TextEditingController _estadoController;
  late final TextEditingController _cepController;
  
  late String _selectedStatus;
  late bool _conectaPlus;

  @override
  void initState() {
    super.initState();
    
    // Inicializar os controllers com os dados da empresa
    _razaoSocialController = TextEditingController(text: widget.company.razaoSocial);
    _nomeFantasiaController = TextEditingController(text: widget.company.nomeFantasia ?? '');
    _cnpjController = TextEditingController(text: widget.company.cnpj);
    _emailController = TextEditingController(text: widget.company.email ?? '');
    _telefoneController = TextEditingController(text: widget.company.telefone ?? '');
    _enderecoController = TextEditingController(text: widget.company.endereco ?? '');
    _cidadeController = TextEditingController(text: widget.company.cidade ?? '');
    _estadoController = TextEditingController(text: widget.company.estado ?? '');
    _cepController = TextEditingController(text: widget.company.cep ?? '');
    
    _selectedStatus = widget.company.status;
    _conectaPlus = widget.company.conectaPlus;
  }

  @override
  void dispose() {
    _razaoSocialController.dispose();
    _nomeFantasiaController.dispose();
    _cnpjController.dispose();
    _emailController.dispose();
    _telefoneController.dispose();
    _enderecoController.dispose();
    _cidadeController.dispose();
    _estadoController.dispose();
    _cepController.dispose();
    super.dispose();
  }

  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName é obrigatório.';
    }
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    const emailRegex = r'^[^@]+@[^@]+\.[^@]+$';
    if (!RegExp(emailRegex).hasMatch(value.trim())) {
      return 'Email inválido.';
    }
    return null;
  }

  String? _validateCNPJ(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'CNPJ é obrigatório.';
    }
    final cnpjNumbers = value.replaceAll(RegExp(r'[^0-9]'), '');
    if (cnpjNumbers.length != 14) {
      return 'CNPJ deve conter 14 dígitos.';
    }
    return null;
  }

  void _formatCNPJ() {
    String digitsOnly = _cnpjController.text.replaceAll(RegExp(r'[^0-9]'), '');
    
    // Limita a 14 dígitos
    if (digitsOnly.length > 14) {
      digitsOnly = digitsOnly.substring(0, 14);
    }
    
    String formattedText;
    
    // Aplica máscara apenas se tiver exatamente 14 dígitos
    if (digitsOnly.length == 14) {
      formattedText = '${digitsOnly.substring(0, 2)}.${digitsOnly.substring(2, 5)}.${digitsOnly.substring(5, 8)}/${digitsOnly.substring(8, 12)}-${digitsOnly.substring(12, 14)}';
    } else {
      // Se não tiver 14 dígitos, mostra apenas os números
      formattedText = digitsOnly;
    }
    
    _cnpjController.value = _cnpjController.value.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }

  void _formatCEP() {
    String text = _cepController.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (text.length <= 8) {
      if (text.length >= 5) {
        text = '${text.substring(0, 5)}-${text.substring(5)}';
      }
      _cepController.value = _cepController.value.copyWith(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    }
  }

  void _formatTelefone() {
    String text = _telefoneController.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (text.length <= 11) {
      if (text.length >= 2) {
        text = '(${text.substring(0, 2)}) ${text.substring(2)}';
      }
      if (text.length >= 10) {
        if (text.length == 14) { // (XX) 9XXXX-XXXX
          text = '${text.substring(0, 10)}-${text.substring(10)}';
        } else if (text.length == 13) { // (XX) XXXX-XXXX
          text = '${text.substring(0, 9)}-${text.substring(9)}';
        }
      }
      _telefoneController.value = _telefoneController.value.copyWith(
        text: text,
        selection: TextSelection.collapsed(offset: text.length),
      );
    }
  }

  Future<void> _handleSubmit() async {
    if (_formKey.currentState?.validate() ?? false) {
      await widget.onUpdate(
        razaoSocial: _razaoSocialController.text.trim(),
        nomeFantasia: _nomeFantasiaController.text.trim().isNotEmpty 
            ? _nomeFantasiaController.text.trim() 
            : null,
        cnpj: _cnpjController.text.trim(),
        email: _emailController.text.trim().isNotEmpty 
            ? _emailController.text.trim() 
            : null,
        telefone: _telefoneController.text.trim().isNotEmpty 
            ? _telefoneController.text.trim() 
            : null,
        endereco: _enderecoController.text.trim().isNotEmpty 
            ? _enderecoController.text.trim() 
            : null,
        cidade: _cidadeController.text.trim().isNotEmpty 
            ? _cidadeController.text.trim() 
            : null,
        estado: _estadoController.text.trim().isNotEmpty 
            ? _estadoController.text.trim() 
            : null,
        cep: _cepController.text.trim().isNotEmpty 
            ? _cepController.text.trim() 
            : null,
        status: _selectedStatus,
        conectaPlus: _conectaPlus,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: widget.maxWidth),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Editar Empresa',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF16A085),
                  ),
                ),
                const SizedBox(height: 32),
                
                // Razão Social
                TextFormField(
                  controller: _razaoSocialController,
                  decoration: const InputDecoration(
                    labelText: 'Razão Social *',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => _validateRequired(value, 'Razão Social'),
                ),
                const SizedBox(height: 16),

                // Nome Fantasia
                TextFormField(
                  controller: _nomeFantasiaController,
                  decoration: const InputDecoration(
                    labelText: 'Nome Fantasia',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // CNPJ
                TextFormField(
                  controller: _cnpjController,
                  decoration: const InputDecoration(
                    labelText: 'CNPJ *',
                    border: OutlineInputBorder(),
                    hintText: 'XX.XXX.XXX/XXXX-XX',
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (_) => _formatCNPJ(),
                  validator: _validateCNPJ,
                ),
                const SizedBox(height: 16),

                // Email
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                ),
                const SizedBox(height: 16),

                // Telefone
                TextFormField(
                  controller: _telefoneController,
                  decoration: const InputDecoration(
                    labelText: 'Telefone',
                    border: OutlineInputBorder(),
                    hintText: '(XX) XXXXX-XXXX',
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (_) => _formatTelefone(),
                ),
                const SizedBox(height: 16),

                // Endereço
                TextFormField(
                  controller: _enderecoController,
                  decoration: const InputDecoration(
                    labelText: 'Endereço',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Cidade e Estado
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        controller: _cidadeController,
                        decoration: const InputDecoration(
                          labelText: 'Cidade',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _estadoController,
                        decoration: const InputDecoration(
                          labelText: 'Estado',
                          border: OutlineInputBorder(),
                          hintText: 'SP',
                        ),
                        textCapitalization: TextCapitalization.characters,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(2),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // CEP
                TextFormField(
                  controller: _cepController,
                  decoration: const InputDecoration(
                    labelText: 'CEP',
                    border: OutlineInputBorder(),
                    hintText: 'XXXXX-XXX',
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (_) => _formatCEP(),
                ),
                const SizedBox(height: 16),

                // Status
                DropdownButtonFormField<String>(
                  initialValue: _selectedStatus,
                  decoration: const InputDecoration(
                    labelText: 'Status *',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'ativo', child: Text('Ativo')),
                    DropdownMenuItem(value: 'inativo', child: Text('Inativo')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedStatus = value!;
                    });
                  },
                ),
                const SizedBox(height: 16),

                // Conecta Plus
                CheckboxListTile(
                  title: const Text('Conecta Plus'),
                  value: _conectaPlus,
                  onChanged: (value) {
                    setState(() {
                      _conectaPlus = value ?? false;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
                const SizedBox(height: 32),

                // Botões
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => context.go('/companies'),
                        child: const Text('Cancelar'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _handleSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF16A085),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Salvar Alterações'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}