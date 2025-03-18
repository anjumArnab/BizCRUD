import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restapi_crud/providers/company_providers.dart';
import 'package:restapi_crud/screen/create_company.dart';
import 'package:restapi_crud/widgets/company_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<CompanyProvider>(context, listen: false).fetchCompanies();
  }

  @override
  Widget build(BuildContext context) {
    final companyProvider = Provider.of<CompanyProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Business Info CRUD"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                hintText: 'Search Company',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  companyProvider.searchCompanies(value);
                } else {
                  companyProvider.fetchCompanies();
                }
              },
            ),
          ),
          Expanded(
            child: companyProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : companyProvider.errorMessage.isNotEmpty
                    ? Center(child: Text(companyProvider.errorMessage))
                    : companyProvider.companies.isEmpty
                        ? const Center(child: Text("No companies available."))
                        : GridView.builder(
                            padding: const EdgeInsets.all(10),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              childAspectRatio: 1,
                            ),
                            itemCount: companyProvider.companies.length,
                            itemBuilder: (context, index) {
                              final company = companyProvider.companies[index];
                              return GestureDetector(
                                onLongPress: () => companyProvider.deleteCompanyById(company.id),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => CreateCompany(company: company),
                                    ),
                                  ).then((_) => companyProvider.fetchCompanies());
                                },
                                child: CompanyCard(
                                  companyLogo: company.companyLogo,
                                  companyName: company.companyName,
                                  companyAddress: company.companyAddress,
                                  companyNumber: company.companyNumber,
                                ),
                              );
                            },
                          ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CreateCompany()),
          ).then((_) => companyProvider.fetchCompanies());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
