import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qoruz/models/request_model.dart';
// import 'package:qoruz/utils/json.dart';
// import '../../models/marketplace_model.dart';
import '../../services/api_service.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_search_bar.dart';
import '../../widgets/marketplace_card.dart';

class MarketplacePage extends StatefulWidget {
  @override
  _MarketplacePageState createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage> {
  List<TalentRequest> allItems = [];
  List<TalentRequest> filteredItems = [];
  bool isLoading = false;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    fetchMarketplaceData();
  }

  void fetchMarketplaceData() async {
    setState(() => isLoading = true);
    try {
      allItems = await ApiService.getMarketplaceItems();
      filteredItems = allItems;
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to load data", toastLength: Toast.LENGTH_SHORT);
      print(e);
    }
    setState(() => isLoading = false);
  }

  void filterSearchResults(String query) {
    setState(() {
      searchQuery = query;
      filteredItems = allItems.where((item) => item.userDetails.name.toLowerCase().contains(query.toLowerCase()) || item.description.toLowerCase().contains(query.toLowerCase())).toList();
    });
  }

  List chipList = ["For You", "Recent", "My Requests", "Top Deals"];

  String selectedChip = "Recent";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: "Marketplace",
        actions: [
          IconButton(
            icon: const Icon(Icons.menu_open_outlined, color: Colors.white),
            onPressed: () {
              Fluttertoast.showToast(
                msg: "Menu option comming soon",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 16.0,
                webPosition: "center",
              );
            },
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          CommonSearchBar(
            onSearchChanged: filterSearchResults,
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  for (int i = 0; i < chipList.length; i++)
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedChip = chipList[i];
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: chipList[i] == selectedChip ? Colors.red : Color(0xffE8E7EA)),
                            borderRadius: BorderRadius.circular(18),
                            color: chipList[i] == selectedChip ? Color(0xffFFEFEF) : Color(0xffF5F6FB),
                          ),
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (chipList[i] == "Top Deals") const Icon(Icons.star_border_outlined, size: 18, color: Color(0xffFFAA04)),
                              if (chipList[i] == "Top Deals") const SizedBox(width: 5),
                              Text(
                                chipList[i],
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          if (selectedChip == "Recent")
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : filteredItems.isEmpty
                      ? const Center(child: Text("No items available"))
                      : ListView.builder(
                          padding: const EdgeInsets.all(8.0),
                          itemCount: filteredItems.length,
                          itemBuilder: (context, index) {
                            return MarketplaceCard(
                                item: filteredItems[index],
                                onTap: () {
                                  Fluttertoast.showToast(
                                    msg: "This is a toast message",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.TOP,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                    fontSize: 16.0,
                                    webPosition: "center",
                                  );
                                });
                          },
                        ),
            )
          else
            Expanded(
              child: Center(
                child: Text("There is No data..."),
              ),
            )
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 20, 8),
        child: SizedBox(
          height: 45,
          child: FloatingActionButton.extended(
            onPressed: () {
              Fluttertoast.showToast(
                msg: "Post request feature coming soon",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.TOP,
                backgroundColor: Colors.black,
                textColor: Colors.white,
                fontSize: 14.0,
                webPosition: "center",
              );
            },
            backgroundColor: Colors.red,
            icon: Icon(Icons.add, color: Colors.white),
            label: Text(
              "Post Request",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
    );
  }
}
