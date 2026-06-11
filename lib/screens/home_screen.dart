import 'package:flutter/material.dart';


import '../database/Database.dart';
import '../model/service_order.dart';
import 'login_screen.dart';
import 'cadastro_order_modal.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dbHelper = Database();

  List<ServiceOrder> serviceOrders = [];

  @override
  void initState() {
    super.initState();
    serviceOrders = dbHelper.getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TechService Home'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sair do App',
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Painel de Atividades',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8.0),
            const Text('Olá, Técnico. Veja os seus chamados para hoje.'),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: serviceOrders.length,
                itemBuilder: (context, index) {
                  final os = serviceOrders[index];
                  final status = os.status;
                  final isConcluida = status == 'Concluída';
                  final isEmAndamento = status == 'Em andamento' || status == 'Em Andamento';

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    elevation: 2,
                    child: ListTile(
                      leading: Icon(
                        isConcluida
                            ? Icons.check_circle
                            : isEmAndamento
                                ? Icons.autorenew
                                : Icons.error_outline,
                        color: isConcluida
                            ? Colors.green
                            : isEmAndamento
                                ? Colors.orange
                                : Colors.red,
                      ),
                      title: Text(
                        '${os.id} - ${os.client}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(os.desc),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey.shade50,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          os.status,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final ServiceOrder? novaOrdem = await showModalBottomSheet<ServiceOrder>(
            context: context,
            isScrollControlled: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) => const CadastroOrderModal(),
          );

          if (!mounted) return;


          if (novaOrdem != null) {
            dbHelper.addOrder(novaOrdem);
            setState(() {
              serviceOrders = dbHelper.getOrders();
            });
            if (context.mounted == false) return;
            final messenger = ScaffoldMessenger.maybeOf(context);
            if (messenger == null) return;
            messenger.showSnackBar(
              const SnackBar(content: Text('Ordem de Serviço salva com sucesso!')),
            );
            return;
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
