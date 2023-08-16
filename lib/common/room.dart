import 'package:appidea/utility/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textfield_datepicker/textfield_datepicker.dart';

import '../controller/room_controller.dart';
import '../model/room_model.dart';
import 'member.dart';

class RoomWidget extends StatefulWidget {
  const RoomWidget({Key? key, required this.i,required this.room,required this.controller}) : super(key: key);
  final int i;
  final Room room;
  final RoomController controller;
  @override
  State<RoomWidget> createState() => _RoomWidgetState();
}

class _RoomWidgetState extends State<RoomWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Room ${widget.i + 1}",
                style: FontStyles.titleStyle,
              ),
              InkWell(
                onTap: () {
                  widget.controller.removeRoom(widget.i);
                },
                child: Icon(Icons.delete),
              )
            ],
          ),
        ),
        StreamBuilder<Object>(
          stream: widget.room.isPets?.stream,
          builder: (context, snapshot) {
            return Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.1)),
              padding: EdgeInsets.symmetric( horizontal: 10),
              child: Row(
                children: [
                  Checkbox(value: widget.room.isPets?.value, onChanged: (val){
                    widget.room.isPets?.value=val!;
                  }).paddingZero,
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Do you have pets?",
                    style: FontStyles.bodyStyle,
                  )
                ],
              ),
            );
          }
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.1)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Text(
                  "Members",
                  style: FontStyles.bodyStyle
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              InkWell(
                onTap: () {
                 widget.controller.addMember(widget.i);
                 setState(() {
                 });
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10)),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Row(
                    children: [
                      Text(
                        "Add",
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),

        StreamBuilder<Object>(
          stream: widget.room.members?.stream,
          builder: (context, snapshot) {
            return Column(
              children: [
                for(int i=0;i<(widget.room.members?.value.length??0);i++)
                MemberWidget(controller: widget.controller,i: i,index: widget.i,)
              ],
            );
          }
        )
      ],
    );
  }
}
