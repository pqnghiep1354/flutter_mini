import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/category_model.dart';
import '../../repos/category_repo.dart';
import '../../providers/settings_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late Future<List<Category>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = CategoryRepo.getAll();
  }

  @override
  Widget build(BuildContext context) {
    final settingsProvider = context.watch<SettingsProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        title: const Text('Settings',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1A1A2E),
        scrolledUnderElevation: 0,
      ),
      body: FutureBuilder<List<Category>>(
        future: _categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline,
                        size: 48, color: Colors.grey),
                    const SizedBox(height: 12),
                    Text('Failed to load categories',
                        style: TextStyle(color: Colors.grey[600])),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () => setState(
                          () => _categoriesFuture = CategoryRepo.getAll()),
                      child: const Text('Retry'),
                    ),
                  ]),
            );
          }

          final categories = snapshot.data!;

          return Column(children: [
            // Actions row
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 8, 0),
              child: Row(children: [
                Expanded(
                  child: Text(
                    '${categories.length - settingsProvider.hiddenCategoryIds.length} of ${categories.length} categories visible',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.more_vert, size: 22),
                  onSelected: (value) {
                    if (value == 'show_all') {
                      settingsProvider.showAll();
                    } else if (value == 'hide_all') {
                      settingsProvider
                          .hideAll(categories.map((c) => c.id).toList());
                    }
                  },
                  itemBuilder: (_) => [
                    const PopupMenuItem(
                      value: 'show_all',
                      child: Row(children: [
                        Icon(Icons.visibility,
                            size: 20, color: Color(0xFF6C63FF)),
                        SizedBox(width: 10),
                        Text('Show All'),
                      ]),
                    ),
                    const PopupMenuItem(
                      value: 'hide_all',
                      child: Row(children: [
                        Icon(Icons.visibility_off,
                            size: 20, color: Colors.grey),
                        SizedBox(width: 10),
                        Text('Hide All'),
                      ]),
                    ),
                  ],
                ),
              ]),
            ),
            // Info card
            Container(
              margin: const EdgeInsets.fromLTRB(16, 4, 16, 12),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF6C63FF).withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: const Color(0xFF6C63FF).withValues(alpha: 0.2),
                ),
              ),
              child: Row(children: [
                const Icon(Icons.info_outline,
                    color: Color(0xFF6C63FF), size: 20),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Toggle categories to show or hide them on the home screen.',
                    style: TextStyle(
                        color: Colors.grey[700], fontSize: 13, height: 1.4),
                  ),
                ),
              ]),
            ),
            // Category list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 16),
                itemCount: categories.length,
                itemBuilder: (_, i) {
                  final category = categories[i];
                  return _CategoryToggleTile(
                    category: category,
                    isVisible: settingsProvider.isCategoryVisible(category.id),
                    onToggle: () =>
                        settingsProvider.toggleCategory(category.id),
                  );
                },
              ),
            ),
          ]);
        },
      ),
    );
  }
}

class _CategoryToggleTile extends StatelessWidget {
  final Category category;
  final bool isVisible;
  final VoidCallback onToggle;

  const _CategoryToggleTile({
    required this.category,
    required this.isVisible,
    required this.onToggle,
  });

  Color _getColor() {
    final colors = [
      const Color(0xFF6C63FF),
      const Color(0xFFFF6584),
      const Color(0xFF43E97B),
      const Color(0xFFFA709A),
      const Color(0xFF667EEA),
      const Color(0xFFF093FB),
      const Color(0xFF4FACFE),
      const Color(0xFFF5576C),
      const Color(0xFF0BA360),
      const Color(0xFFFFA726),
    ];
    return colors[category.id % colors.length];
  }

  IconData _getIcon() {
    final icons = [
      Icons.article_outlined,
      Icons.sports_soccer,
      Icons.movie_outlined,
      Icons.science_outlined,
      Icons.computer,
      Icons.health_and_safety,
      Icons.travel_explore,
      Icons.restaurant,
      Icons.music_note,
      Icons.school,
    ];
    return icons[category.id % icons.length];
  }

  @override
  Widget build(BuildContext context) {
    final color = _getColor();
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: isVisible ? Colors.white : Colors.grey[100],
        borderRadius: BorderRadius.circular(14),
        boxShadow: isVisible
            ? [
                BoxShadow(
                  color: color.withValues(alpha: 0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                )
              ]
            : [],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isVisible ? color.withValues(alpha: 0.15) : Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            _getIcon(),
            color: isVisible ? color : Colors.grey,
            size: 24,
          ),
        ),
        title: Text(
          category.name,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: isVisible ? const Color(0xFF1A1A2E) : Colors.grey,
          ),
        ),
        subtitle: category.totalArticles != null
            ? Text(
                '${category.totalArticles} articles',
                style: TextStyle(
                  fontSize: 12,
                  color: isVisible ? Colors.grey[600] : Colors.grey[400],
                ),
              )
            : null,
        trailing: Switch.adaptive(
          value: isVisible,
          onChanged: (_) => onToggle(),
          activeTrackColor: const Color(0xFF6C63FF),
        ),
      ),
    );
  }
}
