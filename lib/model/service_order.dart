class ServiceOrder {
  final String id;
  final String client;
  final String status;
  final String desc;

  const ServiceOrder({
    required this.id,
    required this.client,
    required this.status,
    required this.desc,
  });

  factory ServiceOrder.fromJson(Map<String, String> json) {
    return ServiceOrder(
      id: json['id'] ?? '', 
      client: json['client'] ?? '', 
      status: json['status'] ?? '', 
      desc: json['desc'] ?? '',
      );
  }

  @override
  String toString() => 'ServiceOrder(id: $id, client: $client, status: $status)';
}

