import 'package:flutter/material.dart';
import '../forms/search_text_field.dart';
import '../forms/custom_dropdown.dart';

class UserFilterCard extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController startDateController;
  final TextEditingController endDateController;
  final String? selectedRole;
  final Function(String?) onRoleChanged;
  final VoidCallback onFilter;
  final VoidCallback onClear;

  const UserFilterCard({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.startDateController,
    required this.endDateController,
    this.selectedRole,
    required this.onRoleChanged,
    required this.onFilter,
    required this.onClear,
  });

  @override
  State<UserFilterCard> createState() => _UserFilterCardState();
}

class _UserFilterCardState extends State<UserFilterCard> {
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
              'Filtre e busque usuários na página',
              style: TextStyle(color: Colors.grey[600]),
            ),
            if (_filtersVisible) ...[
              const Divider(height: 30),
              _buildResponsiveFilters(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildResponsiveFilters() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 992;
        
        return Column(
          children: [
            if (isDesktop) ...[
              // Desktop: todos os campos na mesma linha
              Row(
                children: [
                  Expanded(child: _buildField('nome')),
                  const SizedBox(width: 16),
                  Expanded(child: _buildField('email')),
                  const SizedBox(width: 16),
                  Expanded(child: _buildField('role')),
                  const SizedBox(width: 16),
                  Expanded(child: _buildField('dataInicio')),
                  const SizedBox(width: 16),
                  Expanded(child: _buildField('dataFim')),
                ],
              ),
            ] else ...[
              // Tablet e Mobile: layout responsivo com Wrap
              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  SizedBox(
                    width: constraints.maxWidth < 768 
                        ? double.infinity // Mobile: largura total
                        : (constraints.maxWidth - 16) / 2, // Tablet: 2 por linha
                    child: _buildField('nome'),
                  ),
                  SizedBox(
                    width: constraints.maxWidth < 768 
                        ? double.infinity
                        : (constraints.maxWidth - 16) / 2,
                    child: _buildField('email'),
                  ),
                  SizedBox(
                    width: constraints.maxWidth < 768 
                        ? double.infinity
                        : (constraints.maxWidth - 16) / 2,
                    child: _buildField('role'),
                  ),
                  SizedBox(
                    width: constraints.maxWidth < 768 
                        ? double.infinity
                        : (constraints.maxWidth - 16) / 2,
                    child: _buildField('dataInicio'),
                  ),
                  SizedBox(
                    width: constraints.maxWidth < 768 
                        ? double.infinity
                        : (constraints.maxWidth - 16) / 2,
                    child: _buildField('dataFim'),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 20),
            _buildButtonsResponsive(constraints.maxWidth),
          ],
        );
      },
    );
  }

  Widget _buildField(String type) {
    switch (type) {
      case 'nome':
        return SearchTextField(
          label: 'Buscar por nome',
          controller: widget.nameController,
        );
      case 'email':
        return SearchTextField(
          label: 'Buscar por email',
          controller: widget.emailController,
        );
      case 'role':
        return CustomDropdown(
          label: 'Role',
          value: widget.selectedRole,
          items: const ['admin', 'user'],
          onChanged: widget.onRoleChanged,
        );
      case 'dataInicio':
        return GestureDetector(
          onTap: () => _selectDate(context, widget.startDateController),
          child: AbsorbPointer(
            child: SearchTextField(
              label: 'Data início',
              controller: widget.startDateController,
            ),
          ),
        );
      case 'dataFim':
        return GestureDetector(
          onTap: () => _selectDate(context, widget.endDateController),
          child: AbsorbPointer(
            child: SearchTextField(
              label: 'Data fim',
              controller: widget.endDateController,
            ),
          ),
        );
      default:
        return Container();
    }
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

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      controller.text = "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
    }
  }
}