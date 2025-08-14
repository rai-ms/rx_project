import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rx_project/app.dart';

void main() {
  testWidgets('App should render home page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the home page is rendered
    expect(find.text('My Portfolio'), findsOneWidget);
    
    // Verify that the bottom navigation bar is present
    expect(find.byType(NavigationBar), findsOneWidget);
    
    // Verify that the home content is displayed
    expect(find.text('Welcome to my portfolio!'), findsOneWidget);
  });

  testWidgets('Navigation between tabs works', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    
    // Tap on the About tab
    await tester.tap(find.byIcon(Icons.person_outline));
    await tester.pumpAndSettle();
    
    // Verify that the About page is displayed
    expect(find.text('About Me'), findsOneWidget);
    
    // Tap on the Resume tab
    await tester.tap(find.byIcon(Icons.work_outline));
    await tester.pumpAndSettle();
    
    // Verify that the Resume page is displayed
    expect(find.text('My Resume'), findsOneWidget);
    
    // Tap on the Contact tab
    await tester.tap(find.byIcon(Icons.mail_outline));
    await tester.pumpAndSettle();
    
    // Verify that the Contact page is displayed
    expect(find.text('Get in Touch'), findsOneWidget);
  });
}
