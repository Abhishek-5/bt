import 'package:bt/Common/color.dart';
import 'package:bt/Common/Database/database_dishes.dart';
import 'package:bt/Screens/HomePage/dish_controller.dart';
import 'package:bt/Screens/HomePage/dishes_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddDish extends StatelessWidget {
  DBHelper dbHelper = DBHelper();
  DishesController? dishController = Get.put(DishesController());

  AddDish({super.key, this.showDishList});
  Dish? showDishList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_sharp, color: CommonColor().white,),
            onPressed: () {
              dishController!.clearValues();
              Navigator.of(context).pop();
            },
          ),
          automaticallyImplyLeading: true,
          backgroundColor: CommonColor().green,
          title: Text(
            dishController!.title.value.text == '' ? 
            "Add Dishes" : "Dish",
            style: TextStyle(color: CommonColor().white),
          ),
        ),
        body: Obx(
            ()=> SingleChildScrollView(
            child: Container(
              color: CommonColor().white,
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(left: 10,
                        right: 10),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        TextFormField(
                          enabled: dishController!.isEditable.value,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Title',
                          ),
                          controller: dishController!.title.value,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          enabled: dishController!.isEditable.value,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Ingredients',
                          ),
                          controller: dishController!.ingredients.value,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          enabled: dishController!.isEditable.value,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Category',
                          ),
                          controller: dishController!.category.value,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          enabled: dishController!.isEditable.value,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Steps',
                          ),
                          controller: dishController!.steps.value,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          child: Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.all(20),
                            padding: const EdgeInsets.all(10),
                            width: MediaQuery.of(context)
                                .size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.
                              circular(5.0),
                              color: CommonColor().green,
                            ),
                            child: Text(
                              dishController!.showEditable.value && dishController!.isEditable.value ?
                              "Update" :
                              !dishController!.showEditable.value ? 
                              "Add" : "Edit",
                              style: TextStyle(color:
                              CommonColor().white, fontSize: 18),
                            ),
                          ),
                          onTap: () {
                            if(dishController!.showEditable.value && dishController!.isEditable.value){
                              dishController!.updateDish();
                            }
                            else if(dishController!.showEditable.value){
                              dishController!.isEditable.value = true;
                            }
                            else{
                              dishController!.saveData();
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
