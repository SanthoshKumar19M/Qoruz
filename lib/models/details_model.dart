import 'dart:convert';

class MarketplaceRequest {
  final bool ok;
  final WebMarketplaceRequests webMarketplaceRequests;

  MarketplaceRequest({required this.ok, required this.webMarketplaceRequests});

  factory MarketplaceRequest.fromJson(Map<String, dynamic> json) {
    return MarketplaceRequest(
      ok: json['ok'] ?? false,
      webMarketplaceRequests: WebMarketplaceRequests.fromJson(json['web_marketplace_requests']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ok': ok,
      'web_marketplace_requests': webMarketplaceRequests.toJson(),
    };
  }
}

class WebMarketplaceRequests {
  final String idHash;
  final UserDetails userDetails;
  final bool isHighValue;
  final String createdAt;
  final String description;
  final dynamic requestDetails;
  final String status;
  final String serviceType;
  final String targetAudience;
  final bool isOpen;
  final bool isPanIndia;
  final bool anyLanguage;
  final bool isDealClosed;
  final String slug;

  WebMarketplaceRequests({
    required this.idHash,
    required this.userDetails,
    required this.isHighValue,
    required this.createdAt,
    required this.description,
    this.requestDetails,
    required this.status,
    required this.serviceType,
    required this.targetAudience,
    required this.isOpen,
    required this.isPanIndia,
    required this.anyLanguage,
    required this.isDealClosed,
    required this.slug,
  });

  factory WebMarketplaceRequests.fromJson(Map<String, dynamic> json) {
    return WebMarketplaceRequests(
      idHash: json['id_hash'] ?? '',
      userDetails: UserDetails.fromJson(json['user_details']),
      isHighValue: json['is_high_value'] ?? false,
      createdAt: json['created_at'] ?? '',
      description: json['description'] ?? '',
      requestDetails: json['request_details'],
      status: json['status'] ?? '',
      serviceType: json['service_type'] ?? '',
      targetAudience: json['target_audience'] ?? '',
      isOpen: json['is_open'] ?? false,
      isPanIndia: json['is_pan_india'] ?? false,
      anyLanguage: json['any_language'] ?? false,
      isDealClosed: json['is_deal_closed'] ?? false,
      slug: json['slug'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_hash': idHash,
      'user_details': userDetails.toJson(),
      'is_high_value': isHighValue,
      'created_at': createdAt,
      'description': description,
      'request_details': requestDetails,
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
}

class UserDetails {
  final String name;
  final String profileImage;
  final String company;
  final String designation;

  UserDetails({
    required this.name,
    required this.profileImage,
    required this.company,
    required this.designation,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      name: json['name'] ?? '',
      profileImage: json['profile_image'] ?? '',
      company: json['company'] ?? '',
      designation: json['designation'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'profile_image': profileImage,
      'company': company,
      'designation': designation,
    };
  }
}
