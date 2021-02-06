import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthProvider  {
  static FirebaseAuthProvider _instance;
  factory FirebaseAuthProvider() {
    _instance ??= FirebaseAuthProvider._internalConstructor();
    return _instance;
  }

  FirebaseAuthProvider._internalConstructor();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> signInSnonymousAsync() async {

    try{
       var _result = await _firebaseAuth.signInAnonymously();
       return _result != null;
    }catch(e){
      print(e.toString());
      return false;
    }
    
  }
}