import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/Business_providers.dart';
import '../screen/create_business.dart';
import '../widgets/business_card.dart';

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
    Provider.of<BusinessProvider>(context, listen: false).fetchCompanies();
  }

  @override
  Widget build(BuildContext context) {
    final businessProvider = Provider.of<BusinessProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("BizCRUD"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.grey[600]),
                hintText: 'Search business',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  businessProvider.searchCompanies(value);
                } else {
                  businessProvider.fetchCompanies();
                }
              },
            ),
          ),
          Expanded(
            child: businessProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : businessProvider.errorMessage.isNotEmpty
                    ? Center(child: Text(businessProvider.errorMessage))
                    : businessProvider.companies.isEmpty
                        ? const Center(child: Text("No business available."))
                        : ListView.builder(
                            padding: const EdgeInsets.all(10),
                            itemCount: businessProvider.companies.length,
                            itemBuilder: (context, index) {
                              final business =
                                  businessProvider.companies[index];
                              return GestureDetector(
                                onLongPress: () => businessProvider
                                    .deleteBusinessById(business.id),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          CreateBusiness(business: business),
                                    ),
                                  ).then(
                                      (_) => businessProvider.fetchCompanies());
                                },
                                child: BizCard(
                                  businessLogo: business.businessLogo,
                                  businessName: business.businessName,
                                  businessAddress: business.businessAddress,
                                  businessNumber: business.businessNumber,
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
            MaterialPageRoute(builder: (_) => const CreateBusiness()),
          ).then((_) => businessProvider.fetchCompanies());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
