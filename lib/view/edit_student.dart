import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studentmngmnt_getx/controllers/controller.dart';
import 'package:studentmngmnt_getx/model/db_model.dart';
import 'package:studentmngmnt_getx/view/widgets/custom_dropdown.dart';
import 'package:studentmngmnt_getx/view/widgets/custom_form_field.dart';

class EditStudentPage extends StatelessWidget {
  final String studentName;
  EditStudentPage({super.key, required this.studentName});

  final controller = Get.find<ActionController>();
  final formKey = GlobalKey<FormState>();
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    final Student? studentData = controller.getStudentByName(studentName);

    if (studentData != null) {
      controller.nameController.text = studentData.name;
      controller.ageController.text = studentData.age;
      controller.gradeController.text = studentData.grade;
      selectedGender = studentData.gender ?? 'none';
      controller.selectedImage = Rx(File(studentData.imgPath ?? ''));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Student"),
      ),
      body: Column(
        children: [
          CustomFormField(controller: controller.nameController),
          CustomFormField(controller: controller.ageController),
          CustomFormField(controller: controller.gradeController),
          CustomDropDOwnButton(
              selectedGender: controller
                  .getGenderFromString(studentData?.gender ?? 'none')),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton.icon(
                  onPressed: () {
                    controller.pickImage();
                  },
                  icon: const Icon(Icons.upload_outlined),
                  label: const Text("Add Photo")),
              Center(
                child: Obx(
                  () => controller.selectedImage.value != null
                      ? Image.file(
                          controller.selectedImage.value!,
                          height: 150,
                        )
                      : const Text('No Image Selected'),
                ),
              ),
              IconButton(
                  onPressed: () {
                    controller.clearSelectedImage();
                  },
                  icon: const Icon(Icons.close))
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlueAccent,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
            onPressed: () {
              final String name = controller.nameController.text;
              final age = controller.ageController.text;
              final grade = controller.gradeController.text;
              final image = controller.selectedImage.value?.path;
              if (name.isNotEmpty && age.isNotEmpty) {
                controller.updateStudent(
                    id: studentData?.id,
                    newAge: age,
                    newName: name,
                    newGrade: grade,
                    newGender: selectedGender,
                    newImg: image ?? studentData?.imgPath);
                controller.nameController.clear();
                controller.ageController.clear();
                controller.gradeController.clear();
                controller.setSelected('none');
                controller.clearSelectedImage();
                Get.back();
                controller.editedStudentSnack();
              }
            },
            child: const SizedBox(
                width: double.maxFinite,
                height: 30,
                child: Center(
                    child: Text(
                  'Submit',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ))),
          ),
        ],
      ),
    );
  }
}
