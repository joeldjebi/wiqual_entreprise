import 'package:get/get.dart';

import '../../components/sharpref.dart';
import '../../models/User.dart';

class CUser extends GetxController {
  final Rx<UserModel> _user = UserModel(
    0,
    "",
    "",
    "",
    0,
    "",
    "",
    "",
    "",
    "",
    DateTime.now(),
    DateTime.now(),
    DateTime.now(),
    DateTime.now(),
  ).obs;

  UserModel get user => _user.value;

  void getUser() async {
    UserModel? user = await EventPref.getUser();
    _user.value = user!;
  }
}
