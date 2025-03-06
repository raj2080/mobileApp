import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePicture extends StatelessWidget {
  final File? profileImage;
  final String? firstName;
  final String? email;
  final Future<void> Function(ImageSource source) onPickImage;

  const ProfilePicture({
    Key? key,
    required this.profileImage,
    required this.firstName,
    required this.email,
    required this.onPickImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: () => _showImageSourceDialog(context),
            child: CircleAvatar(
              radius: 70,
              backgroundColor: Colors.white,
              child: profileImage != null
                  ? ClipOval(
                child: Image.file(
                  profileImage!,
                  width: 140,
                  height: 140,
                  fit: BoxFit.cover,
                ),
              )
                  : const Icon(
                Icons.person,
                size: 80,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            firstName ?? '',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange,
            ),
          ),
          Text(
            email ?? '',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  void _showImageSourceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Select Profile Picture'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera, color: Colors.deepPurple),
              title: const Text('Camera'),
              onTap: () {
                Navigator.of(context).pop();
                onPickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image, color: Colors.deepPurple),
              title: const Text('Gallery'),
              onTap: () {
                Navigator.of(context).pop();
                onPickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }
}
