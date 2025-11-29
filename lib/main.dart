import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';

import './styles/app_theme.dart';
import 'package:maps_project/core/widgets/custom_bottom_nav_bar.dart';

// Correct
Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

// Correct
class MyApp extends StatelessWidget {
  // Chiamata al costruttore StatelessWidget
  const MyApp({super.key});

  // Correct
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home: MapScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const LatLng _italianCentralPoint = LatLng(42.504154, 12.646361);
  final String _mapboxAccessToken = dotenv.env['MAPBOX_ACCESS_TOKEN'] ?? '';
  late String _mapboxUrlTemplate;
  
  LatLng? _currentPosition;
  bool _isLoadingPosition = true;
  int _selectedIndex = 0;
  // Definizione del controllore immutabile della mappa
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    // Chiamata API verso la mappa di MapBox
    _mapboxUrlTemplate =
        'https://api.mapbox.com/styles/v1/mapbox/streets-v12/tiles/256/{z}/{x}/{y}?access_token=$_mapboxAccessToken';
    // Chiamata al metodo _getCurrentLocation
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    // Settaggio dell'accuratezza della posizione
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
    );

    try {
      // Passaggio dei setting al metodo getCurrentPosition del plugin Geolocator
      Position position = await Geolocator.getCurrentPosition(locationSettings: locationSettings);
      
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _isLoadingPosition = false;
      });
    } catch (e) {
      setState(() {
        _currentPosition = _italianCentralPoint;
        _isLoadingPosition = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoadingPosition) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            // Serve per il controllo da parte dell'utente della mappa
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _currentPosition ?? _italianCentralPoint,
              // Zoom sul marker iniziale 
              initialZoom: 11.0,
            ),
            children: [
              TileLayer(
                // Correct
                urlTemplate: _mapboxUrlTemplate,
                // Correct
                userAgentPackageName: 'com.example.flutter_map_example',
              ),
              // Marker per la posizione corrente
              if (_currentPosition != null)
                MarkerLayer(
                  markers: [
                    Marker(
                      // Il punto escalamativo serve per dichiarare la tipologia di variabile con NotNull
                      point: _currentPosition!,
                      width: 23,
                      height: 23,
                      child: const Icon(
                        Icons.my_location,
                        color: Colors.blue,
                        size: 23,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          // Gestisci la navigazione qui
        },
      ),
    );
  }
}