import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../controllers/auth_controller.dart';
import '../controllers/users_controller.dart';
import '../models/user.dart';
import '../widgets/widgets.dart';

class UsersListView extends StatefulWidget {
  const UsersListView({super.key});

  @override
  UsersListViewState createState() => UsersListViewState();
}

class UsersListViewState extends State<UsersListView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  String? selectedRole;
  String _selectedTab = 'Dados Básicos';
  String _selectedPrimaryTab = 'Usuários';
  
  List<User> _allUsers = [];
  List<User> _filteredUsers = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  void _loadUsers() async {
    final usersController = context.read<UsersController>();
    await usersController.fetchUsers();
    setState(() {
      _allUsers = List.from(usersController.users);
      _filteredUsers = List.from(_allUsers);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Consumer2<AuthController, UsersController>(
        builder: (context, authController, usersController, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                UserFilterCard(
                  nameController: nameController,
                  emailController: emailController,
                  startDateController: startDateController,
                  endDateController: endDateController,
                  selectedRole: selectedRole,
                  onRoleChanged: (value) => setState(() => selectedRole = value),
                  onFilter: _onFilter,
                  onClear: _onClear,
                ),
                const SizedBox(height: 20),
                UsersTable(
                  users: _filteredUsers.isNotEmpty || _allUsers.isEmpty ? _filteredUsers : usersController.users,
                  onUserSelected: _onUserSelected,
                  onNewUser: _onNewUser,
                  isLoading: usersController.isLoading,
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
        children: [
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
        if (title == 'Clientes') {
          context.go('/companies');
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
    setState(() {
      _filteredUsers = _allUsers.where((user) {
        if (nameController.text.isNotEmpty) {
          if (!user.name.toLowerCase().contains(nameController.text.toLowerCase())) {
            return false;
          }
        }
        
        if (emailController.text.isNotEmpty) {
          if (!user.email.toLowerCase().contains(emailController.text.toLowerCase())) {
            return false;
          }
        }
        
        if (selectedRole != null) {
          if (user.role != selectedRole) {
            return false;
          }
        }
        
        if (startDateController.text.isNotEmpty && user.createdAt != null) {
          final startDate = _parseDate(startDateController.text);
          if (startDate != null && user.createdAt!.isBefore(startDate)) {
            return false;
          }
        }
        
        if (endDateController.text.isNotEmpty && user.createdAt != null) {
          final endDate = _parseDate(endDateController.text);
          if (endDate != null && user.createdAt!.isAfter(endDate.add(const Duration(days: 1)))) {
            return false;
          }
        }
        
        return true;
      }).toList();
    });
  }

  void _onClear() {
    setState(() {
      nameController.clear();
      emailController.clear();
      startDateController.clear();
      endDateController.clear();
      selectedRole = null;
      _filteredUsers = List.from(_allUsers);
    });
  }

  DateTime? _parseDate(String dateString) {
    try {
      final parts = dateString.split('/');
      if (parts.length == 3) {
        final day = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final year = int.parse(parts[2]);
        return DateTime(year, month, day);
      }
    } catch (e) {
      // Ignore parsing errors
    }
    return null;
  }

  void _onUserSelected(User user) {
    context.go('/user-edit/${user.id}');
  }

  void _onNewUser() {
    context.go('/user-form');
  }
}