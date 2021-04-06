import 'package:flutter/material.dart';

import '../provider/base_provider.dart';

class StateAwareWidget extends StatelessWidget {
  final ProviderState state;
  final Function successWidget;
  final Function failureWidget;
  final Widget? defaultWidget;

  StateAwareWidget({
    required this.state,
    required this.successWidget,
    required this.failureWidget,
    this.defaultWidget,
  });

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case ProviderState.Success:
        return successWidget();
      case ProviderState.Failure:
        return failureWidget();
      default:
        return defaultWidget == null
            ? CircularProgressIndicator()
            : (defaultWidget as Widget);
    }
  }
}
