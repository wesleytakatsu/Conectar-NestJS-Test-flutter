import 'package:flutter/material.dart';

// Esta classe simula a view completa para isolar a barra de navegação
class NavbarOnlyTestView extends StatelessWidget {
  const NavbarOnlyTestView({super.key});

  @override
  Widget build(BuildContext context) {
    return const _TestNavbarContent();
  }
}

// O StatefulWidget para gerenciar o estado das abas
class _TestNavbarContent extends StatefulWidget {
  const _TestNavbarContent();

  @override
  State<_TestNavbarContent> createState() => __TestNavbarContentState();
}

class __TestNavbarContentState extends State<_TestNavbarContent> {
  // Estados para controlar as abas
  String _selectedPrimaryTab = 'Clientes'; // Aba principal (nível superior)
  String _selectedTab = 'Dados Básicos'; // Sub-aba (nível inferior)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Usamos PreferredSize para criar a barra de título estendida com múltiplas camadas
      appBar: PreferredSize(
        // Altura: 56 (AppBar) + 40 (Sub-abas) = 96
        preferredSize: const Size.fromHeight(96.0),
        child: Column(
          children: <Widget>[
            // 1. BARRA SUPERIOR VERDE (com navegação integrada)
            _buildGreenAppBar(),
            // 2. SUB-ABAS (Branca, com "Dados Básicos" selecionado)
            _buildTabBar(), 
          ],
        ),
      ),
      body: const Center(
        child: Text(
          'Corpo da View - Apenas para testes da Navbar',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildGreenAppBar() {
    return Container(
      height: kToolbarHeight,
      color: const Color(0xFF16A085),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: [
          const Text(
            'Conectar',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(width: 20),
          _buildPrimaryTabItem('Clientes'),
          _buildPrimaryTabItem('Pedidos'),
          const Spacer(),
          IconButton(icon: const Icon(Icons.help_outline, color: Colors.white), onPressed: () {}),
          IconButton(icon: const Icon(Icons.person_outline, color: Colors.white), onPressed: () {}),
          IconButton(icon: const Icon(Icons.exit_to_app, color: Colors.white), onPressed: () {}),
        ],
      ),
    );
  }

  // Widget para um item da aba de navegação principal (adaptado para fundo verde)
  Widget _buildPrimaryTabItem(String title) {
    final bool isSelected = title == _selectedPrimaryTab;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPrimaryTab = title;
          _selectedTab = (title == 'Clientes') ? 'Dados Básicos' : 'Detalhes'; // Atualiza a sub-aba
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 30.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? Colors.white : Colors.transparent,
              width: 3.0,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.white70,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  // Widget para a barra de sub-abas (Dados Básicos, etc.)
  Widget _buildTabBar() {
    // Só mostra as sub-abas se a aba principal for "Clientes"
    if (_selectedPrimaryTab != 'Clientes') {
      return Container(height: 40.0, color: Colors.white); // Mantém a altura para não saltar
    }
    
    return Container(
      height: 40.0, 
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      color: Colors.white, 
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildTabItem('Dados Básicos'), 
          _buildTabItem('Configurações'), // Exemplo de outra sub-aba
        ],
      ),
    );
  }

  // Widget para um item da sub-aba (com linha verde embaixo)
  Widget _buildTabItem(String title) {
    final bool isSelected = title == _selectedTab;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = title;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(right: 30.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? const Color(0xFF16A085) : Colors.transparent,
              width: 3.0,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? const Color(0xFF16A085) : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}