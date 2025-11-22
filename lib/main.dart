import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './styles/app_style.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: AppStyle.primaryColor,
        scaffoldBackgroundColor: AppStyle.background,
        cardColor: AppStyle.cardColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: AppStyle.buttonShape,
            backgroundColor: AppStyle.primaryColor,
            foregroundColor: AppStyle.textColorLight,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.zero,
            borderSide: const BorderSide(color: Colors.grey),
          ),
          labelStyle: AppStyle.bodyMedium,
        ),
        textTheme: TextTheme(
          headlineMedium: AppStyle.headlineMedium,
          bodyMedium: AppStyle.bodyMedium,
        ),
      ),
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
  final String _mapboxUserId = dotenv.env['MAPBOX_USER_ID'] ?? '';
  String _mapboxStyleId = 'cmi8moylp006d01s99vudhvur';
  final String _mapboxAccessToken = dotenv.env['MAPBOX_ACCESS_TOKEN'] ?? '';

  late String _mapboxUrlTemplate;
  final TextEditingController _styleIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _mapboxUrlTemplate =
        'https://api.mapbox.com/styles/v1/$_mapboxUserId/$_mapboxStyleId/tiles/256/{z}/{x}/{y}?access_token=$_mapboxAccessToken';
    _styleIdController.text = _mapboxStyleId;
  }

  void _updateMapStyle(String newStyleId) {
    final trimmed = newStyleId.trim();
    if (trimmed.isEmpty) return;
    setState(() {
      _mapboxStyleId = trimmed;
      _mapboxUrlTemplate =
          'https://api.mapbox.com/styles/v1/$_mapboxUserId/$_mapboxStyleId/tiles/256/{z}/{x}/{y}?access_token=$_mapboxAccessToken';
      _styleIdController.text = _mapboxStyleId;
    });
  }

  @override
  void dispose() {
    _styleIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: _italianCentralPoint,
              initialZoom: 7.0,
              maxZoom: 11.0,
              minZoom: 5.0,
            ),
            children: [
              TileLayer(
                key: ValueKey(_mapboxStyleId),
                urlTemplate: _mapboxUrlTemplate,
                userAgentPackageName: 'com.example.flutter_map_example',
              ),
            ],
          ),

          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Card(
              elevation: 4,
              color: Colors.white,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _styleIdController,
                        decoration: const InputDecoration(
                          labelText: 'Mapbox Style ID',
                          hintText: 'Enter the Style ID',
                          isDense: true,
                        ),
                        onSubmitted: (value) => _updateMapStyle(value),
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () => _updateMapStyle(_styleIdController.text),
                      child: const Text('Update'),
                    ),
                  ],
                ),
              ),
            ),
          ),
/*           Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Card(
              elevation: 4,
              color: AppStyle.primaryColor,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Center(
                  child: Text(
                    'Just Another Card',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ),
          ), */
        ],
      ),
    );
  }
}