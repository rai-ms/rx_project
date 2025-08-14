import 'package:flutter/material.dart';
import 'package:rx_project/features/contact/domain/usecases/send_message_use_case.dart';

class ContactProvider with ChangeNotifier {
  final SendMessageUseCase sendMessageUseCase;
  
  ContactProvider({required this.sendMessageUseCase});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isSuccess = false;
  bool get isSuccess => _isSuccess;

  Future<void> sendMessage({
    required String name,
    required String email,
    required String message,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    _isSuccess = false;
    notifyListeners();

    final result = await sendMessageUseCase(
      name: name,
      email: email,
      message: message,
    );

    _isLoading = false;

    result.fold(
      (failure) {
        _errorMessage = failure.message;
        _isSuccess = false;
      },
      (_) {
        _isSuccess = true;
      },
    );

    notifyListeners();
  }

  void reset() {
    _isLoading = false;
    _errorMessage = null;
    _isSuccess = false;
    notifyListeners();
  }
}
