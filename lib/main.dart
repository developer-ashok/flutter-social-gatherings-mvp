/*
 * Social Gatherings App
 * 
 * Developer: Ashok Chandrapal
 * Email: developer7039@gmail.com
 * Phone: +91 9033359874
 * GitHub: https://github.com/developer-ashok
 * LinkedIn: https://www.linkedin.com/in/ashok-chandrapal/
 * 
 * A Flutter-based mobile app for organizing private social gatherings.
 * Features: Event management, RSVP system, photo albums, polls, and announcements.
 */

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_gatherings/providers/auth_provider.dart';
import 'package:social_gatherings/providers/event_provider.dart';
import 'package:social_gatherings/providers/photo_provider.dart';
import 'package:social_gatherings/providers/poll_provider.dart';
import 'package:social_gatherings/providers/announcement_provider.dart';
import 'package:social_gatherings/screens/splash_screen.dart';
import 'package:social_gatherings/screens/main_screen.dart';
import 'package:social_gatherings/screens/auth/login_screen.dart';
import 'package:social_gatherings/screens/profile_screen.dart';
import 'package:social_gatherings/utils/theme.dart';
import 'package:social_gatherings/services/database_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize demo data
  await DatabaseService.initializeDemoData();
  
  runApp(const SocialGatheringsApp());
}

class SocialGatheringsApp extends StatelessWidget {
  const SocialGatheringsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => EventProvider()),
        ChangeNotifierProvider(create: (_) => PhotoProvider()),
        ChangeNotifierProvider(create: (_) => PollProvider()),
        ChangeNotifierProvider(create: (_) => AnnouncementProvider()),
      ],
      child: MaterialApp(
        title: 'Social Gatherings',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => const LoginScreen(),
          '/main': (context) => const MainScreen(),
          '/profile': (context) => const ProfileScreen(),
        },
        onUnknownRoute: (settings) {
          // Fallback route - redirect to splash screen
          return MaterialPageRoute(
            builder: (context) => const SplashScreen(),
          );
        },
      ),
    );
  }
} 