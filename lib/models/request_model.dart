import 'dart:convert';

class UserDetails {
  final String name;
  final String? profileImage;
  final String company;
  final String designation;

  UserDetails({
    required this.name,
    this.profileImage,
    required this.company,
    required this.designation,
  });

  factory UserDetails.fromMap(Map<String, dynamic> map) {
    return UserDetails(
      name: map['name'] ?? '',
      profileImage: map['profile_image'],
      company: map['company'] ?? '',
      designation: map['designation'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profile_image': profileImage,
      'company': company,
      'designation': designation,
    };
  }
}

class FollowersRange {
  final String igFollowersMin;
  final String igFollowersMax;
  final String? ytSubscribersMin;
  final String? ytSubscribersMax;

  FollowersRange({
    required this.igFollowersMin,
    required this.igFollowersMax,
    this.ytSubscribersMin,
    this.ytSubscribersMax,
  });

  factory FollowersRange.fromMap(Map<String, dynamic> map) {
    return FollowersRange(
      igFollowersMin: map['ig_followers_min'] ?? '0',
      igFollowersMax: map['ig_followers_max'] ?? '0',
      ytSubscribersMin: map['yt_subscribers_min'] ?? '0',
      ytSubscribersMax: map['yt_subscribers_max'] ?? '0',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ig_followers_min': igFollowersMin,
      'ig_followers_max': igFollowersMax,
      'yt_subscribers_min': ytSubscribersMin,
      'yt_subscribers_max': ytSubscribersMax,
    };
  }
}

class RequestDetails {
  final List<String> cities;
  final FollowersRange followersRange;
  final List<String> categories;
  final List<String> languages;
  final List<String> platform;
  final int? creatorCountMin;
  final int? creatorCountMax;
  final String? budget;
  final String? brand;
  final String? gender;

  RequestDetails({
    required this.cities,
    required this.followersRange,
    required this.categories,
    required this.languages,
    required this.platform,
    this.creatorCountMin,
    this.creatorCountMax,
    this.budget,
    this.brand,
    this.gender,
  });

  factory RequestDetails.fromMap(Map<String, dynamic> map) {
    return RequestDetails(
      cities: List<String>.from(map['cities'] ?? []),
      followersRange: FollowersRange.fromMap(map['followers_range'] ?? {}),
      categories: List<String>.from(map['categories'] ?? []),
      languages: List<String>.from(map['languages'] ?? []),
      platform: List<String>.from(map['platform'] ?? []),
      creatorCountMin: map['creator_count_min'],
      creatorCountMax: map['creator_count_max'],
      budget: map['budget'],
      brand: map['brand'],
      gender: map['gender'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cities': cities,
      'followers_range': followersRange.toMap(),
      'categories': categories,
      'languages': languages,
      'platform': platform,
      'creator_count_min': creatorCountMin,
      'creator_count_max': creatorCountMax,
      'budget': budget,
      'brand': brand,
      'gender': gender,
    };
  }
}

class TalentRequest {
  final String idHash;
  final UserDetails userDetails;
  final bool isHighValue;
  final String createdAt;
  final String description;
  final RequestDetails requestDetails;
  final String status;
  final String serviceType;
  final String targetAudience;
  final bool isOpen;
  final bool isPanIndia;
  final bool anyLanguage;
  final bool isDealClosed;
  final String slug;

  TalentRequest({
    required this.idHash,
    required this.userDetails,
    required this.isHighValue,
    required this.createdAt,
    required this.description,
    required this.requestDetails,
    required this.status,
    required this.serviceType,
    required this.targetAudience,
    required this.isOpen,
    required this.isPanIndia,
    required this.anyLanguage,
    required this.isDealClosed,
    required this.slug,
  });

  factory TalentRequest.fromMap(Map<String, dynamic> map) {
    return TalentRequest(
      idHash: map['id_hash'] ?? '',
      userDetails: UserDetails.fromMap(map['user_details'] ?? {}),
      isHighValue: map['is_high_value'] ?? false,
      createdAt: map['created_at'] ?? '',
      description: map['description'] ?? '',
      requestDetails: RequestDetails.fromMap(map['request_details'] ?? {}),
      status: map['status'] ?? '',
      serviceType: map['service_type'] ?? '',
      targetAudience: map['target_audience'] ?? '',
      isOpen: map['is_open'] ?? false,
      isPanIndia: map['is_pan_india'] ?? false,
      anyLanguage: map['any_language'] ?? false,
      isDealClosed: map['is_deal_closed'] ?? false,
      slug: map['slug'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id_hash': idHash,
      'user_details': userDetails.toMap(),
      'is_high_value': isHighValue,
      'created_at': createdAt,
      'description': description,
      'request_details': requestDetails.toMap(),
      'status': status,
      'service_type': serviceType,
      'target_audience': targetAudience,
      'is_open': isOpen,
      'is_pan_india': isPanIndia,
      'any_language': anyLanguage,
      'is_deal_closed': isDealClosed,
      'slug': slug,
    };
  }

  String toJson() => json.encode(toMap());

  factory TalentRequest.fromJson(String source) => TalentRequest.fromMap(json.decode(source));
}
