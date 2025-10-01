import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/auth_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Conectar',
          style: GoogleFonts.openSans(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        backgroundColor: const Color(0xFF16A085),
        foregroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              context.read<AuthController>().logout();
            },
            tooltip: 'Sair',
          )
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF16A085),
              Color(0xFF1ABC9C),
            ],
          ),
        ),
        child: Column(
          children: <Widget>[
          LayoutBuilder(
            builder: (context, constraints) {
              double screenWidth = constraints.maxWidth;
              bool isMobile = screenWidth < 600;
              
              return Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 24,
                  vertical: isMobile ? 16 : 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Consumer<AuthController>(
                            builder: (context, authController, child) => Text(
                              'Olá, ${authController.currentUser?.name ?? 'Usuário'}!',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: isMobile ? 16 : 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Consumer<AuthController>(
                            builder: (context, authController, child) => Text(
                              authController.currentUser?.role == 'admin' 
                                  ? 'Conta Administrativa' 
                                  : 'Conta de Usuário',
                              style: GoogleFonts.openSans(
                                textStyle: TextStyle(
                                  color: const Color(0xFFB8E6D3),
                                  fontSize: isMobile ? 12 : 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.notifications_outlined,
                          color: Colors.white,
                          size: isMobile ? 20 : 24,
                        ),
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Nenhuma notificação no momento'),
                              backgroundColor: const Color(0xFF0D7E66),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                        },
                        tooltip: 'Notificações',
                      ),
                    )
                  ],
                ),
              );
            },
          ),
            const SizedBox(height: 20),
            const Expanded(child: DashboardGrid())
          ],
        ),
      ),
    );
  }
}

// Grid de botões do dashboard
class DashboardGrid extends StatefulWidget {
  const DashboardGrid({super.key});

  @override
  State<DashboardGrid> createState() => _DashboardGridState();
}

class _DashboardGridState extends State<DashboardGrid> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, authController, child) {
        List<DashboardItem> items = [
          DashboardItem(
            title: 'Meu Perfil',
            subtitle: 'Gerenciar informações pessoais',
            event: '',
            icon: Icons.person,
            onTap: () => context.go('/profile'),
          ),
        ];

        // Adicionar itens específicos para administradores
        if (authController.currentUser?.role == 'admin') {
          items.addAll([
             DashboardItem(
              title: 'Clientes',
              subtitle: 'Visualizar empresas cadastradas',
              event: '',
              icon: Icons.business,
              onTap: () => context.go('/companies'),
            ),
            DashboardItem(
              title: 'Usuários',
              subtitle: 'Gerenciar usuários do sistema',
              event: '',
              icon: Icons.people,
              onTap: () => context.go('/users'),
            ),
            DashboardItem(
              title: 'Novo Cliente',
              subtitle: 'Cadastrar nova empresa',
              event: '',
              icon: Icons.add_business,
              onTap: () => context.go('/company-register'),
            ),
          ]);
        }

        // Adicionar itens adicionais para completar o grid
        items.addAll([
          DashboardItem(
            title: 'Relatórios',
            subtitle: 'Visualizar dados e métricas',
            event: 'Botão só de enfeite para estilizar',
            icon: Icons.assessment,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Funcionalidade em desenvolvimento'),
                ),
              );
            },
          ),
          DashboardItem(
            title: 'Configurações',
            subtitle: 'Preferências do sistema',
            event: 'Botão só de enfeite para estilizar',
            icon: Icons.settings,
            onTap: () => context.go('/navbar-test'), // Temporário para demonstração
          ),
        ]);

        return LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount;
            double maxWidth = constraints.maxWidth;
            
            if (maxWidth > 1200) {
              crossAxisCount = 4; // Desktop grande
            } else if (maxWidth > 800) {
              crossAxisCount = 3; // Desktop/Tablet
            } else if (maxWidth > 600) {
              crossAxisCount = 2; // Tablet pequeno
            } else {
              crossAxisCount = 2; // Mobile
            }

            // Calcular padding responsivo
            double horizontalPadding = maxWidth > 600 ? 24 : 16;
            
            return GridView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 16,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: maxWidth > 600 ? 20 : 12,
                mainAxisSpacing: maxWidth > 600 ? 20 : 12,
                childAspectRatio: maxWidth > 600 ? 1.1 : 1.0,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final data = items[index];
                return _buildDashboardCard(data, maxWidth);
              },
            );
          },
        );
      },
    );
  }

  Widget _buildDashboardCard(DashboardItem data, double screenWidth) {
    // Definir tamanhos baseados na largura da tela
    double iconSize = screenWidth > 600 ? 40 : 32;
    double titleFontSize = screenWidth > 600 ? 16 : 14;
    double subtitleFontSize = screenWidth > 600 ? 12 : 10;
    double eventFontSize = screenWidth > 600 ? 11 : 9;
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: data.onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xFF0D7E66),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(screenWidth > 600 ? 16 : 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  data.icon,
                  size: iconSize,
                  color: Colors.white,
                ),
                SizedBox(height: screenWidth > 600 ? 12 : 8),
                Text(
                  data.title,
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenWidth > 600 ? 6 : 4),
                Flexible(
                  child: Text(
                    data.subtitle,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                        color: Colors.white70,
                        fontSize: subtitleFontSize,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (data.event.isNotEmpty) ...[
                  SizedBox(height: screenWidth > 600 ? 8 : 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      data.event,
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: eventFontSize,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Classe modelo para os itens do dashboard
class DashboardItem {
  final String title;
  final String subtitle;
  final String event;
  final IconData icon;
  final VoidCallback onTap;

  DashboardItem({
    required this.title,
    required this.subtitle,
    required this.event,
    required this.icon,
    required this.onTap,
  });
}