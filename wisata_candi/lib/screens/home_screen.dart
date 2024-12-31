import 'package:flutter/material.dart';
import 'package:wisata_candi/data/candi_data.dart';
import 'package:wisata_candi/widget/item_card.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TODO : 1. Buat appBar dengan judul wisata candi
      appBar: AppBar(
        title: Text('Wisata Candi'),),
      //TODO : 2. Buat Body dengan Grid wisata
        body: Padding(
        padding: const EdgeInsets.all(8.0), // Padding untuk GridView
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, 
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0, 
          ),
          itemCount: candiList.length, 
          itemBuilder: (context, index) {
            final candi = candiList[index];
            return ItemCard(candi: candiList[index]);
          },
        ),
      ),
    );
    //TODO : 3. Buat Item Card sebagai return value GridView builder
  }
}