import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import '../../models/client.dart';
import '../common/status_chip.dart';
import '../common/conecta_plus_chip.dart';
import '../buttons/secondary_button.dart';

class ClientsTable extends StatelessWidget {
  final List<Client> clients;
  final Function(Client) onClientSelected;
  final VoidCallback onNewClient;

  const ClientsTable({
    super.key,
    required this.clients,
    required this.onClientSelected,
    required this.onNewClient,
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
          text: 'Novo',
          onPressed: onNewClient,
        ),
      ],
    );
  }

  Widget _buildTable() {
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
            label: Text('Razão social',
                style: TextStyle(fontWeight: FontWeight.bold)),
            size: ColumnSize.L,
          ),
          DataColumn2(
            label: Text('CNPJ',
                style: TextStyle(fontWeight: FontWeight.bold)),
            size: ColumnSize.M,
          ),
          DataColumn2(
            label: Text('Nome na fachada',
                style: TextStyle(fontWeight: FontWeight.bold)),
            size: ColumnSize.L,
          ),
          DataColumn2(
            label: Text('Tags',
                style: TextStyle(fontWeight: FontWeight.bold)),
            size: ColumnSize.S,
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
        rows: clients.map((client) {
          return DataRow2(
            cells: [
              DataCell(Text(client.razaoSocial)),
              DataCell(Text(client.cnpj)),
              DataCell(Text(client.nomeFachada)),
              DataCell(Text(client.tags.isEmpty ? '-' : client.tags)),
              DataCell(StatusChip(status: client.status)),
              DataCell(ConectaPlusChip(conectaPlus: client.conectaPlus)),
            ],
            onSelectChanged: (selected) {
              if (selected == true) {
                onClientSelected(client);
              }
            },
          );
        }).toList(),
      ),
    );
  }
}