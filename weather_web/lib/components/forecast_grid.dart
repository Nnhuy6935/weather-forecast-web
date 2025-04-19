import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_web/provider/weather_provider.dart';

class ForecastGrid extends StatefulWidget{
  final double width;
  const ForecastGrid({
    required this.width,
    super.key,
  });
  @override
  State<StatefulWidget> createState() => _ForecastState();
}

class _ForecastState extends State<ForecastGrid>{
  late bool _showAllItems;
  @override
  void initState() {
    super.initState();
    _showAllItems = false;
  }
  @override
  Widget build(BuildContext context) {
    WeatherProvider weatherProvider = Provider.of(context);
    // Determine number of columns based on width
    int crossAxisCount = widget.width < 500
        ? 1
        : widget.width < 950
            ? 2
            : 4;
    // Determine which items to show based on _showAllItems flag
    final displayedItems = _showAllItems 
        ? weatherProvider.forecast 
        : weatherProvider.forecast.take(4).toList();

    if (weatherProvider.forecast.isNotEmpty) {
      return Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              // childAspectRatio: 1.1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: displayedItems.length,
            itemBuilder: (context, index) {
              final day = displayedItems[index];
              return Container(
                constraints: const BoxConstraints(maxWidth: 50, maxHeight: 50),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF6E7781),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '(${day.time})',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Image.network(
                      day.icon,
                      width: 64,
                      height: 64,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Temp: ${day.temperature}°C',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Wind: ${day.wind} M/S',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Humidity: ${day.humidity}%',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          
          // show more button 
          (!_showAllItems && weatherProvider.forecast.length > 4)
          ? Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Center(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _showAllItems = true;
                  });
                },
                child: const Text(
                  'Show More',
                  style: TextStyle(
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ) : const SizedBox(),

          // Show Less button (optional)
        if (_showAllItems)
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Center(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _showAllItems = false;
                  });
                },
                child: const Text(
                  'Show Less',
                  style: TextStyle(
                    fontSize: 16,
                    decoration: TextDecoration.underline,
                    ),
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      return const Center(
        child: Text('No data'),
      );
    }
  }
}
