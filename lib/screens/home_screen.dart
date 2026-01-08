import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'camera_screen.dart';
import 'saved_palettes_screen.dart';
import 'wardrobe_screen.dart';
import 'artist_tools_screen.dart';
import 'color_generator_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF6C5CE7),
              Color(0xFFFF6B6B),
              Color(0xFFFFA07A),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // App Bar
              _buildAppBar(context),

              // Hero Section
              _buildHeroSection(),

              // Navigation Cards
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: _buildNavigationGrid(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 40),
          Text(
            AppConstants.appName,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeroSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        children: const [
          Text(
            'Discover Your Perfect Colors',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            AppConstants.appTagline,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(20),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      children: [
        _buildNavigationCard(
          context,
          icon: Icons.camera_alt,
          title: 'Extract Colors',
          description: 'Capture or upload images',
          gradient: const LinearGradient(
            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CameraScreen()),
          ),
        ),
        _buildNavigationCard(
          context,
          icon: Icons.palette,
          title: 'My Palettes',
          description: 'View saved palettes',
          gradient: const LinearGradient(
            colors: [Color(0xFFf093fb), Color(0xFFf5576c)],
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SavedPalettesScreen()),
          ),
        ),
        _buildNavigationCard(
          context,
          icon: Icons.checkroom,
          title: 'My Wardrobe',
          description: 'Organize clothing colors',
          gradient: const LinearGradient(
            colors: [Color(0xFF4facfe), Color(0xFF00f2fe)],
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const WardrobeScreen()),
          ),
        ),
        _buildNavigationCard(
          context,
          icon: Icons.brush,
          title: 'Artist Tools',
          description: 'Color theory & tools',
          gradient: const LinearGradient(
            colors: [Color(0xFF43e97b), Color(0xFF38f9d7)],
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ArtistToolsScreen()),
          ),
        ),
        _buildNavigationCard(
          context,
          icon: Icons.auto_awesome,
          title: 'Generate Colors',
          description: 'Create from keywords',
          gradient: const LinearGradient(
            colors: [Color(0xFFfa709a), Color(0xFFfee140)],
          ),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const ColorGeneratorScreen()),
          ),
        ),
        _buildNavigationCard(
          context,
          icon: Icons.info_outline,
          title: 'About',
          description: 'Learn about PaletteStory',
          gradient: const LinearGradient(
            colors: [Color(0xFF30cfd0), Color(0xFF330867)],
          ),
          onTap: () => _showAboutDialog(context),
        ),
      ],
    );
  }

  Widget _buildNavigationCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required Gradient gradient,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: Colors.white,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 3),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(AppConstants.appName),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(AppConstants.appTagline),
            SizedBox(height: 16),
            Text(
              'Version: ${AppConstants.appVersion}',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 8),
            Text(
              'A color palette generator and management app for artists, designers, and color enthusiasts.',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
