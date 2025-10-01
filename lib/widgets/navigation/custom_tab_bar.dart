import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final List<String> tabs;
  final String selectedTab;
  final Function(String) onTabSelected;

  const CustomTabBar({
    super.key,
    required this.tabs,
    required this.selectedTab,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      color: Colors.white,
      child: Row(
        children: tabs
            .map((tab) => _buildTabItem(tab))
            .toList(),
      ),
    );
  }

  Widget _buildTabItem(String title) {
    final bool isSelected = title == selectedTab;
    return GestureDetector(
      onTap: () => onTabSelected(title),
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