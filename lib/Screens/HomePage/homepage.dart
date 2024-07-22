import 'package:bt/Common/color.dart';
import 'package:bt/Common/constant.dart';
import 'package:bt/Screens/AddDishes/adddish.dart';
import 'package:bt/Common/Database/database_dishes.dart';
import 'package:bt/Screens/HomePage/dish_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DBHelper dbHelper = DBHelper();
  DishesController? dishController = Get.put(DishesController());
  @override
  void initState() {
    super.initState();
    dishController!.fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CommonColor().red,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(ConstString().dishList,
            style: TextStyle(color: CommonColor().white),),
            IconButton(
              icon: const Icon(Icons.delete_sweep),
              onPressed: () {
                if(dishController!.dishList.isNotEmpty){
                  dishController!.showDeleteDialog(deleteRow: false);
                }
              },
            ),
          ],
        ),),
      floatingActionButton: InkWell(
        onTap: () {
          dishController!.isEditable.value = true;
          dishController!.clearValues();
          Get.to(AddDish());
        },
          child: const CircleAvatar(
            radius: 25,
            child: Icon(Icons.add))),
      body: Obx(
        ()=> Container(
          color: CommonColor().green,
          child: dishController!.dishList.length > 1 ?
          ListView.builder(
            itemCount: dishController!.dishList.length,
            itemBuilder: (context, index) {
              return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: BorderSide(color: CommonColor().grey!, width: 1.0),
            ),
                child: ListTile(
                  title: Text(dishController!.dishList[index].title!),
                  contentPadding: const  EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  subtitle: Text(dishController!.dishList[index].ingredients!),
                  trailing: InkWell(
                    onTap: () {
                      dishController!.showDeleteDialog(deleteRow: true, id: dishController!.dishList[index].id);
                    },
                    child: const Icon(Icons.delete)),
                  onTap: () {
                    dishController!.showData(showDishList: dishController!.dishList[index]);
                    dishController!.isEditable.value = false;
                    dishController!.showEditable.value = true;
                    Get.to(AddDish(showDishList: dishController!.dishList[index]));
                  },
              
                ),
              );
            },) :
            Center(child: Text("Items are not available",
            style: TextStyle(color: CommonColor().white),))
        ),
      ));
  }
}