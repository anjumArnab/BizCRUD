import 'package:flutter/material.dart';
import 'package:restapi_crud/screen/homepage.dart';
import 'package:restapi_crud/widgets/custom_button.dart';
import 'package:restapi_crud/services/company_service.dart';
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
    if (widget.company != null) {
      _nameController.text = widget.company!.companyName;
      _addressController.text = widget.company!.companyAddress;
      _phoneController.text = widget.company!.companyNumber;
    }
    super.initState();
  }

  Future<Company?> createOrUpdateCompany() async {
    if (_key.currentState!.validate()) {
      Company newCompany = Company(
        id: widget.company == null ? 0 : widget.company!.id,
        companyName: _nameController.text,
        companyAddress: _addressController.text,
        companyNumber: _phoneController.text,
        companyLogo: "",
      );

      Company? result;

      if (widget.company == null) {
        result = await createCompany(newCompany);
      } else {
        result = await updateCompany(newCompany.id, newCompany);
      }

      if (result != null && context.mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }

      return result;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add Company"),
      ),
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter company name";
                    }
                    return null;
                  },
                  controller: _nameController,
                  decoration: const InputDecoration(
                      labelText: "Name",
                      hintText: "Enter the company name",
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _addressController,
                  decoration: const InputDecoration(
                      labelText: "Address",
                      hintText: "Enter the company address",
                      border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                      labelText: "Phone Number",
                      hintText: "Enter the company phone number",
                      border: OutlineInputBorder()),
                ),
              ),
              CustomButton(
                text: widget.company == null
                    ? "Create Company"
                    : "Update Company",
                onPressed: createOrUpdateCompany,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
