import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:qoruz/models/request_model.dart';
import 'package:qoruz/services/api_service.dart';

class MarketplaceDetailsPage extends StatefulWidget {
//  final TalentRequest item;
  final String id;

  MarketplaceDetailsPage({required this.id});

  @override
  State<MarketplaceDetailsPage> createState() => _MarketplaceDetailsPageState();
}

class _MarketplaceDetailsPageState extends State<MarketplaceDetailsPage> {
  List<TalentRequest> allItems = [];
  bool isLoading = false;
  void fetchMarketplaceData() async {
    setState(() => isLoading = true);
    try {
      allItems = await ApiService.getMarketplaceItemsDetails(widget.id);
    } catch (e) {
      Fluttertoast.showToast(msg: "Failed to load data", toastLength: Toast.LENGTH_SHORT);
      print(e);
    }
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    fetchMarketplaceData();
  }

  Widget detailsColumn(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
      ],
    );
  }

  // Widget followersRequirement() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         "Required followers",
  //         style: TextStyle(
  //           fontSize: 14,
  //           fontWeight: FontWeight.bold,
  //           color: Colors.black87,
  //         ),
  //       ),
  //       SizedBox(height: 4),
  //       IntrinsicWidth(
  //         child: Container(
  //           decoration: BoxDecoration(
  //               color: Color(0xffF5F6FB),
  //               borderRadius: BorderRadius.circular(5)),
  //           child: Padding(
  //             padding: const EdgeInsets.all(5),
  //             child: Row(
  //               children: [
  //                 Icon(Icons.check_box_outlined,
  //                     size: 16, color: Colors.black54),
  //                 SizedBox(width: 5),
  //                 Text("500k - 1M+",
  //                     style: TextStyle(fontSize: 14, color: Colors.black54)),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //       SizedBox(height: 4),
  //       IntrinsicWidth(
  //         child: Container(
  //           decoration: BoxDecoration(
  //               color: Color(0xffF5F6FB),
  //               borderRadius: BorderRadius.circular(5)),
  //           child: Padding(
  //             padding: const EdgeInsets.all(5.0),
  //             child: Row(
  //               children: [
  //                 Icon(Icons.check_box_outlined,
  //                     size: 16, color: Colors.black54),
  //                 SizedBox(width: 5),
  //                 Text("500k - 1M+",
  //                     style: TextStyle(fontSize: 14, color: Colors.black54)),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ]
  //   );
  // }

  Widget followersRequirement(FollowersRange followersRange) {
    List<Map<String, dynamic>> followerRanges = [];

    // Instagram followers range
    if (followersRange.igFollowersMin.isNotEmpty && followersRange.igFollowersMax.isNotEmpty) {
      followerRanges.add({
        'platform': 'Instagram',
        'range': "${followersRange.igFollowersMin} - ${followersRange.igFollowersMax}+",
        'icon': 'assets/instagram.png',
      });
    } else if (followersRange.igFollowersMin.isNotEmpty) {
      followerRanges.add({
        'platform': 'Instagram',
        'range': "${followersRange.igFollowersMin}+",
        'icon': 'assets/instagram.png',
      });
    } else if (followersRange.igFollowersMax.isNotEmpty) {
      followerRanges.add({
        'platform': 'Instagram',
        'range': "Up to ${followersRange.igFollowersMax}",
        'icon': 'assets/instagram.png',
      });
    }

    // YouTube subscribers range
    if (followersRange.ytSubscribersMin!.isNotEmpty && followersRange.ytSubscribersMax!.isNotEmpty) {
      followerRanges.add({
        'platform': 'YouTube',
        'range': "${followersRange.ytSubscribersMin} - ${followersRange.ytSubscribersMax}+",
        'icon': 'assets/youtube.png',
      });
    } else if (followersRange.ytSubscribersMin!.isNotEmpty) {
      followerRanges.add({
        'platform': 'YouTube',
        'range': "${followersRange.ytSubscribersMin}+",
        'icon': 'assets/youtube.png',
      });
    } else if (followersRange.ytSubscribersMax!.isNotEmpty) {
      followerRanges.add({
        'platform': 'YouTube',
        'range': "Up to ${followersRange.ytSubscribersMax}",
        'icon': 'assets/youtube.png',
      });
    }

    if (followerRanges.isEmpty) return SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Required followers",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        SizedBox(height: 4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: followerRanges.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  ColorFiltered(
                    colorFilter: ColorFilter.mode(Color(0xffAAAAAA), BlendMode.srcIn), // Apply grey color
                    child: Image.asset(
                      item['icon']!,
                      width: 14,
                      height: 14,
                      errorBuilder: (context, error, stackTrace) => Icon(Icons.error, size: 14, color: Colors.red),
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    item['range']!,
                    style: TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        color: Color(0xFFAAAAAA),
      ),
    );
  }

  Widget rowWithIcon(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20),
        SizedBox(width: 5),
        Expanded(
          child: Text(
            text,
            softWrap: true,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              // color: Color(0xFFAAAAAA),
            ),
          ),
        ),
      ],
    );
  }

  Widget infoBox(dynamic icon, String text) {
    return IntrinsicWidth(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color(0xffF5F6FB),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon is IconData ? Icon(icon, size: 18) : Text(icon, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(width: 5),
            Flexible(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget socialShareButton(String assetPath, String platform, Color bgColor) {
    return Expanded(
      child: InkWell(
        onTap: () {
          Fluttertoast.showToast(
            msg: "Sharing via $platform",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        },
        child: IntrinsicWidth(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: bgColor,
            ),
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  assetPath,
                  width: 18,
                  height: 18,
                  fit: BoxFit.cover,
                  placeholderBuilder: (context) => Icon(Icons.image, size: 18),
                ),
                SizedBox(width: 5),
                Text(
                  "Share via $platform",
                  style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            GestureDetector(
              onTap: () {
                Fluttertoast.showToast(
                  msg: "Delete option coming soon",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 16.0,
                  webPosition: "center",
                );
              },
              child: SvgPicture.asset(
                'assets/delete.svg',
                width: 30,
                height: 30,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: GestureDetector(
                onTap: () {
                  Fluttertoast.showToast(
                    msg: "Share option coming soon",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.TOP,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0,
                    webPosition: "center",
                  );
                },
                child: SvgPicture.asset(
                  'assets/Share.svg',
                  width: 30,
                  height: 30,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        body: Column(children: [
          isLoading == true
              ? Expanded(child: Center(child: CircularProgressIndicator()))
              : Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Container
                      Container(
                        decoration: BoxDecoration(color: Color(0xffF5F6FB)),
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            ClipOval(
                              child: Image.asset(
                                'assets/search_image.png',
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        allItems[0].userDetails.name ?? "No Name",
                                        style: const TextStyle(
                                          color: Color(0xff1F1F1F),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                      ),
                                      SizedBox(width: 5),
                                      SvgPicture.asset('assets/linkedin.svg', width: 12, height: 12),
                                      SizedBox(width: 5),
                                      SvgPicture.asset('assets/guard.svg', width: 12, height: 12),
                                    ],
                                  ),
                                  Text(
                                    allItems[0].serviceType ?? "-",
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                      letterSpacing: 0,
                                      color: Color(0xFFF5F6FB),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(
                                        Icons.corporate_fare,
                                        size: 13,
                                        color: Color(0xFFAAAAAA),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        allItems[0].userDetails.company,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 13,
                                          color: Color(0xFFAAAAAA),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),

                      // Scrollable Content
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                sectionTitle("Looking for"),
                                rowWithIcon(Icons.person_outline, allItems[0].serviceType ?? "-"),
                                Divider(),
                                sectionTitle("Highlights"),
                                // SizedBox(height: 10),

                                /// Budget & Brand Row
                                // Row(
                                //   children: [
                                //     infoBox("₹",
                                //         "Budget: ${allItems[0].requestDetails.budget ?? '-'}"),
                                //     SizedBox(width: 10),
                                //     infoBox(Icons.campaign_outlined,
                                //         "Brand: ${allItems[0].requestDetails.brand ?? '-'}"),
                                //   ],
                                // ),

                                Row(
                                  children: [
                                    if (allItems[0].requestDetails.budget != null) infoBox("₹", "Budget: ${allItems[0].requestDetails.budget}"),
                                    if (allItems[0].requestDetails.budget != null && allItems[0].requestDetails.brand != null) SizedBox(width: 10),
                                    if (allItems[0].requestDetails.brand != null) infoBox(Icons.campaign_outlined, "Brand: ${allItems[0].requestDetails.brand}"),
                                  ],
                                ),

                                /// Detailed Information
                                // SizedBox(height: 10),
                                // Text(
                                //   "Budget: ₹${allItems[0].requestDetails.budget ?? '-'}\n"
                                //   "Brand: ${allItems[0].requestDetails.brand ?? '-'}\n"
                                //   "Location: ${allItems[0].requestDetails.cities.join(', ') ?? '-'}\n"
                                //   "Type: ${allItems[0].serviceType ?? '-'}\n"
                                //   "Language: ${allItems[0].requestDetails.languages.join(', ') ?? '-'}\n",
                                //   style: TextStyle(fontSize: 16, height: 1.4),
                                //   softWrap: true,
                                // ),

                                SizedBox(height: 10),
                                Text(
                                  [
                                    if (allItems[0].requestDetails.budget != null) "Budget: ₹${allItems[0].requestDetails.budget}",
                                    if (allItems[0].requestDetails.brand != null) "Brand: ${allItems[0].requestDetails.brand}",
                                    if (allItems[0].requestDetails.cities.isNotEmpty) "Location: ${allItems[0].requestDetails.cities.join(', ')}",
                                    if (allItems[0].serviceType != null) "Type: ${allItems[0].serviceType}",
                                    if (allItems[0].requestDetails.languages.isNotEmpty) "Language: ${allItems[0].requestDetails.languages.join(', ')}",
                                    if (allItems[0].description != null) allItems[0].description,
                                  ].join('\n'),
                                  style: TextStyle(fontSize: 16, height: 1.4),
                                  softWrap: true,
                                ),

                                // Social Share Buttons
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    socialShareButton('assets/whatsapp.svg', "WhatsApp", Colors.green.shade100),
                                    SizedBox(width: 5),
                                    socialShareButton('assets/linkedin.svg', "LinkedIn", Colors.blue.shade100),
                                  ],
                                ),

                                // Key Highlights Section
                                SizedBox(height: 20),
                                sectionTitle("Key Highlighted Details"),
                                SizedBox(height: 10),
                                // Wrap(
                                //   spacing: 40,
                                //   runSpacing: 10,
                                //   children: [
                                //     detailsColumn(
                                //         "Category", "Lifestyle, Fashion"),
                                //     detailsColumn(
                                //         "Platform", "Instagram, Youtube"),
                                //     detailsColumn("Language",
                                //         "Hindi, Kannada, Malayalam,\nTamil & Telugu"),
                                //     detailsColumn("Location",
                                //         "Bangalore, Tamilnadu, Kerala & Goa"),
                                //     detailsColumn("Required count", "15 - 20"),
                                //     detailsColumn("Our Budget", "₹1,45,000"),
                                //     detailsColumn(
                                //         "Brand collab with", "Swiggy"),
                                //     followersRequirement(),
                                //   ],
                                // ),
                                Wrap(
                                  spacing: 40,
                                  runSpacing: 10,
                                  children: [
                                    if (allItems[0].requestDetails.categories.isNotEmpty) detailsColumn("Category", allItems[0].requestDetails.categories.join(", ")),
                                    if (allItems[0].requestDetails.platform.isNotEmpty) detailsColumn("Platform", allItems[0].requestDetails.platform.join(", ")),
                                    if (allItems[0].requestDetails.languages.isNotEmpty) detailsColumn("Language", allItems[0].requestDetails.languages.join(", ")),
                                    if (allItems[0].requestDetails.cities.isNotEmpty) detailsColumn("Location", allItems[0].requestDetails.cities.join(", ")),
                                    if (allItems[0].requestDetails.creatorCountMin != null && allItems[0].requestDetails.creatorCountMax != null) detailsColumn("Required count", "${allItems[0].requestDetails.creatorCountMin} - ${allItems[0].requestDetails.creatorCountMax}"),
                                    if (allItems[0].requestDetails.budget != null) detailsColumn("Our Budget", allItems[0].requestDetails.budget!),
                                    if (allItems[0].requestDetails.brand != null) detailsColumn("Brand collab with", allItems[0].requestDetails.brand!),
                                    if (allItems[0].requestDetails.followersRange.igFollowersMin.isNotEmpty || allItems[0].requestDetails.followersRange.igFollowersMax.isNotEmpty) followersRequirement(allItems[0].requestDetails.followersRange),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          Divider(),
          if (allItems.isNotEmpty && allItems[0].isOpen != true)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.watch_later_outlined),
                  SizedBox(width: 5),
                  Text("Your post has will be expired on ${allItems[0].createdAt}"),
                ],
              ),
            ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Fluttertoast.showToast(
                        msg: "Edit option coming soon",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 16.0,
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      "Edit",
                      style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: Text(
                      "Close",
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]));
  }
}
