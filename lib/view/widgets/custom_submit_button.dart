import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studentmngmnt_getx/controllers/controller.dart';
import 'package:studentmngmnt_getx/model/db_model.dart';

class CustomSubmitButton extends StatelessWidget {
  const CustomSubmitButton({
    super.key,
    required this.controller,
    required this.selectedGender,
  });

  final ActionController controller;
  final String selectedGender;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.lightBlueAccent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
      onPressed: () {
        final String name = controller.nameController.text;
        final age = controller.ageController.text;
        final grade = controller.gradeController.text;
        if (name.isNotEmpty && age.isNotEmpty) {
          controller.addStudent(Student(
            id: UniqueKey().toString(),
            name: name,
            age: age,
            gender: selectedGender,
            imgPath: controller.selectedImage.value?.path,
            grade: grade, // Set the selected gender
          ));
          controller.nameController.clear();
          controller.ageController.clear();
          controller.gradeController.clear();
          controller.setSelected('none');
          controller.clearSelectedImage();
          Get.back();
          controller.newStudentSnack();
        }
      },
      child: const SizedBox(
          width: double.maxFinite,
          height: 30,
          child: Center(
              child: Text(
            'Submit',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
          ))),
    );
  }
}
