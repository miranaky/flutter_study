import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thread_clone/features/settings/view_models/darkmode_config_vm.dart';

bool isDarkMode(BuildContext context) =>
    context.watch<DarkModeConfigViewModel>().isDarkMode;
