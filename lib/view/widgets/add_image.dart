import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studentmngmnt_getx/controllers/controller.dart';

class AddImageButton extends StatelessWidget {
  const AddImageButton({
    super.key,
    required this.controller,
  });

  final ActionController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Row(
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
                  : const Text('No image selected'),
            ),
          ),
          IconButton(
              onPressed: () {
                controller.clearSelectedImage();
              },
              icon: Icon(Icons.close))
        ],
      ),
    );
  }
}
