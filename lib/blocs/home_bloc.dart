import 'package:flutter/foundation.dart';
import 'package:we_chat_app/data/models/authentication_model.dart';
import 'package:we_chat_app/data/models/authentication_model_impl.dart';

class HomeBloc extends ChangeNotifier {
  /// States


  /// Models
  AuthenticationModel authModel = AuthenticationModelImpl();

}