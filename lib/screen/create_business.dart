import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/business.dart';
import '../providers/Business_providers.dart';
import '../widgets/custom_button.dart';

class CreateBusiness extends StatefulWidget {
  final Business? business;
  const CreateBusiness({super.key, this.business});

  @override
  State<CreateBusiness> createState() => _CreateBusinessState();
}

class _CreateBusinessState extends State<CreateBusiness> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    if (widget.business != null) {
      _nameController.text = widget.business!.businessName;
      _addressController.text = widget.business!.businessAddress;
      _phoneController.text = widget.business!.businessNumber;
    }
  }

  Future<void> _createOrUpdateBusiness() async {
    if (_key.currentState!.validate()) {
      Business newBusiness = Business(
        id: widget.business == null ? 0 : widget.business!.id,
        businessName: _nameController.text,
        businessAddress: _addressController.text,
        businessNumber: _phoneController.text,
        businessLogo: "",
      );

      final businessProvider =
          Provider.of<BusinessProvider>(context, listen: false);

      if (widget.business == null) {
        await businessProvider.addBusiness(newBusiness);
      } else {
        await businessProvider.updateBusinessInfo(newBusiness.id, newBusiness);
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
        title:
            Text(widget.business == null ? "Add Business" : "Update Business"),
      ),
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                validator: (value) =>
                    value!.isEmpty ? "Please enter Business name" : null,
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  hintText: "Enter the Business name",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: "Address",
                  hintText: "Enter the Business address",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  hintText: "Enter the Business phone number",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: widget.business == null
                    ? "Create Business"
                    : "Update Business",
                onPressed: _createOrUpdateBusiness,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
