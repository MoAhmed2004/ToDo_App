import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/firebase/model/user.dart';

class FireStoreHandler{
  static CollectionReference<User> getUserCollection(){
   var collection = FirebaseFirestore.instance.collection(User.collectionName).withConverter(
       fromFirestore:(snapshot, options) {
         var data = snapshot.data();
         return User.fromFireStore(data);
       }  ,
       toFirestore:(user, options) {
         return user.tofireStore();
       }, );
    return collection;
  }
  static Future<void> createUser(User user){
    var colleection = getUserCollection();
   var docRef = colleection.doc(user.id);
   return docRef.set(user);
  }
}