import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../controllers/company_controller.dart';
import '../models/company.dart';
import '../widgets/widgets.dart';

class CompanyEditView extends StatefulWidget {
  final String companyId;
  
  const CompanyEditView({
    super.key,
    required this.companyId,
  });

  @override
  CompanyEditViewState createState() => CompanyEditViewState();
}

class CompanyEditViewState extends State<CompanyEditView> {
  bool _isLoading = false;
  Company? _company;

  @override
  void initState() {
    super.initState();
    _loadCompany();
  }

  void _loadCompany() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final companyController = context.read<CompanyController>();
      final company = await companyController.getCompany(widget.companyId);
      
      if (company != null) {
        setState(() {
          _company = company;
        });
      } else {
        _showSnackBar('Empresa não encontrada.', isError: true);
        if (mounted) context.go('/companies');
      }
    } catch (e) {
      _showSnackBar('Erro ao carregar empresa.', isError: true);
      if (mounted) context.go('/companies');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showSnackBar(String message, {bool isError = false}) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? Colors.red : Colors.green,
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

  Future<void> _handleUpdate({
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
    if (_isLoading || _company == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final companyController = context.read<CompanyController>();
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

      final success = await companyController.updateCompany(_company!.id, companyData);

      if (success) {
        _showSnackBar('Empresa atualizada com sucesso!');
        
        // Aguardar um momento para o usuário ver a mensagem
        await Future.delayed(const Duration(milliseconds: 1500));
        
        if (mounted) {
          context.go('/companies');
        }
      } else {
        String errorMessage = companyController.error ?? 'Erro ao atualizar empresa. Tente novamente.';
        
        final errorString = errorMessage.toLowerCase();
        if (errorString.contains('cnpj')) {
          if (errorString.contains('já cadastrado')) {
            errorMessage = 'Este CNPJ já está cadastrado por outra empresa.';
          } else {
            errorMessage = 'CNPJ inválido. Verifique o formato do CNPJ.';
          }
        } else if (errorString.contains('dados inválidos')) {
          errorMessage = 'Dados inválidos. Verifique os campos obrigatórios.';
        } else if (errorString.contains('administrador')) {
          errorMessage = 'Apenas administradores podem editar empresas.';
        } else if (errorString.contains('não encontrada')) {
          errorMessage = 'Empresa não encontrada.';
        }
        
        _showSnackBar(errorMessage, isError: true);
      }
    } catch (e) {
      _showSnackBar('Erro inesperado ao atualizar empresa. Tente novamente.', isError: true);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF16A085),
      body: Stack(
        children: [
          if (_company != null)
            Center(
              child: SingleChildScrollView(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final double formWidth = constraints.maxWidth > 800 
                        ? 600 
                        : constraints.maxWidth * 0.9;

                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30.0),
                          child: ConectarLogo(),
                        ),
                        CompanyEditCard(
                          maxWidth: formWidth,
                          company: _company!,
                          onUpdate: _handleUpdate,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          if (_isLoading)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF16A085)),
                ),
              ),
            ),
        ],
      ),
    );
  }
}