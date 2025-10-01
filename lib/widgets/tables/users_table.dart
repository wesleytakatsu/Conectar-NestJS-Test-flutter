import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import '../../models/user.dart';
import '../buttons/secondary_button.dart';

class UsersTable extends StatelessWidget {
  final List<User> users;
  final Function(User) onUserSelected;
  final VoidCallback onNewUser;
  final bool isLoading;

  const UsersTable({
    super.key,
    required this.users,
    required this.onUserSelected,
    required this.onNewUser,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTableHeader(),
            const Divider(height: 30),
            if (isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(40.0),
                  child: CircularProgressIndicator(),
                ),
              )
            else
              _buildTable(),
          ],
        ),
      ),
    );
  }

  Widget _buildTableHeader() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Usuários',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Selecione um usuário para editar suas informações',
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
                softWrap: true,
              ),
            ],
          ),
        ),
        SecondaryButton(
          text: 'Novo',
          onPressed: onNewUser,
        ),
      ],
    );
  }

  Widget _buildTable() {
    if (users.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(
          child: Text(
            'Nenhum usuário encontrado',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    return SizedBox(
      height: 400,
      child: DataTable2(
        showCheckboxColumn: false,
        columnSpacing: 12,
        horizontalMargin: 12,
        minWidth: 800,
        dataRowHeight: 60,
        headingRowHeight: 56,
        headingRowColor:
            WidgetStateColor.resolveWith((states) => Colors.green[50]!),
        columns: const [
          DataColumn2(
            label: Text('Nome',
                style: TextStyle(fontWeight: FontWeight.bold)),
            size: ColumnSize.L,
          ),
          DataColumn2(
            label: Text('Email',
                style: TextStyle(fontWeight: FontWeight.bold)),
            size: ColumnSize.L,
          ),
          DataColumn2(
            label: Text('Role',
                style: TextStyle(fontWeight: FontWeight.bold)),
            size: ColumnSize.S,
          ),
          DataColumn2(
            label: Text('Data Cadastro',
                style: TextStyle(fontWeight: FontWeight.bold)),
            size: ColumnSize.M,
          ),
        ],
        rows: users
            .map(
              (user) => DataRow2(
                onTap: () => onUserSelected(user),
                cells: [
                  DataCell(
                    Text(
                      user.name,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  DataCell(Text(user.email)),
                  DataCell(
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: user.role == 'admin'
                            ? Colors.blue.withValues(alpha: 0.1)
                            : Colors.green.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        user.role.toUpperCase(),
                        style: TextStyle(
                          color: user.role == 'admin' ? Colors.blue[700] : Colors.green[700],
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  DataCell(
                    Text(
                      user.createdAt != null 
                        ? _formatDate(user.createdAt!)
                        : '-',
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }
}