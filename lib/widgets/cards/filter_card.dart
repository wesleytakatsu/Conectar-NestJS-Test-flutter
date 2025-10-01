import 'package:flutter/material.dart';
import '../forms/search_text_field.dart';
import '../forms/custom_dropdown.dart';
import '../buttons/primary_button.dart';
import '../buttons/secondary_button.dart';

class FilterCard extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController cnpjController;
  final String? selectedStatus;
  final String? selectedConectaPlus;
  final Function(String?) onStatusChanged;
  final Function(String?) onConectaPlusChanged;
  final VoidCallback onFilter;
  final VoidCallback onClear;

  const FilterCard({
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
  State<FilterCard> createState() => _FilterCardState();
}

class _FilterCardState extends State<FilterCard> {
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
              'Filtre e busque itens na página',
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
                    child: SearchTextField(
                      label: 'Buscar por CNPJ',
                      controller: widget.cnpjController,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: CustomDropdown(
                      label: 'Buscar por status',
                      items: const ['Ativo', 'Inativo', 'Pendente'],
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
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SecondaryButton(
                      text: 'Limpar',
                      onPressed: widget.onClear,
                    ),
                    const SizedBox(width: 10),
                    PrimaryButton(
                      text: 'Filtrar',
                      onPressed: widget.onFilter,
                    ),
                  ],
                ),
              ),
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
              SearchTextField(
                label: 'Buscar por CNPJ',
                controller: widget.cnpjController,
              ),
              const SizedBox(height: 15),
              CustomDropdown(
                label: 'Buscar por status',
                items: const ['Ativo', 'Inativo', 'Pendente'],
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: SecondaryButton(
                      text: 'Limpar',
                      onPressed: widget.onClear,
                      isFullWidth: true,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: PrimaryButton(
                      text: 'Filtrar',
                      onPressed: widget.onFilter,
                      isFullWidth: true,
                    ),
                  ),
                ],
              ),
            ],
          );
        }
      },
    );
  }
}