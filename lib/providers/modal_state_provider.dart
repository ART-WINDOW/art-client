// modal_state_provider.dart
import 'package:flutter/cupertino.dart';

class ModalStateProvider with ChangeNotifier {
  bool _isModalVisible = false;
  bool get isModalVisible => _isModalVisible;

  void setModalVisible(bool value) {
    _isModalVisible = value;
    notifyListeners();
  }
}