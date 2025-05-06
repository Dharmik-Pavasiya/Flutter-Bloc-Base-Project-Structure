import 'package:flutter/material.dart';

import '../../../config/di/di/dependency_injector_container.dart';
import '../bloc/no_internet_bloc.dart';

class NoInternetView extends StatelessWidget {
  const NoInternetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('No Internet Connection'),
        automaticallyImplyLeading: false, // Optional: Disable back button
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.wifi_off, size: 100, color: Colors.grey),
            const SizedBox(height: 20),
            const Text(
              'Oops! No internet connection found.',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            const Text(
              'Please check your Wi-Fi or mobile data settings.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                sl<NoInternetBloc>().add(CheckConnectivity());
              },
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}
