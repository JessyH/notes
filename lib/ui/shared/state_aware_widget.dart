import 'package:flutter/material.dart';

import '../provider/base_provider.dart';

class StateAwareWidget extends StatelessWidget {
  final ProviderState state;
  final Function successWidget;
  final Function failureWidget;
  final Widget? progressIndicatorWidget;

  StateAwareWidget({
    required this.state,
    required this.successWidget,
    required this.failureWidget,
    this.progressIndicatorWidget,
  });

  @override
  Widget build(BuildContext context) {
    switch (state) {
      case ProviderState.Default:
      case ProviderState.Success:
        return successWidget();
      case ProviderState.Failure:
        return failureWidget();
      case ProviderState.Loading:
        return progressIndicatorWidget == null
            ? CircularProgressIndicator()
            : (progressIndicatorWidget as Widget);
    }
  }
}
