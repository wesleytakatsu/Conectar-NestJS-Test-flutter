import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../controllers/auth_controller.dart';
import '../controllers/company_controller.dart';
import '../models/company.dart';
import '../widgets/widgets.dart';

class CompaniesListView extends StatefulWidget {
  const CompaniesListView({super.key});

  @override
  CompaniesListViewState createState() => CompaniesListViewState();
}

class CompaniesListViewState extends State<CompaniesListView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController cnpjController = TextEditingController();
  String? selectedStatus;
  String? selectedConectaPlus;
  String _selectedTab = 'Dados Básicos';
  String _selectedPrimaryTab = 'Clientes';

  @override
  void initState() {
    super.initState();
    _loadCompanies();
  }

  void _loadCompanies() {
    final companyController = context.read<CompanyController>();
    companyController.loadCompanies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Consumer2<AuthController, CompanyController>(
        builder: (context, authController, companyController, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CompanyFilterCard(
                  nameController: nameController,
                  cnpjController: cnpjController,
                  selectedStatus: selectedStatus,
                  selectedConectaPlus: selectedConectaPlus,
                  onStatusChanged: (value) => setState(() => selectedStatus = value),
                  onConectaPlusChanged: (value) => setState(() => selectedConectaPlus = value),
                  onFilter: _onFilter,
                  onClear: _onClear,
                ),
                const SizedBox(height: 20),
                CompaniesTable(
                  companies: companyController.companies,
                  onCompanySelected: _onCompanySelected,
                  onNewCompany: _onNewCompany,
                  isLoading: companyController.isLoading,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(96.0),
      child: Column(
        children: <Widget>[
          _buildGreenAppBar(),
          CustomTabBar(
            tabs: const ['Dados Básicos'],
            selectedTab: _selectedTab,
            onTabSelected: (tab) {
              setState(() {
                _selectedTab = tab;
              });
            },
          ),
        ],
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
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => context.go('/home'),
          ),
          ColorFiltered(
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
            child: Image.asset(
              'assets/images/logo_menu.png',
              height: 30,
            ),
          ),
          const SizedBox(width: 20),
          _buildPrimaryTabItem('Clientes'),
          _buildPrimaryTabItem('Usuários'),
          const Spacer(),
          IconButton(icon: const Icon(Icons.help_outline, color: Colors.white), onPressed: () {}),
          IconButton(icon: const Icon(Icons.person_outline, color: Colors.white), onPressed: () {}),
          IconButton(icon: const Icon(Icons.exit_to_app, color: Colors.white), onPressed: () {}),
        ],
      ),
    );
  }

  Widget _buildPrimaryTabItem(String title) {
    final bool isSelected = title == _selectedPrimaryTab;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPrimaryTab = title;
        });
        if (title == 'Usuários') {
          context.go('/users');
        }
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

  void _onFilter() {
    final companyController = context.read<CompanyController>();
    String? statusFilter;
    bool? conectaPlusFilter;
    String? searchQuery;

    if (selectedStatus != null) {
      statusFilter = selectedStatus!.toLowerCase();
    }

    if (selectedConectaPlus != null) {
      conectaPlusFilter = selectedConectaPlus == 'Sim';
    }

    List<String> searchTerms = [];

    if (nameController.text.isNotEmpty) {
      searchTerms.add(nameController.text.trim());
    }

    if (cnpjController.text.isNotEmpty) {
      final cnpjClean = cnpjController.text.replaceAll(RegExp(r'[^0-9]'), '');
      if (cnpjClean.isNotEmpty) {
        searchTerms.add(cnpjClean);
      }
    }

    if (searchTerms.isNotEmpty) {
      searchQuery = searchTerms.first;
    }

    companyController.loadCompanies(
      status: statusFilter,
      conectaPlus: conectaPlusFilter,
      search: searchQuery,
    );

    String message = 'Filtros aplicados com sucesso!';
    if (searchQuery != null) {
      message = 'Buscando por: "$searchQuery"';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF16A085),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _onClear() {
    setState(() {
      nameController.clear();
      cnpjController.clear();
      selectedStatus = null;
      selectedConectaPlus = null;
    });
    _loadCompanies();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Filtros limpos! Exibindo todas as empresas.'),
        backgroundColor: Colors.blue,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _onCompanySelected(Company company) {
    context.go('/company-edit/${company.id}');
  }

  void _onNewCompany() {
    context.go('/company-register');
  }
}