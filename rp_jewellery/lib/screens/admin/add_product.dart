import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:rp_jewellery/model/meta_model.dart';
import 'package:rp_jewellery/repository/repository.dart';

class AdminAddProductScreen extends StatefulWidget {
  const AdminAddProductScreen({Key? key}) : super(key: key);

  @override
  State<AdminAddProductScreen> createState() => _AdminAddProductScreenState();
}

class _AdminAddProductScreenState extends State<AdminAddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController purityController = TextEditingController();

  final List<String> categories = ['Ring', 'Necklace', 'Bracelet', 'Earring'];
  List<MaterialMeta> materials = [];
  int? selectedMaterialId;
  int? selectedProductMaterialId;
  List<ProductDetail> get filteredCategories {
    if (selectedMaterialId == null) return [];
    return materials
        .firstWhere((mat) => mat.materialId == selectedMaterialId)
        .productDetails;
  }

  @override
  void initState() {
    super.initState();
    final data = jsonDecode(jsonData)['data'] as List;
    materials = data.map((e) => MaterialMeta.fromJson(e)).toList();
  }

  List<File> productImages = [];

  Future<void> pickImages() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      setState(() {
        productImages = pickedFiles.map((e) => File(e.path)).toList();
      });
    }
  }

  void submitProduct() {
    if (_formKey.currentState!.validate() &&
        productImages.isNotEmpty &&
        selectedMaterialId != null &&
        selectedProductMaterialId != null) {
      // Send data to backend API
      print("Title: ${titleController.text}");
      print("Price: ${priceController.text}");
      print("Description: ${descriptionController.text}");
      print("Category: $selectedMaterialId");
      print("Weight: ${weightController.text}");
      print("Purity: ${purityController.text}");
      print("Stock: ${stockController.text}");
      print("Images: ${productImages.length}");
      Repository().addProduct(
          product: selectedProductMaterialId!,
          material: selectedMaterialId!,
          desc: descriptionController.text,
          size: weightController.text,
          price: priceController.text,
          purity: purityController.text,
          stock: stockController.text.isEmpty ? 0 : 1);
      // Add your API call here
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Product Added Successfully")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please complete all fields")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Jewellery Product")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Product Images
              GestureDetector(
                onTap: pickImages,
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: productImages.isEmpty
                      ? Center(child: Text("Tap to add images"))
                      : ListView(
                          scrollDirection: Axis.horizontal,
                          children: productImages.map((img) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  Image.file(img, width: 80, fit: BoxFit.cover),
                            );
                          }).toList(),
                        ),
                ),
              ),
              SizedBox(height: 16),
              // Title
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Product Title"),
                validator: (value) => value!.isEmpty ? "Enter title" : null,
              ),
              SizedBox(height: 16),

              // Price
              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Price (₹)"),
                validator: (value) => value!.isEmpty ? "Enter price" : null,
              ),
              SizedBox(height: 16),

              // Description
              TextFormField(
                controller: descriptionController,
                maxLines: 3,
                decoration: InputDecoration(labelText: "Description"),
                validator: (value) =>
                    value!.isEmpty ? "Enter description" : null,
              ),
              SizedBox(height: 16),

              // Category
              DropdownButtonFormField2<int>(
                decoration: InputDecoration(labelText: "Material"),
                value: selectedMaterialId,
                items: materials
                    .map((m) => DropdownMenuItem(
                          value: m.materialId,
                          child: Text(m.materialName),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedMaterialId = value;
                    selectedProductMaterialId = null; // Reset category
                  });
                },
                validator: (value) => value == null ? "Select material" : null,
              ),
              SizedBox(height: 16),
              DropdownButtonFormField2<int>(
                decoration: InputDecoration(labelText: "Category"),
                value: selectedProductMaterialId,
                items: filteredCategories
                    .map((cat) => DropdownMenuItem(
                          value: cat.productId,
                          child: Text(cat.productName),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedProductMaterialId = value;
                  });
                },
                validator: (value) => value == null ? "Select category" : null,
              ),
              SizedBox(
                height: 15,
              ),
              // Weight
              TextFormField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Size "),
                validator: (value) => value!.isEmpty ? "Enter size" : null,
              ),
              SizedBox(height: 16),

              // Purity
              TextFormField(
                controller: purityController,
                keyboardType: TextInputType.number,
                decoration:
                    InputDecoration(labelText: "Gold Purity (e.g. 22K)"),
                validator: (value) => value!.isEmpty ? "Enter purity" : null,
              ),
              SizedBox(height: 16),

              // Stock
              TextFormField(
                controller: stockController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Stock Available"),
                validator: (value) => value!.isEmpty ? "Enter stock" : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitProduct,
                child: Text("Add Product"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final String jsonData = '''
{
  "data": [
    {
      "material_id": 1,
      "material_name": "GOLD",
      "product_details": [
        {"product_id": 1, "product_name": "RING", "product_material_id": 1},
        {"product_id": 2, "product_name": "BRACELETS", "product_material_id": 2},
        {"product_id": 3, "product_name": "EARRINGS", "product_material_id": 3},
        {"product_id": 4, "product_name": "NECKLACES", "product_material_id": 4},
        {"product_id": 5, "product_name": "BANGLES", "product_material_id": 5},
        {"product_id": 6, "product_name": "CHAIN", "product_material_id": 6},
        {"product_id": 7, "product_name": "NOSEPIN", "product_material_id": 7}
      ]
    },
    {
      "material_id": 2,
      "material_name": "DIAMOND",
      "product_details": [
        {"product_id": 1, "product_name": "RING", "product_material_id": 8},
        {"product_id": 2, "product_name": "BRACELETS", "product_material_id": 10},
        {"product_id": 3, "product_name": "EARRINGS", "product_material_id": 11},
        {"product_id": 4, "product_name": "NECKLACES", "product_material_id": 12},
        {"product_id": 5, "product_name": "BANGLES", "product_material_id": 13},
        {"product_id": 6, "product_name": "CHAIN", "product_material_id": 14},
        {"product_id": 7, "product_name": "NOSEPIN", "product_material_id": 15}
      ]
    },
    {
      "material_id": 3,
      "material_name": "SILVER",
      "product_details": [
        {"product_id": 1, "product_name": "RING", "product_material_id": 16},
        {"product_id": 2, "product_name": "BRACELETS", "product_material_id": 17},
        {"product_id": 6, "product_name": "CHAIN", "product_material_id": 18},
        {"product_id": 4, "product_name": "NECKLACES", "product_material_id": 19}
      ]
    }
  ]
}
''';
}
