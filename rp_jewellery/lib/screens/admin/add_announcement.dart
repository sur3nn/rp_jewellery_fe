import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rp_jewellery/business_logic/admin_order_bloc/admin_order_bloc.dart';
import 'package:rp_jewellery/constants/constants.dart';
import 'package:rp_jewellery/repository/repository.dart';

class AdminOrderTracking extends StatelessWidget {
  const AdminOrderTracking({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AdminOrderBloc>().add(GetAdminOrders());
    return Scaffold(
        appBar: AppBar(title: Text("Order Management")),
        body: BlocBuilder<AdminOrderBloc, AdminOrderState>(
          builder: (context, state) {
            if (state is AdminOrderLoading) {
              return CircularProgressIndicator();
            } else if (state is AdminOrderSucess) {
              return ListView.separated(
                  padding: EdgeInsets.all(15),
                  itemCount: state.data.data?.length ?? 0,
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final data = state.data.data![index];
                    return Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: blackColor),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          ...data.orderDetails
                                  ?.map(
                                    (e) => Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          e.image != null
                                              ? Image.memory(base64Decode(e
                                                  .image!
                                                  .replaceAll('\n', '')
                                                  .replaceAll('\r', '')))
                                              : Image.asset(
                                                  'assets/icons/studs.jpg'),
                                          Text(e.total?.toString() ?? " - "),
                                          Text(e.productName ?? " - "),
                                        ],
                                      ),
                                    ),
                                  )
                                  .toList() ??
                              [],
                          Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: ElevatedButton(
                                  onPressed: () {
                                    Repository().statusUpdate(
                                        data.orderId ?? 1,
                                        data.status == "Pending"
                                            ? "Shipped"
                                            : "Delivered");
                                    Future.delayed(Duration(seconds: 3), () {
                                      context
                                          .read<AdminOrderBloc>()
                                          .add(GetAdminOrders());
                                    });
                                  },
                                  child: Text(data.status == "Pending"
                                      ? "Approve"
                                      : "Delivered"))),
                        ],
                      ),
                    );
                  });
            }
            return SizedBox();
          },
        ));
  }
}





















// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class AdminAddAnnouncementScreen extends StatefulWidget {
//   const AdminAddAnnouncementScreen({Key? key}) : super(key: key);

//   @override
//   State<AdminAddAnnouncementScreen> createState() =>
//       _AdminAddAnnouncementScreenState();
// }

// class _AdminAddAnnouncementScreenState
//     extends State<AdminAddAnnouncementScreen> {
//   final List<File> bannerImages = [];
//   final ImagePicker _picker = ImagePicker();

//   Future<void> pickImages() async {
//     try {
//       final List<XFile> pickedFiles = await _picker.pickMultiImage();

//       if (pickedFiles.isNotEmpty) {
//         setState(() {
//           bannerImages.addAll(pickedFiles.map((e) => File(e.path)));
//         });
//       }
//     } catch (e) {
//       print("Image pick error: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Failed to pick images")),
//       );
//     }
//   }

//   void uploadAnnouncements() {
//     if (bannerImages.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Please select at least one image")),
//       );
//       return;
//     }

//     // TODO: Upload to backend or Firebase
//     print("Uploading ${bannerImages.length} banner images...");
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Announcements added successfully!")),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Add Announcement")),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             GestureDetector(
//               onTap: pickImages,
//               child: Container(
//                 height: 150,
//                 decoration: BoxDecoration(
//                   border: Border.all(),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: bannerImages.isEmpty
//                     ? Center(child: Text("Tap to add banner images"))
//                     : ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: bannerImages.length,
//                         itemBuilder: (_, index) {
//                           return Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Stack(
//                               alignment: Alignment.topRight,
//                               children: [
//                                 Image.file(bannerImages[index],
//                                     width: 120, fit: BoxFit.cover),
//                                 IconButton(
//                                   icon: Icon(Icons.cancel, color: Colors.red),
//                                   onPressed: () {
//                                     setState(() {
//                                       bannerImages.removeAt(index);
//                                     });
//                                   },
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                       ),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton.icon(
//               icon: Icon(Icons.cloud_upload),
//               label: Text("Upload Announcements"),
//               onPressed: uploadAnnouncements,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

