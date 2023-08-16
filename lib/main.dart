import 'package:appidea/common/room.dart';
import 'package:appidea/utility/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';


import 'controller/room_controller.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RoomController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () {
              controller.addRoom();
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              margin: EdgeInsets.only(right: 15),
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
      body: SingleChildScrollView(
        child: StreamBuilder<Object>(
            stream: controller.rooms.stream,
            builder: (context, snapshot) {
              return Column(
                children: [
                  for (int i = 0; i < controller.rooms.value.length; i++)
                    RoomWidget(i:i,room:controller.rooms.value[i],controller:controller)
                ],
              );
            }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: InkWell(
        onTap: () {
          controller.createRoom(controller.rooms.value,context);
        },
        child: Container(
          width: 200,
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          margin: EdgeInsets.only(right: 15),
          child: Text(
            "Submit",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white,fontSize: 20),
          ),
        ),
      ),
    );
  }
}
