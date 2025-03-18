import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restapi_crud/providers/company_providers.dart';
import 'package:restapi_crud/widgets/custom_button.dart';
import 'package:restapi_crud/model/company.dart';

class CreateCompany extends StatefulWidget {
  final Company? company;
  const CreateCompany({super.key, this.company});

  @override
  State<CreateCompany> createState() => _CreateCompanyState();
}

class _CreateCompanyState extends State<CreateCompany> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    if (widget.company != null) {
      _nameController.text = widget.company!.companyName;
      _addressController.text = widget.company!.companyAddress;
      _phoneController.text = widget.company!.companyNumber;
    }
  }

  Future<void> _createOrUpdateCompany() async {
    if (_key.currentState!.validate()) {
      Company newCompany = Company(
        id: widget.company == null ? 0 : widget.company!.id,
        companyName: _nameController.text,
        companyAddress: _addressController.text,
        companyNumber: _phoneController.text,
        companyLogo: "",
      );

      final companyProvider = Provider.of<CompanyProvider>(context, listen: false);

      if (widget.company == null) {
        await companyProvider.addCompany(newCompany);
      } else {
        await companyProvider.updateCompanyInfo(newCompany.id, newCompany);
      }

      if (context.mounted) {
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.company == null ? "Add Company" : "Update Company"),
      ),
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                validator: (value) => value!.isEmpty ? "Please enter company name" : null,
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  hintText: "Enter the company name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: "Address",
                  hintText: "Enter the company address",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  hintText: "Enter the company phone number",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: widget.company == null ? "Create Company" : "Update Company",
                onPressed: _createOrUpdateCompany,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
