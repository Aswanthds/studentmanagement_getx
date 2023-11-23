import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studentmngmnt_getx/controllers/controller.dart';
import 'package:studentmngmnt_getx/view/widgets/constants.dart';

class ProfileWidget extends StatelessWidget {
  final int index;
  const ProfileWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ActionController>(builder: (controller) {
      final students = controller.getStudents();
      final student = students[index];
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: DecorationImage(
                      image: FileImage(
                        File(student.imgPath!),
                      ),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Student name
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  changeStyle('Name', student.name),

                  const SizedBox(height: 10),
                  // Student age
                  changeStyle('Age', student.age),
                  const SizedBox(height: 10),
                  // Student gender
                  changeStyle('Gender', student.gender ?? '--'),
                  const SizedBox(height: 10),
                  // Student grade
                  changeStyle('Class', student.grade),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
