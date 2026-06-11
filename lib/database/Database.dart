import '../model/service_order.dart';
// ignore: uri_does_not_exist


class Database {
  static final Database _instance = Database._internal();
  Database._internal();
  factory Database() => _instance;

  final List<ServiceOrder> _serviceOrdersMock = [
    const ServiceOrder(
      id: 'OS-2026-001',
      client: 'Lab de Informatica 3',
      status: 'Em andamento',
      desc: 'Manutenção preventiva dos computadores.',
    ),
    const ServiceOrder(
      id: 'OS-2026-002',
      client: 'Secretaria Executiva',
      status: 'Aberta',
      desc: 'Configuração de nova sub-rede local.',
    ),
    const ServiceOrder(
      id: 'OS-2026-003',
      client: 'Bloco Técnico B',
      status: 'Concluída',
      desc: 'Troca de switch e testes de patch panel.',
    ),
  ];

  List<ServiceOrder> getOrders() {
    return _serviceOrdersMock;
  }

  void addOrder(ServiceOrder order) {
    _serviceOrdersMock.add(order);
  }
}

