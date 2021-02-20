import 'package:spotRafa/Modules/firebase/providers/firebase-auth-provider.dart';

class FirebaseAuthRepository{

  final FirebaseAuthProvider _instance = FirebaseAuthProvider();

  Future<bool> signInSnonymousAsync() async {
    return await _instance.signInSnonymousAsync();
  }
}