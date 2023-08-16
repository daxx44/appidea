import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/room_model.dart';

class RoomController extends GetxController {
  RxList<Room> rooms=[Room()].obs;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final dobController = TextEditingController();

  addRoom(){
    rooms.add(Room());
    update();
  }

  addMember(i){
    rooms[i].members?.value.add(Member());
    update();
  }

  removeMember(i,index){
    rooms[index].members?.value.removeAt(i);
    update();
  }

  removeRoom(i){
    rooms.removeAt(i);
    update();
  }

  void createRoom(List<Room> room,context) async {
    try {
      for (Room room in rooms) {
        await FirebaseFirestore.instance.collection('rooms').add({
          'members': room.members?.map((member) => {
            'firstName': member.firstName,
            'lastName': member.lastName,
            'isChild':member.isChild?.value,
            'dob':"08,16,2023"
          }).toList(),
          'allowPets': room.isPets?.value,
        });
      }
      debugPrint('Rooms added to Firestore successfully!');
      AwesomeDialog(
          context: context,
          dialogType: DialogType.success,
          animType: AnimType.rightSlide,
          title: 'Done',
          desc: 'Rooms added to Firestore successfully!',
    btnOkOnPress: () {
            Get.back();
    },
    )..show();
    } catch (error) {
      print('Error adding rooms to Firestore: $error');
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Failed',
        desc: 'Something went wrong!!',
        btnOkOnPress: () {
          Get.back();
        },
      )..show();
    }}
}