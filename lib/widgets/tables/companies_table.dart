import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import '../../models/company.dart';
import '../common/status_chip.dart';
import '../common/conecta_plus_chip.dart';
import '../buttons/secondary_button.dart';

class CompaniesTable extends StatelessWidget {
  final List<Company> companies;
  final Function(Company) onCompanySelected;
  final VoidCallback onNewCompany;
  final bool isLoading;

  const CompaniesTable({
    super.key,
    required this.companies,
    required this.onCompanySelected,
    required this.onNewCompany,
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
                'Clientes',
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
          text: 'Nova',
          onPressed: onNewCompany,
        ),
      ],
    );
  }

  Widget _buildTable() {
    if (companies.isEmpty) {
      return const SizedBox(
        height: 200,
        child: Center(
          child: Text(
            'Nenhuma empresa encontrada',
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
        minWidth: 900,
        dataRowHeight: 60,
        headingRowHeight: 56,
        headingRowColor:
            WidgetStateColor.resolveWith((states) => Colors.green[50]!),
        columns: const [
          DataColumn2(
            label: Text('Razão Social',
                style: TextStyle(fontWeight: FontWeight.bold)),
            size: ColumnSize.L,
          ),
          DataColumn2(
            label: Text('CNPJ',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          DataColumn2(
            label: Text('Nome Fantasia',
                style: TextStyle(fontWeight: FontWeight.bold)),
            size: ColumnSize.L,
          ),
          DataColumn2(
            label: Text('Status',
                style: TextStyle(fontWeight: FontWeight.bold)),
            size: ColumnSize.S,
          ),
          DataColumn2(
            label: Text('Conecta Plus',
                style: TextStyle(fontWeight: FontWeight.bold)),
            size: ColumnSize.S,
          ),
        ],
        rows: companies
            .map(
              (company) => DataRow2(
                onTap: () => onCompanySelected(company),
                cells: [
                  DataCell(
                    Text(
                      company.razaoSocial,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  DataCell(Text(_formatCnpj(company.cnpj))),
                  DataCell(Text(company.nomeFantasia ?? '-')),
                  DataCell(
                    StatusChip(
                      status: company.status,
                    ),
                  ),
                  DataCell(
                    ConectaPlusChip(
                      conectaPlus: company.conectaPlus ? 'Sim' : 'Não',
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  String _formatCnpj(String cnpj) {
    // Remove caracteres não numéricos
    final digitsOnly = cnpj.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (digitsOnly.length != 14) {
      return cnpj; // Retorna o original se não tiver 14 dígitos
    }
    
    // Formata o CNPJ: XX.XXX.XXX/XXXX-XX
    return '${digitsOnly.substring(0, 2)}.${digitsOnly.substring(2, 5)}.${digitsOnly.substring(5, 8)}/${digitsOnly.substring(8, 12)}-${digitsOnly.substring(12, 14)}';
  }
}