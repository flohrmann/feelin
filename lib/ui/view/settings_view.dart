import 'package:feelin/ui/view/base_view.dart';
import 'package:feelin/ui/viewmodel/settings_viewmodel.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<SettingsViewModel>(builder: (context, model, child) {
      return Center(
        child: CircularProgressIndicator()
      );
    });
  }
}