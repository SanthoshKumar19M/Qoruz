class MarketplaceItem {
  final String name;
  final String? idHash;
  final bool? isHighValue;

  final String? company;
  final String description;
  final String serviceType;
  final String targetAudience;
  final bool isOpen;
  final String createdAt;

  MarketplaceItem({
    required this.name,
    this.idHash,
    this.isHighValue,
    this.company,
    required this.description,
    required this.serviceType,
    required this.targetAudience,
    required this.isOpen,
    required this.createdAt,
  });
  factory MarketplaceItem.fromJson(Map<String, dynamic> json) {
    var userDetails = json['user_details'] ?? {};

    return MarketplaceItem(
      name: userDetails['name'],
      company: userDetails['company'],
      description: json['description'],
      serviceType: json['service_type'],
      targetAudience: json['target_audience'],
      isOpen: json['is_open'] ?? false,
      createdAt: json['created_at'],
    );
  }
}
