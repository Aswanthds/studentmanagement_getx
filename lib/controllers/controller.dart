import 'dart:io';
// ignore: unused_import
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:studentmngmnt_getx/controllers/services.dart';
import 'package:studentmngmnt_getx/model/db_model.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class ActionController extends GetxController {
  final selected = "None".obs;
  final Box<Student> _studentBox = Hive.box<Student>('students');
  final ImagePickerService _imagePickerService = Get.put(ImagePickerService());
  Rx<File?> selectedImage = Rx<File?>(null);

  Future<void> pickImage() async {
    final pickedImage = await _imagePickerService.pickImage();
    if (pickedImage != null) {
      moveImageToFolder(pickedImage.path);
    }
  }

  Gender getGenderFromString(String genderString) {
    for (var gender in Gender.values) {
      if (gender.toString().toLowerCase() == genderString.toLowerCase()) {
        return gender;
      }
    }
    // If no match is found, you can return a default value or throw an error
    return Gender.none; // Default value, change as needed
  }

  void clearSelectedImage() {
    selectedImage.value = null;
  }

  void setSelected(String value) {
    selected.value = value;
  }

  List<String> list = ['Male', 'Female', 'None'];
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController gradeController = TextEditingController();

  FocusNode nameFocus = FocusNode();
  FocusNode ageFocus = FocusNode();
  FocusNode gradeFocus = FocusNode();

  // final Box<Student> _studentBox = Hive.box<Student>('students');

  List<Student> getStudents() {
    return _studentBox.values.toList();
  }

  void addStudent(Student student) {
    try {
      _studentBox.add(student);
      update();
      debugPrint("To Do Object added ${student.name}");
    } catch (e) {
      debugPrint("Erro occured while adding $e");
    }
  }

  void deleteStudent(int index) {
    _studentBox.deleteAt(index);
    update(); // Trigger an update to reflect changes in the UI
  }

  void updateStudent(
      {String? id,
      String? newName,
      String? newAge,
      String? newGender,
      String? newGrade,
      String? newImg}) {
    final List<Student> students = getStudents();
    final studentIndex = students.indexWhere((student) => student.id == id);
    if (studentIndex != -1) {
      students[studentIndex].name = newName ?? students[studentIndex].name;
      students[studentIndex].age = newAge ?? students[studentIndex].age;
      students[studentIndex].grade = newGrade ?? students[studentIndex].age;
      students[studentIndex].imgPath = newImg ?? students[studentIndex].imgPath;
      // Update other fields as needed
      update(); // Trigger a refresh in the UI
    }
  }

  Student? getStudentByName(String name) {
    final List<Student> students = getStudents();
    return students.firstWhere(
      (student) => student.name.toLowerCase() == name.toLowerCase(),
      orElse: () => Student(
          gender: Gender.other.name, age: '', grade: '', id: '', name: name),
    );
  }

  Future<void> moveImageToFolder(String sourcePath) async {
    final appDocumentDir =
        await path_provider.getApplicationDocumentsDirectory();
    final destinationFolder = '${appDocumentDir.path}/desired_folder';
    final fileName = DateTime.now()
        .microsecondsSinceEpoch
        .toString(); // Change this to your desired file name

    final File sourceFile = File(sourcePath);
    final File destinationFile = File('$destinationFolder/$fileName');

    try {
      // Create the destination folder if it doesn't exist
      if (!await Directory(destinationFolder).exists()) {
        await Directory(destinationFolder).create(recursive: true);
      }

      // Move the image to the desired folder with the new file name
      await sourceFile.copy(destinationFile.path);
      final updatedImage = File(destinationFile.path);
      final selectedImage = Get.find<ActionController>().selectedImage;
      selectedImage.value = updatedImage;
    } catch (e) {
      debugPrint("Error moving image: $e");
    }
  }

  newStudentSnack() => Get.snackbar("Successful", " Student Added Sucessfully",
      colorText: Colors.white,
      backgroundColor: Colors.green,
      icon: const Icon(Icons.add_alert),
      snackStyle: SnackStyle.FLOATING,
      snackPosition: SnackPosition.BOTTOM);

  editedStudentSnack() =>
      Get.snackbar("Successful", " Student Edited Sucessfully",
          colorText: Colors.white,
          backgroundColor: Colors.green,
          icon: const Icon(Icons.add_alert),
          snackStyle: SnackStyle.FLOATING,
          snackPosition: SnackPosition.BOTTOM);
  deleteStudentSnack() =>
      Get.snackbar("Successful", " Student Edited Sucessfully",
          colorText: Colors.white,
          backgroundColor: Colors.green,
          icon: const Icon(Icons.add_alert),
          snackStyle: SnackStyle.FLOATING,
          snackPosition: SnackPosition.BOTTOM);

  deleteDialog(int index) => Get.defaultDialog(
          title: 'Are you sure',
          content: Text("Student is going to delete. confirm"),
          actions: [
            TextButton(onPressed: () => Get.back(), child: Text('Cancel')),
            TextButton(
                onPressed: () {
                  deleteStudent(index);
                  Get.back();
                },
                child: Text('Delete')),
          ]);
  logoutDialog() => Get.defaultDialog(
          title: 'Are you sure',
          content: Text("Student is going to delete. confirm"),
          actions: [
            TextButton(onPressed: () => Get.back(), child: Text('Cancel')),
            TextButton.icon(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.logout_outlined),
                label: Text('Logout')),
          ]);
}
