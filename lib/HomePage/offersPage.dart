import 'package:flutter/material.dart';
import 'package:sign_checker/Core/apiClient.dart';

class OffersPage extends StatefulWidget {
  const OffersPage({super.key});

  @override
  _OffersPageState createState() => _OffersPageState();
}
class _OffersPageState extends State<OffersPage> {
  List<dynamic> offers = [];
  final _apiClient = ApiClient();

  getOffers() async {
    final res = await _apiClient.getAllOffers();
    offers = res['result'];
  }

  @override
  void initState() {
    getOffers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Offers',
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: (offers.length > 0) ? (
        ListView.builder(
          itemCount: offers.length,
          itemBuilder: (context, index) {
            return OfferCard(offer: offers[index]);
          },
        )
      ) : (
        const Padding(
        padding: EdgeInsets.all(30.0),
        child: Text('No offers for now'),
        )
      )
    );
  }
}

class OfferCard extends StatelessWidget {
  final dynamic offer;
  const OfferCard({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20.0),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              offer['name'],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(offer['description']),
            const SizedBox(height: 8.0),
            Text(
              'Price: ${offer['price']}',
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Handle buy now action
              },
              child: const Text('Buy Now'),
            ),
          ],
        ),
      ),
    );
  }
}
