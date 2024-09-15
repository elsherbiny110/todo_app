import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../manager/main_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(onPressed: () {
                provider.logout(context);
              }, icon: Icon(Icons.logout))
            ],
          ),
        );
      },
    );
  }
}
