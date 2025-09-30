import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/users_controller.dart';
import '../../models/user.dart';
import '../forms/custom_text_field.dart';
import '../buttons/primary_button.dart';

class UserEditForm extends StatefulWidget {
  final User user;

  const UserEditForm({
    super.key,
    required this.user,
  });

  @override
  State<UserEditForm> createState() => _UserEditFormState();
}

class _UserEditFormState extends State<UserEditForm> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  String? _selectedRole;

  @override
  void initState() {
    super.initState();
    // Inicializar com dados do usuário
    nameController.text = widget.user.name;
    emailController.text = widget.user.email;
    _selectedRole = widget.user.role;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Editar Perfil',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          CustomTextField(
            label: 'Nome',

            controller: nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, insira um nome';
              }
              return null;
            },
          ),
          const SizedBox(height: 25),
          CustomTextField(
            label: 'Email',

            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            enabled: false, // Email não pode ser editado
          ),
          const SizedBox(height: 25),
          CustomTextField(
            label: 'Nova Senha (opcional)',
            hintText: '••••••••',
            controller: passwordController,
            obscureText: !_passwordVisible,
            suffixIcon: IconButton(
              icon: Icon(
                _passwordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey[600],
              ),
              onPressed: () {
                setState(() {
                  _passwordVisible = !_passwordVisible;
                });
              },
            ),
            validator: (value) {
              if (value != null && value.isNotEmpty && value.length < 6) {
                return 'A senha deve ter pelo menos 6 caracteres';
              }
              return null;
            },
          ),
          const SizedBox(height: 25),
          CustomTextField(
            label: 'Confirmar Nova Senha',
            hintText: '••••••••',
            controller: confirmPasswordController,
            obscureText: !_confirmPasswordVisible,
            suffixIcon: IconButton(
              icon: Icon(
                _confirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey[600],
              ),
              onPressed: () {
                setState(() {
                  _confirmPasswordVisible = !_confirmPasswordVisible;
                });
              },
            ),
            validator: (value) {
              if (passwordController.text.isNotEmpty) {
                if (value != passwordController.text) {
                  return 'As senhas não coincidem';
                }
              }
              return null;
            },
          ),
          // Campo de Role - apenas visível para admins
          Consumer<AuthController>(
            builder: (context, authController, child) {
              final currentUser = authController.currentUser;
              if (currentUser?.role == 'admin') {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 25),
                    const Text(
                      'Tipo de Usuário',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[400]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _selectedRole,
                          hint: const Text('Selecione o tipo de usuário'),
                          isExpanded: true,
                          items: const [
                            DropdownMenuItem(
                              value: 'user',
                              child: Text('Usuário'),
                            ),
                            DropdownMenuItem(
                              value: 'admin',
                              child: Text('Administrador'),
                            ),
                          ],
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedRole = newValue;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: _isLoading ? null : () => context.go('/profile'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[400],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: PrimaryButton(
                  text: 'Salvar Alterações',
                  onPressed: _isLoading ? () {} : () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isLoading = true;
                      });
                      
                      try {
                        final authController = context.read<AuthController>();
                        final usersController = context.read<UsersController>();
                        final currentUser = authController.currentUser;
                        
                        // Preparar dados para atualização
                        final userData = <String, dynamic>{
                          'name': nameController.text.trim(),
                        };
                        
                        // Incluir senha apenas se foi informada
                        if (passwordController.text.isNotEmpty) {
                          userData['password'] = passwordController.text.trim();
                        }
                        
                        // Se o usuário logado é admin e está editando outro usuário,
                        // incluir a role e usar UsersController
                        if (currentUser?.role == 'admin' && currentUser?.id != widget.user.id) {
                          if (_selectedRole != null) {
                            userData['role'] = _selectedRole;
                          }
                          
                          // Criar objeto User atualizado
                          final updatedUser = User(
                            id: widget.user.id,
                            name: userData['name'],
                            email: widget.user.email,
                            role: userData['role'] ?? widget.user.role,
                            createdAt: widget.user.createdAt,
                            updatedAt: widget.user.updatedAt,
                            photoURL: widget.user.photoURL,
                            isGoogleUser: widget.user.isGoogleUser,
                          );
                          
                          // Atualizar usuário via UsersController
                          await usersController.updateUser(widget.user.id, updatedUser);
                        } else {
                          // Atualizando o próprio perfil via AuthController
                          await authController.updateProfile(userData);
                        }
                        
                        if (mounted) {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Usuário atualizado com sucesso!'),
                              backgroundColor: Color(0xFF16A085),
                            ),
                          );
                          // ignore: use_build_context_synchronously
                          context.go('/users');
                        }
                      } catch (e) {
                        if (mounted) {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Erro ao salvar: ${e.toString()}'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      } finally {
                        if (mounted) {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      }
                    }
                  },
                  isFullWidth: true,
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}