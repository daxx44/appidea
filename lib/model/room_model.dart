import 'package:get/get.dart';

class Room{
  RxBool? isPets=false.obs;
  RxList<Member>? members=[Member()].obs;
}

class Member{
  String? firstName;
  String? lastName;
  RxBool? isChild=false.obs;
  String? dob;
}