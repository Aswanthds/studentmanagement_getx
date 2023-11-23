import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studentmngmnt_getx/controllers/controller.dart';
import 'package:studentmngmnt_getx/model/db_model.dart';
import 'package:studentmngmnt_getx/view/add_student.dart';
import 'package:studentmngmnt_getx/view/edit_Student.dart';
import 'package:studentmngmnt_getx/view/student_whole.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ActionController studentController = Get.find<ActionController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Student Management",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                studentController.logoutDialog();
              },
              icon: const Icon(
                Icons.logout_outlined,
                color: Colors.white,
              ))
        ],
        automaticallyImplyLeading: false,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: GetBuilder<ActionController>(
        builder: (controller) {
          final List<Student> students = controller.getStudents();
          return ListView.builder(
            itemCount: students.length,
            itemBuilder: (context, index) {
              final student = students[index];
              debugPrint(student.imgPath);

              return ListTile(
                onTap: () => Get.to(() => ProfileWidget(
                      index: index,
                    )),
                leading: student.imgPath != null
                    ? SizedBox.square(
                        dimension: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image(
                            image: FileImage(File(student.imgPath!)),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : const CircleAvatar(
                        backgroundColor: Colors.red,
                      ),
                title: Text(
                  student.name,
                  style: const TextStyle(fontSize: 20),
                ),
                subtitle: Text('Age: ${student.age}'),
                trailing: Wrap(
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.to(() => EditStudentPage(
                                studentName: student.name,
                              ));
                          // controller.updateStudent(
                          //     id: student.id,
                          //     newAge: '11',
                          //     newName: 'POLIC555E');
                        },
                        icon: const Icon(Icons.edit)),
                    IconButton(
                        onPressed: () {
                          controller.deleteDialog(index);
                        },
                        icon: const Icon(Icons.delete))
                  ],
                ),
                // Add other details here if needed
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape:
            const CircleBorder(side: BorderSide(color: Colors.lightBlueAccent)),
        backgroundColor: Colors.lightBlueAccent,
        onPressed: () {
          Get.to(() => AddStudent());
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
/*

                */