import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:thread_clone/constants/sizes.dart';
import 'package:thread_clone/features/settings/view_models/darkmode_config_vm.dart';

class NavTab extends ConsumerWidget {
  const NavTab({
    super.key,
    required this.icon,
    required this.isSelected,
    required this.selectedIcon,
    required this.onTap,
  });
  final IconData icon;
  final IconData selectedIcon;
  final bool isSelected;
  final Function onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDark = ref.watch(darkModeConfigViewModelProvider).isDarkMode;
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(),
        behavior: HitTestBehavior.translucent,
        child: AnimatedOpacity(
          opacity: isSelected ? 1 : 0.5,
          duration: const Duration(milliseconds: 100),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isSelected ? selectedIcon : icon,
                size: Sizes.size28,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
