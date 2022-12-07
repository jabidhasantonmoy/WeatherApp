import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../custom_widgets/weather_section.dart';
import '../providers/weather_provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/homePage';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late WeatherProvider weatherProvider;
  bool isLoading = true;
  @override
  void didChangeDependencies() {
    weatherProvider = Provider.of<WeatherProvider>(context);
    weatherProvider.getData();
    if (weatherProvider.hasDataLoaded) {
      setState(() {
        isLoading = false;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          'Weather App',
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.my_location),
            color: Colors.white,
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator()
              : ListView(
                  children: [
                    currentWeatherSection(weatherProvider),
                  ],
                ),
        ),
      ),
    );
  }
}
