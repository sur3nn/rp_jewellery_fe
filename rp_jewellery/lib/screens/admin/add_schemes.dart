import 'package:flutter/material.dart';
import 'package:rp_jewellery/repository/repository.dart';

class AdminAddGoldSchemeScreen extends StatefulWidget {
  const AdminAddGoldSchemeScreen({Key? key}) : super(key: key);

  @override
  State<AdminAddGoldSchemeScreen> createState() =>
      _AdminAddGoldSchemeScreenState();
}

class _AdminAddGoldSchemeScreenState extends State<AdminAddGoldSchemeScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _schemeNameController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _monthlyAmountController =
      TextEditingController();
  final TextEditingController _interestController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  void submitScheme() {
    if (_formKey.currentState?.validate() ?? false) {
      final scheme = {
        "name": _schemeNameController.text.trim(),
        "durationMonths": int.parse(_durationController.text.trim()),
        "monthlyAmount": double.parse(_monthlyAmountController.text.trim()),
        "interestRate": _interestController.text.trim().isNotEmpty
            ? double.parse(_interestController.text.trim())
            : null,
        "description": _descriptionController.text.trim(),
      };

      // TODO: Send `scheme` data to backend or Firebase
      print("Submitting scheme: $scheme");
      Repository().addScheme(_schemeNameController.text.trim(),
          _monthlyAmountController.text.trim());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gold scheme added successfully!")),
      );

      _formKey.currentState?.reset();
      _schemeNameController.clear();
      _durationController.clear();
      _monthlyAmountController.clear();
      _interestController.clear();
      _descriptionController.clear();
    }
  }

  @override
  void dispose() {
    _schemeNameController.dispose();
    _durationController.dispose();
    _monthlyAmountController.dispose();
    _interestController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Gold Saving Scheme")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _schemeNameController,
                decoration: InputDecoration(labelText: "Scheme Name"),
                validator: (value) =>
                    value!.isEmpty ? "Enter scheme name" : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _durationController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Duration (Months)"),
                validator: (value) => value!.isEmpty ? "Enter duration" : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _monthlyAmountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Monthly Deposit (₹)"),
                validator: (value) => value!.isEmpty ? "Enter amount" : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _interestController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Interest/Bonus (%) [Optional]",
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: "Description",
                  alignLabelWithHint: true,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: submitScheme,
                icon: Icon(Icons.check),
                label: Text("Submit Scheme"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
