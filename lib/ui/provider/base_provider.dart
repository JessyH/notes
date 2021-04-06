import 'package:flutter/widgets.dart';

enum ProviderState { Default, Loading, Success, Failure }

class BaseProvider extends ChangeNotifier {
  ProviderState _state = ProviderState.Default;

  ProviderState get state => _state;

  void setState(ProviderState state) {
    _state = state;
    notifyListeners();
  }
}
