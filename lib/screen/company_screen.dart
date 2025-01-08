import 'package:restapi_crud/model/company.dart';
import 'package:restapi_crud/screen/create_company.dart';
import 'package:restapi_crud/services/company_service.dart';
import 'package:flutter/material.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({super.key});

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade100,
        centerTitle: true,
        title: const Text("Company Information"),
      ),
      body: FutureBuilder(
        future: CompanyService().getAllCompanies(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Error receiving data from server"),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            List<Company> data = snapshot.data as List<Company>;

            if (data.isEmpty) {
              return const Center(
                child: Text("No companies available."),
              );
            }

            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final company = data[index];
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        // Company Logo
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                            company.companyLogo ??
                                "https://logo.clearbit.com/google.ru",
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Company Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                company.companyName ?? "Company Name Unavailable",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(company.companyNumber ?? "No Number"),
                              const SizedBox(height: 4),
                              Text(company.companyAddress ?? "No Address"),
                            ],
                          ),
                        ),
                        // Action Buttons
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => CreateCompany(company: company),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text(
                                        "Are you sure you want to delete this company?",
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () async {
                                            await CompanyService().deleteCompany(
                                              company.id!,
                                            );
                                            Navigator.pop(context);
                                            setState(() {});
                                          },
                                          child: const Text("Yes"),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("No"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red.shade300,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                await CompanyService().updateCompanyPartially(
                                  {'name': "Flutter Hero"},
                                  company.id!,
                                );
                                setState(() {});
                              },
                              icon: const Icon(Icons.favorite_outline),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text("No data available."),
            );
          }
        },
      ),
      floatingActionButton: ClipOval(
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CreateCompany()),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
