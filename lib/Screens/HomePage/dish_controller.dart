import 'package:bt/Common/color.dart';
import 'package:bt/Common/Database/database_dishes.dart';
import 'package:bt/Screens/HomePage/dishes_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DishesController extends GetxController {
    Rx<TextEditingController> title = TextEditingController().obs;
    Rx<TextEditingController> ingredients = TextEditingController().obs;
    Rx<TextEditingController> category = TextEditingController().obs;
    Rx<TextEditingController> steps = TextEditingController().obs;
    DBHelper dbHelper = DBHelper();
    RxList<Dish> dishList = <Dish>[].obs;
    RxBool isEditable = false.obs;
    RxBool showEditable = false.obs;
    Rx<String> id= ''.obs;

      void fetchData() {
      dbHelper.getAllDishes().then((list) {
        dishList.value = list;
    });
  }

    saveData() {
    if (validation()) {
      Get.dialog(const Center(child: CircularProgressIndicator()));
      Dish dishes = Dish(
        title: title.value.text,
        ingredients: ingredients.value.text,
        category: category.value.text,
        steps: steps.value.text,
      );

      dbHelper.addDish(dishes);
      Get.back();
      Get.back();
      clearValues();
      isEditable.value = true;
      fetchData();
    }
  }

  showData({Dish? showDishList}){
    id.value = showDishList!.id!.toString(); 
    title.value.text = showDishList.title!;
    ingredients.value.text = showDishList.ingredients!;
    category.value.text = showDishList.category!;
    steps.value.text = showDishList.steps!;

  }
  
  updateDish() {
    if (validation()) {
      Get.dialog(const Center(child: CircularProgressIndicator()));
      Dish dishes = Dish(
        id: int.parse(id.value),
        title: title.value.text,
        ingredients: ingredients.value.text,
        category: category.value.text,
        steps: steps.value.text,
      );
      dbHelper.update(dishes);
      Get.back();
      Get.back();
      clearValues();
      isEditable.value = true;
      fetchData();
    }
  }

  deleteDish(id) async{
    await dbHelper.delete(id);
    fetchData();
  }

  deleteTable() async{
    Get.dialog(const Center(child: CircularProgressIndicator()));
    await dbHelper.deleteTable();
    fetchData();
    Get.back();
  }

  clearValues(){
    title.value.clear();
    ingredients.value.clear();
    category.value.clear();
    steps.value.clear();
    isEditable.value = true;
  }

  validation(){
    if(title.value.text == '' || ingredients.value.text == '' || category.value.text == '' || 
    steps.value.text == ''){
       commonSnackbar();
      return false;
    }
    else{
      return true;
    }
  }

  commonSnackbar(){
  return Get.snackbar('Validation Error', 'Please fill all fields',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: CommonColor().grey,
      colorText: CommonColor().white,
      duration: const Duration(seconds: 2)); 
  }

  void showDeleteDialog({required bool deleteRow, int? id}) {
  Get.defaultDialog(
    contentPadding: const EdgeInsets.all(30),
    title: 'Confirm Delete',
    middleText: 'Are you sure you want to delete?',
    textConfirm: 'Delete',
    textCancel: 'Cancel',
    confirmTextColor: CommonColor().white,
    cancel: TextButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: CommonColor().transparent, // Color of the Cancel button
      ),
      onPressed: () {
        Get.back(); // Close the dialog
      },
      child: Text('Cancel', style: TextStyle(color: CommonColor().red),),
    ),
    confirm: TextButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: CommonColor().green, // Color of the Cancel button
      ),
      onPressed: () {
        if (deleteRow) {
        deleteDish(id);
      }
      else{
        deleteTable();
      }
        Get.back(); // Close the dialog
      },
      child: Text('Confirm', style: TextStyle(color: CommonColor().white),),
    ),
  );
}

}