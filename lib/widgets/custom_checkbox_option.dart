import 'package:bolao_/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomCheckboxOption extends StatelessWidget {
  final String? label;
  final bool isSelected;
  final ValueChanged<bool> onChanged;
  final Widget? child;

  const CustomCheckboxOption({
    super.key,
    this.label,
    required this.isSelected,
    required this.onChanged,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = AppColors.lightAccent;
    final fillColor = isSelected
        ? (isDark ? AppColors.darkPrimary : AppColors.lightPrimary)
        : Colors.transparent;
    final textColor = Theme.of(context).colorScheme.onSurface;

    return GestureDetector(
      onTap: () => onChanged(!isSelected),
      child: Row(
        children: [
          // Checkbox visual
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: fillColor,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: borderColor, width: 1.5),
            ),
            child: isSelected
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 20,
                  )
                : null,
          ),
          const SizedBox(width: 12),
          // Conteúdo customizado ou label
          Expanded(
            child: child ??
                Text(
                  label ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: textColor,
                    fontSize: 16,
                  ),
                ),
          ),
        ],
      ),
    );
  }
}

