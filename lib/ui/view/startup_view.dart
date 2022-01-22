import 'package:feelin/ui/view/base_view.dart';
import 'package:feelin/ui/viewmodel/startup_viewmodel.dart';
import 'package:flutter/material.dart';

class StartUpView extends StatelessWidget {
  const StartUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<StartUpViewModel>(
      onModelReady: (model) => model.onModelReady(),
      builder: (context, model, child) => const Scaffold(
        body: Center(
          child: CircularProgressIndicator()
        )
      )
    );
  }
}