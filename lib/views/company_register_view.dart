import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../controllers/company_controller.dart';
import '../widgets/widgets.dart';

class CompanyRegisterView extends StatefulWidget {
  const CompanyRegisterView({super.key});

  @override
  CompanyRegisterViewState createState() => CompanyRegisterViewState();
}

class CompanyRegisterViewState extends State<CompanyRegisterView> {
  bool _isLoading = false;

  void _showSnackBar(String message, {bool isError = false}) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: isError ? Colors.red : Colors.green,
        ),
      );
    }
  }

  Future<void> _handleRegister({
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
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final companyController = context.read<CompanyController>();
      final success = await companyController.createCompany(
        razaoSocial: razaoSocial,
        nomeFantasia: nomeFantasia,
        cnpj: cnpj,
        email: email,
        telefone: telefone,
        endereco: endereco,
        cidade: cidade,
        estado: estado,
        cep: cep,
        status: status ?? 'ativo',
        conectaPlus: conectaPlus ?? false,
      );

      if (success) {
        _showSnackBar('Empresa criada com sucesso!');
        
        // Aguardar um momento para o usuário ver a mensagem
        await Future.delayed(const Duration(milliseconds: 1500));
        
        // Redirecionar para a lista de usuários/clientes
        if (mounted) {
          context.go('/users');
        }
      } else {
        String errorMessage = companyController.error ?? 'Erro ao criar empresa. Tente novamente.';
        
        // Tratar diferentes tipos de erro
        final errorString = errorMessage.toLowerCase();
        if (errorString.contains('cnpj')) {
          if (errorString.contains('já cadastrado')) {
            errorMessage = 'Este CNPJ já está cadastrado. Use outro CNPJ.';
          } else {
            errorMessage = 'CNPJ inválido. Verifique o formato do CNPJ.';
          }
        } else if (errorString.contains('dados inválidos')) {
          errorMessage = 'Dados inválidos. Verifique os campos obrigatórios.';
        } else if (errorString.contains('administrador')) {
          errorMessage = 'Apenas administradores podem criar empresas.';
        }
        
        _showSnackBar(errorMessage, isError: true);
      }
    } catch (e) {
      _showSnackBar('Erro inesperado ao criar empresa. Tente novamente.', isError: true);
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
      appBar: AppBar(
        backgroundColor: const Color(0xFF16A085),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/home'),
        ),
        title: const Text(
          'Cadastrar Empresa',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
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
                      const Padding(
                        padding: EdgeInsets.only(bottom: 30.0),
                        child: ConectarLogo(),
                      ),
                      CompanyRegisterCard(
                        maxWidth: formWidth,
                        onRegister: _handleRegister,
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