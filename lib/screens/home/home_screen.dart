import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/home_provider.dart';
import 'widgets/app_drawer.dart';
import 'widgets/home_app_bar_widget.dart';
import 'widgets/home_content_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => context.read<HomeProvider>().loadData(),
          child: const CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: HomeAppBarWidget()),
              HomeContentWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
