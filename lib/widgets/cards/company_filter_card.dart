import 'package:flutter/material.dart';
import '../forms/search_text_field.dart';
import '../forms/custom_dropdown.dart';
import '../forms/cnpj_text_field.dart';

class CompanyFilterCard extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController cnpjController;
  final String? selectedStatus;
  final String? selectedConectaPlus;
  final Function(String?) onStatusChanged;
  final Function(String?) onConectaPlusChanged;
  final VoidCallback onFilter;
  final VoidCallback onClear;

  const CompanyFilterCard({
    super.key,
    required this.nameController,
    required this.cnpjController,
    this.selectedStatus,
    this.selectedConectaPlus,
    required this.onStatusChanged,
    required this.onConectaPlusChanged,
    required this.onFilter,
    required this.onClear,
  });

  @override
  State<CompanyFilterCard> createState() => _CompanyFilterCardState();
}

class _CompanyFilterCardState extends State<CompanyFilterCard> {
  bool _filtersVisible = true;

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
            Row(
              children: [
                const Icon(Icons.search, color: Color(0xFF16A085)),
                const SizedBox(width: 8),
                const Text(
                  'Filtros',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  icon: Icon(
                    _filtersVisible
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _filtersVisible = !_filtersVisible;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              'Filtre e busque empresas na página',
              style: TextStyle(color: Colors.grey[600]),
            ),
            if (_filtersVisible) ...[
              const Divider(height: 30),
              _buildFilterInputs(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFilterInputs() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          // Layout Desktop
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SearchTextField(
                      label: 'Buscar por nome',
                      controller: widget.nameController,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: CnpjTextField(
                      label: 'Buscar por CNPJ',
                      controller: widget.cnpjController,
                      isSearch: true,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: CustomDropdown(
                      label: 'Buscar por status',
                      items: const ['Ativo', 'Inativo'],
                      value: widget.selectedStatus,
                      onChanged: widget.onStatusChanged,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: CustomDropdown(
                      label: 'Buscar por conectar+',
                      items: const ['Sim', 'Não'],
                      value: widget.selectedConectaPlus,
                      onChanged: widget.onConectaPlusChanged,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildButtonsResponsive(constraints.maxWidth),
            ],
          );
        } else {
          // Layout Mobile
          return Column(
            children: [
              SearchTextField(
                label: 'Buscar por nome',
                controller: widget.nameController,
              ),
              const SizedBox(height: 15),
              CnpjTextField(
                label: 'Buscar por CNPJ',
                controller: widget.cnpjController,
                isSearch: true,
              ),
              const SizedBox(height: 15),
              CustomDropdown(
                label: 'Buscar por status',
                items: const ['Ativo', 'Inativo'],
                value: widget.selectedStatus,
                onChanged: widget.onStatusChanged,
              ),
              const SizedBox(height: 15),
              CustomDropdown(
                label: 'Buscar por conectar+',
                items: const ['Sim', 'Não'],
                value: widget.selectedConectaPlus,
                onChanged: widget.onConectaPlusChanged,
              ),
              const SizedBox(height: 20),
              _buildButtonsResponsive(constraints.maxWidth),
            ],
          );
        }
      },
    );
  }

  Widget _buildButtonsResponsive(double screenWidth) {
    final isDesktop = screenWidth >= 992;
    
    if (isDesktop) {
      // Desktop: botões à direita
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          SizedBox(
            width: 150,
            height: 40,
            child: OutlinedButton(
              onPressed: widget.onClear,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF16A085),
                side: const BorderSide(color: Color(0xFF16A085), width: 2),
                padding: EdgeInsets.zero,
                minimumSize: const Size(120, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Limpar campos', style: TextStyle(fontSize: 14)),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 150,
            height: 40,
            child: ElevatedButton(
              onPressed: widget.onFilter,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF16A085),
                foregroundColor: Colors.white,
                padding: EdgeInsets.zero,
                minimumSize: const Size(120, 40),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Filtrar', style: TextStyle(fontSize: 14)),
            ),
          ),
        ],
      );
    } else {
      // Mobile/Tablet: botões ocupam a largura total
      return Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 40,
              child: ElevatedButton(
                onPressed: widget.onFilter,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF16A085),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(double.infinity, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Filtrar', style: TextStyle(fontSize: 14)),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: SizedBox(
              height: 40,
              child: OutlinedButton(
                onPressed: widget.onClear,
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF16A085),
                  side: const BorderSide(color: Color(0xFF16A085)),
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(double.infinity, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Limpar', style: TextStyle(fontSize: 14)),
              ),
            ),
          ),
        ],
      );
    }
  }
}