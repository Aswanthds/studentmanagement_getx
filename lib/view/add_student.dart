// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studentmngmnt_getx/controllers/controller.dart';
import 'package:studentmngmnt_getx/model/db_model.dart';
import 'package:studentmngmnt_getx/view/widgets/add_image.dart';
import 'package:studentmngmnt_getx/view/widgets/custom_dropdown.dart';
import 'package:studentmngmnt_getx/view/widgets/custom_form_field.dart';
import 'package:studentmngmnt_getx/view/widgets/custom_submit_button.dart';

class AddStudent extends StatelessWidget {
  final controller = Get.put(ActionController());
  AddStudent({super.key});
  final formKey = GlobalKey<FormState>();
  Gender selectedGender = Gender.none;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
       // automaticallyImplyLeading: false,
        title: Text("Add Student"),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: 15,
              right: 10,
            ),
            child: Column(
              children: [
                CustomFormField(
                    controller: controller.nameController,
                    current: controller.nameFocus,
                    next: controller.ageFocus,
                    hint: "Name",
                    type: TextInputType.text),
                CustomFormField(
                  controller: controller.ageController,
                  current: controller.ageFocus,
                  next: controller.gradeFocus,
                  hint: "Age",
                  type: TextInputType.number,
                ),
                CustomFormField(
                  controller: controller.gradeController,
                  current: controller.gradeFocus,
                  next: null,
                  hint: "Class & Division",
                  type: TextInputType.text,
                ),
                CustomDropDOwnButton(selectedGender: selectedGender),
                AddImageButton(controller: controller)
              ],
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: CustomSubmitButton(
                controller: controller, selectedGender: Gender.none.name),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
