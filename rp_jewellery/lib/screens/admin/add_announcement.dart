import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminAddAnnouncementScreen extends StatefulWidget {
  const AdminAddAnnouncementScreen({Key? key}) : super(key: key);

  @override
  State<AdminAddAnnouncementScreen> createState() =>
      _AdminAddAnnouncementScreenState();
}

class _AdminAddAnnouncementScreenState
    extends State<AdminAddAnnouncementScreen> {
  final List<File> bannerImages = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> pickImages() async {
    try {
      final List<XFile> pickedFiles = await _picker.pickMultiImage();

      if (pickedFiles.isNotEmpty) {
        setState(() {
          bannerImages.addAll(pickedFiles.map((e) => File(e.path)));
        });
      }
    } catch (e) {
      print("Image pick error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to pick images")),
      );
    }
  }

  void uploadAnnouncements() {
    if (bannerImages.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please select at least one image")),
      );
      return;
    }

    // TODO: Upload to backend or Firebase
    print("Uploading ${bannerImages.length} banner images...");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Announcements added successfully!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Announcement")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: pickImages,
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: bannerImages.isEmpty
                    ? Center(child: Text("Tap to add banner images"))
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: bannerImages.length,
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Image.file(bannerImages[index],
                                    width: 120, fit: BoxFit.cover),
                                IconButton(
                                  icon: Icon(Icons.cancel, color: Colors.red),
                                  onPressed: () {
                                    setState(() {
                                      bannerImages.removeAt(index);
                                    });
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              icon: Icon(Icons.cloud_upload),
              label: Text("Upload Announcements"),
              onPressed: uploadAnnouncements,
            )
          ],
        ),
      ),
    );
  }
}
