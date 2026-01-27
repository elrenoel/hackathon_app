import 'package:flutter/material.dart';
import 'package:hackathon_app/models/blocked_app.dart';
import 'package:hackathon_app/services/load_installed_app_service.dart';

class AppBlockerPage extends StatefulWidget {
  const AppBlockerPage({super.key});

  @override
  State<AppBlockerPage> createState() => _AppBlockerPageState();
}

class _AppBlockerPageState extends State<AppBlockerPage> {
  List<BlockedApp> apps = [];
  final Set<BlockedApp> selected = {};
  List<BlockedApp> allApps = [];
  List<BlockedApp> filteredApps = [];
  String searchQuery = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        loadApps();
      });
    });
  }

  Future<void> loadApps() async {
    final result = await loadInstalledApps();

    result.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));

    setState(() {
      allApps = result;
      filteredApps = result;
      isLoading = false;
    });
  }

  void onSearchChanged(String query) {
    setState(() {
      searchQuery = query;

      filteredApps = allApps.where((app) {
        return app.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('App Blocker')),
      body: Column(
        children: [
          TextField(
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Search app name',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),

          Expanded(child: buildAppGrid()),

          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final result = selected.toList();
                  Navigator.pop(context, result);
                },
                child: const Text('Block App'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAppGrid() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (filteredApps.isEmpty) {
      return const Center(child: Text('No app found'));
    }

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredApps.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.75, // ⬅️ bikin rapi
      ),
      itemBuilder: (_, index) {
        final app = filteredApps[index];
        final isSelected = selected.contains(app);

        return GestureDetector(
          onTap: () {
            setState(() {
              isSelected ? selected.remove(app) : selected.add(app);
            });
          },
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.memory(app.icon, width: 48, height: 48),
                  const SizedBox(height: 6),
                  Text(
                    app.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
              if (isSelected)
                const Positioned(
                  top: 0,
                  right: 0,
                  child: Icon(
                    Icons.check_circle,
                    color: Colors.purple,
                    size: 18,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
