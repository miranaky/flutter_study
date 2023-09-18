import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thread_clone/constants/sizes.dart';
import 'package:thread_clone/features/settings/view_models/darkmode_config_vm.dart';

class FormButton extends ConsumerWidget {
  const FormButton({
    super.key,
    required this.text,
    this.disabled = false,
  });
  final String text;
  final bool disabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(darkModeConfigViewModelProvider).isDarkMode;
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: disabled
              ? isDark
                  ? Colors.grey.shade800
                  : Colors.grey.shade300
              : Colors.blueAccent.shade700,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: disabled ? Colors.grey.shade400 : Colors.white,
            fontSize: Sizes.size20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
