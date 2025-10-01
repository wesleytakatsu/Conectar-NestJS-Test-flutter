import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../models/user.dart';
import '../buttons/primary_button.dart';

class ProfileCard extends StatelessWidget {
  final User user;

  const ProfileCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Meu Perfil',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 30),
        // Avatar/Foto de perfil
        Center(
          child: Column(
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF16A085),
                    width: 3,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: _buildProfileImage(),
                ),
              ),
              const SizedBox(height: 12),
              // Mensagem explicativa sobre foto do Google
              if (_shouldShowGooglePhotoMessage())
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.blue.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.info_outline,
                        size: 16,
                        color: Colors.blue[700],
                      ),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          'Se você fez login com Google e possui foto, ela será exibida aqui',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.blue[700],
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        // Cartão de informações
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey[300]!,
            ),
          ),
          child: Column(
            children: [
              _buildInfoRow(
                icon: Icons.person,
                label: 'Nome',
                value: user.name,
              ),
              const Divider(height: 32),
              _buildInfoRow(
                icon: Icons.email,
                label: 'Email',
                value: user.email,
              ),
              const Divider(height: 32),
              _buildInfoRow(
                icon: Icons.admin_panel_settings,
                label: 'Perfil',
                value: _getRoleDisplayName(user.role),
              ),
              const Divider(height: 32),
              _buildInfoRow(
                icon: Icons.calendar_today,
                label: 'Membro desde',
                value: _formatDate(user.createdAt),
              ),
              if (user.isGoogleUser == true) ...[
                const Divider(height: 32),
                _buildInfoRow(
                  icon: Icons.g_mobiledata,
                  label: 'Conta Google',
                  value: 'Vinculada',
                  valueColor: const Color(0xFF16A085),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 40),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => context.go('/home'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[400],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Voltar',
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
                text: 'Editar Perfil',
                onPressed: () => context.go('/user-form'),
                isFullWidth: true,
                padding: const EdgeInsets.symmetric(vertical: 18.0),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProfileImage() {
    // Verificar se existe photoURL e não está vazia
    if (user.photoURL != null && user.photoURL!.isNotEmpty) {
      // Para URLs do Google, usar uma abordagem mais simples
      String imageUrl = user.photoURL!;
      
      // Se for URL do Google, tentar uma versão mais confiável
      if (imageUrl.contains('googleusercontent.com') && imageUrl.contains('=s')) {
        // Remover parâmetros de tamanho e adicionar parâmetro circular
        imageUrl = '${imageUrl.split('=')[0]}=s96-c';
      }
      
      return CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        httpHeaders: const {
          'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
          'Accept': 'image/*,*/*;q=0.8',
        },
        placeholder: (context, url) => Container(
          color: const Color(0xFF16A085),
          child: const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeWidth: 2,
            ),
          ),
        ),
        errorWidget: (context, url, error) {
          // Mostrar avatar padrão com indicador visual de que é usuário Google
          return Stack(
            children: [
              _buildDefaultAvatar(user.name),
              if (user.isGoogleUser == true)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.g_mobiledata,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                ),
            ],
          );
        },
      );
    }
    
    return _buildDefaultAvatar(user.name);
  }

  Widget _buildDefaultAvatar(String name) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : 'U';
    return Container(
      width: 100,
      height: 100,
      color: const Color(0xFF16A085),
      child: Center(
        child: Text(
          initial,
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  bool _shouldShowGooglePhotoMessage() {
    // Mostra a mensagem apenas se não tem foto disponível
    bool hasValidPhoto = user.photoURL != null && user.photoURL!.isNotEmpty;
    
    // Só mostra a mensagem se não tem foto válida
    return !hasValidPhoto;
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF16A085).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF16A085),
            size: 20,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  color: valueColor ?? const Color(0xFF333333),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getRoleDisplayName(String role) {
    switch (role.toLowerCase()) {
      case 'admin':
        return 'Administrador';
      case 'user':
        return 'Usuário';
      default:
        return role;
    }
  }

  String _formatDate(DateTime? dateTime) {
    if (dateTime == null) {
      return 'Data não disponível';
    }
    
    try {
      final months = [
        'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
        'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'
      ];
      
      return '${dateTime.day} de ${months[dateTime.month - 1]} de ${dateTime.year}';
    } catch (e) {
      return 'Data inválida';
    }
  }
}