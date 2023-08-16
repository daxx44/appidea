import 'package:appidea/controller/room_controller.dart';
import 'package:flutter/material.dart';
import 'package:textfield_datepicker/textfield_datepicker.dart';
import 'package:intl/intl.dart';
import '../utility/styles.dart';

class MemberWidget extends StatefulWidget {
  const MemberWidget(
      {Key? key,
      required this.controller,
      required this.i,
      required this.index})
      : super(key: key);
  final RoomController controller;
  final int i, index;
  @override
  State<MemberWidget> createState() => _MemberWidgetState();
}

class _MemberWidgetState extends State<MemberWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Member ${widget.i + 1}",
                style: TextStyle(fontSize: 15),
              ),
              InkWell(
                onTap: () {
                  if(!(widget.controller. rooms[widget.index].members?.length==1)){
                    widget.controller.removeMember(widget.i, widget.index);
                    setState(() {});
                  }
                },
                child: Icon(
                  Icons.delete,
                  size: 18,
                ),
              )
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "First name",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              5.0,
                            ),
                          ),
                          hintText: "Enter first name",

                          hintStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.withOpacity(0.5),
                              fontSize: 15),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 1, horizontal: 15)),
                      onChanged: (value) {
                        setState(() {
                          widget.controller.rooms.value[widget.index].members?[widget.i].firstName=value;
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Last name",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      onChanged: (value) {
                        setState(() {
                          widget.controller.rooms.value[widget.index].members?[widget.i].lastName=value;
                        });
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              5.0,
                            ),
                          ),
                          hintText: "Enter last name",
                          hintStyle: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.grey.withOpacity(0.5),
                              fontSize: 15),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 1, horizontal: 15)),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
        StreamBuilder<Object>(
            stream: widget.controller.rooms[widget.index].members?[widget.i]
                .isChild?.stream,
            builder: (context, snapshot) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Text(
                      "Child",
                      style: FontStyles.bodyStyle.copyWith(),
                    ),
                    Checkbox(
                        value: widget.controller.rooms[widget.index]
                            .members?[widget.i].isChild?.value,
                        onChanged: (val) {
                          setState(() {
                            widget.controller.rooms[widget.index]
                                .members?[widget.i].isChild?.value = val!;
                          });
                        }),
                  ],
                ),
              );
            }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Text(
                "Date of Birth",
                style: FontStyles.bodyStyle.copyWith(),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextfieldDatePicker(
                  cupertinoDatePickerBackgroundColor: Colors.white,
                  cupertinoDatePickerMaximumDate: DateTime(2099),
                  cupertinoDatePickerMaximumYear: 2099,
                  cupertinoDatePickerMinimumYear: 1990,
                  cupertinoDatePickerMinimumDate: DateTime(1990),
                  cupertinoDateInitialDateTime: DateTime.now(),
                  materialDatePickerFirstDate:
                      DateTime(DateTime.now().year - 3),
                  materialDatePickerInitialDate: DateTime.now(),
                  materialDatePickerLastDate: DateTime.now(),
                  preferredDateFormat: DateFormat('MM,dd,yyyy'),
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                  expands: false,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    //errorText: errorTextValue,
                    hintText: 'MM,DD,YYYY',
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.grey.withOpacity(0.5)),

                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                        borderSide: BorderSide(color: Colors.black)),
                  ),
                  textfieldDatePickerController:
                      widget.controller.dobController,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
