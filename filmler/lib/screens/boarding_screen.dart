import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BoardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[100], // Arka plan rengi
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Filmler Uygulaması',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Image.asset(
            'assets/images/logo.png',
            height: 200,
            width: 200,
          ),
          SizedBox(height: 20),
          Text(
            'Filmler uygulamasına hoşgeldiniz.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(height: 15,),
          Text("Bu uygulama ile paylaşılan filmleri görebilir, yönetmenleri görebilir, ve kendiniz film afişi paylaşabilirsiniz.",
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 15,),
          ElevatedButton(
            onPressed: () {
              context.go('/films');
            },
            child: Text('Başla'),
          ),
        ],
      ),
    );  }
}