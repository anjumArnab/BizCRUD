import 'package:flutter/material.dart';
import 'package:restapi_crud/model/company.dart';
import 'package:restapi_crud/screen/create_company.dart';
import 'package:restapi_crud/services/company_service.dart';
import 'package:restapi_crud/widgets/company_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Company>?> _companyList;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _companyList = getAllCompanies();
  }

  void _refreshCompanyList() {
    setState(() {
      _companyList = getAllCompanies();
    });
  }

  Future<void> _deleteCompany(int id) async {
    bool isDeleted = await deleteCompany(id);
    if (isDeleted) {
      _refreshCompanyList();
    }
  }

  Future<void> _searchCompany(String query) async {
    setState(() {
      _companyList = searchCompany(query);
    });
  }

  @override
  Widget build(BuildContext context) {
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
              onChanged: (value){
                if (value.isNotEmpty) {
                  _searchCompany(value);
                } else {
                  setState(() {
                    _companyList = getAllCompanies();
                  });
              }
              },
            ),
          ),
            Expanded(
              child: FutureBuilder<List<Company>?>(
                future: _companyList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
              
                  if (snapshot.hasError || snapshot.data == null) {
                    return const Center(
                      child: Text("Error receiving data from server"),
                    );
                  }
              
                  List<Company> data = snapshot.data!;
              
                  if (data.isEmpty) {
                    return const Center(
                      child: Text("No companies available."),
                    );
                  }
              
                  return GridView.builder(
                    padding: const EdgeInsets.all(10),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5,
                      childAspectRatio: 1,
                    ),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final company = data[index];
                      return Transform.scale(
                        scale: 1.0,
                        child: GestureDetector(
                          onLongPress: () => _deleteCompany(company.id),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CreateCompany(company: company),
                              ),
                            ).then((_) => _refreshCompanyList());
                          },
                          child: CompanyCard(
                            companyLogo: company.companyLogo,
                            companyName: company.companyName,
                            companyAddress: company.companyAddress,
                            companyNumber: company.companyNumber,
                          ),
                        ),
                      );
                    },
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
          ).then((_) => _refreshCompanyList());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
