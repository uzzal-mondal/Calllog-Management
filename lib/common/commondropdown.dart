import 'package:call_log_management/model/desiginationlist.dart';
import 'package:flutter/material.dart';

class CommonDropdown extends StatelessWidget {
  final String label;
  final DesignationList? value;
  final List<DesignationList> items;
  final ValueChanged<DesignationList?> onChanged;

  const CommonDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: SizedBox(
        width: double.infinity, // Make dropdown full width
        child: DropdownButtonFormField<DesignationList>(
          isExpanded: true, // ✅ Prevent overflow
          decoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 12,
            ),
          ),
          value: value,
          items: items
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e.name ?? "",
                    overflow:
                        TextOverflow.ellipsis, // Prevent long text overflow
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
