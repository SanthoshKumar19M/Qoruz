import 'package:flutter/material.dart';
import 'package:qoruz/models/request_model.dart';
// import '../models/marketplace_model.dart';
import '../views/marketplace/marketplace_details_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MarketplaceCard extends StatefulWidget {
  final TalentRequest item;
  final VoidCallback onTap;

  MarketplaceCard({required this.item, required this.onTap});

  @override
  State<MarketplaceCard> createState() => _MarketplaceCardState();
}

class _MarketplaceCardState extends State<MarketplaceCard> {
  Widget rowWidget(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label : ",
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          child: Text(
            value,
          ),
        ),
      ],
    );
  }

  bool isExpanded = false;
  void navigateToMarketplaceDetails(BuildContext context, String idHash) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MarketplaceDetailsPage(id: idHash),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            navigateToMarketplaceDetails(context, widget.item.idHash);
          },
          child: Card(
            color: Color(0xffFFFFFF),
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'assets/search_image.png',
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ///if (item.userDetails.name != null) // Show only if company exists
                                Text(
                                  widget.item.userDetails.name,
                                  style: const TextStyle(
                                    color: Color(0xff1F1F1F),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  widget.item.serviceType,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 13,
                                    letterSpacing: 0,
                                    color: Color(0xFFAAAAAA),
                                  ),
                                ),

                                // Text(
                                //   widget.item.serviceType,
                                //   overflow: TextOverflow.ellipsis,
                                // ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(
                                      Icons.watch_later_outlined,
                                      size: 13,
                                      color: Color(0xFFAAAAAA),
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      widget.item.createdAt,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 10,
                                        letterSpacing: 0,
                                        color: Color(0xFFAAAAAA),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_forward_ios_outlined),
                            color: Color(0xFFAAAAAA),
                            onPressed: () {
                              navigateToMarketplaceDetails(context, widget.item.idHash);
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.person_outline,
                            size: 18,
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: Text(
                              "Looking for ${widget.item.serviceType}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Column(
                          //   children: [
                          //     Text(
                          //       "Budget: ₹${widget.item.requestDetails.budget ?? " -"}\n"
                          //       "Brand: ${widget.item.requestDetails.brand ?? '-'}\n"
                          //       "Location: ${widget.item.requestDetails.cities.isNotEmpty ? widget.item.requestDetails.cities.join(', ') : '-'}\n"
                          //       "Type: ${widget.item.serviceType ?? "-"}\n"
                          //       "Language: ${widget.item.requestDetails.languages.isNotEmpty ? widget.item.requestDetails.languages.join(', ') : '-'}\n",
                          //       maxLines: isExpanded == true ? 15 : 4,
                          //       overflow: TextOverflow.ellipsis,
                          //       style: TextStyle(fontSize: 16.0, height: 1.2),
                          //     ),
                          //   ],
                          // ),
                          Column(
                            children: [
                              Text(
                                [
                                  if (widget.item.requestDetails.budget != null) "Budget: ₹${widget.item.requestDetails.budget}",
                                  if (widget.item.requestDetails.brand != null) "Brand: ${widget.item.requestDetails.brand}",
                                  if (widget.item.requestDetails.cities.isNotEmpty) "Location: ${widget.item.requestDetails.cities.join(', ')}",
                                  if (widget.item.serviceType != null) "Type: ${widget.item.serviceType}",
                                  if (widget.item.requestDetails.languages.isNotEmpty) "Language: ${widget.item.requestDetails.languages.join(', ')}",
                                  if (widget.item.description.isNotEmpty) widget.item.description,
                                ].join('\n'),
                                maxLines: isExpanded == true ? 15 : 4,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 16.0, height: 1.2),
                              ),
                            ],
                          ),

                          if (isExpanded)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Location Box (Only if cities exist)
                                if (widget.item.requestDetails.cities?.isNotEmpty ?? false) ...[
                                  SizedBox(height: 10),
                                  IntrinsicWidth(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Color(0xffF5F6FB),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.pin_drop_outlined),
                                          const SizedBox(width: 5),
                                          Flexible(
                                            child: Text(
                                              widget.item.requestDetails.cities?.join(', ') ?? 'N/A',
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],

                                SizedBox(height: 10),

                                Wrap(
                                  runSpacing: 10,
                                  children: [
                                    // Followers Range Box (Only if exists)
                                    //if ((int.tryParse(widget.item.requestDetails.followersRange.igFollowersMax)! > 0) && (int.tryParse(widget.item.requestDetails.followersRange.igFollowersMin)! > 0)) ...[
                                    IntrinsicWidth(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          color: Color(0xffF5F6FB),
                                        ),
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min, // Shrinks to fit content
                                          children: [
                                            const Icon(Icons.camera_enhance_outlined),
                                            const SizedBox(width: 5),
                                            Text(
                                              "${widget.item.requestDetails.followersRange.igFollowersMin} - ${widget.item.requestDetails.followersRange.igFollowersMax}",
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    // ],
                                    //if ((int.tryParse(widget.item.requestDetails.followersRange.igFollowersMax)! > 0) && (int.tryParse(widget.item.requestDetails.followersRange.igFollowersMin)! > 0))
                                    SizedBox(width: 10),

                                    // Categories Box (Only if exists)
                                    if (widget.item.requestDetails.categories.isNotEmpty) ...[
                                      IntrinsicWidth(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            color: Color(0xffF5F6FB),
                                          ),
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(Icons.category_outlined),
                                              const SizedBox(width: 5),
                                              Flexible(
                                                child: Text(
                                                  widget.item.requestDetails.categories.join(', ') ?? 'N/A',
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),

                                SizedBox(height: 10),
                              ],
                            ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isExpanded = !isExpanded;
                                  });
                                },
                                child: Text(
                                  isExpanded ? "See less" : "See more",
                                  style: isExpanded == false
                                      ? TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xff7E7E7E),
                                        )
                                      : TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.normal,
                                          color: Color(0xff7E7E7E),
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        if (widget.item.isHighValue)
          Positioned(
            right: 30,
            top: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(
                  30,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(
                  children: [
                    ClipOval(
                      child: SvgPicture.asset(
                        'assets/qoruz.svg',
                        width: 24,
                        height: 24,
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
                      ),
                    ),
                    // Icon(
                    //   Icons.stars_outlined,
                    //   color: Colors.white,
                    //   size: 20,
                    // ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "HIGH VALUE",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
