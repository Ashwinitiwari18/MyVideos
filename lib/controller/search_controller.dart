import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:getx_tutorial/constant.dart';
import 'package:getx_tutorial/model/user_model.dart';

class SearchedController extends GetxController {
  final Rx<List<User>> _searchUsers = Rx<List<User>>([]);
  List<User> get searchUsers => _searchUsers.value;

  searchUser(String typedUser) async {
    _searchUsers.bindStream(firestore
        .collection('users')
        .where('name', isGreaterThanOrEqualTo: typedUser)
        .snapshots()
        .map((QuerySnapshot query) {
      List<User> retVal = [];
      for (var element in query.docs) {
        retVal.add(User.fromSnapshot(element));
      }
      return retVal;
    }));
  }
}
