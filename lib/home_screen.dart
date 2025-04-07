import 'package:flutter/material.dart';
import 'package:quiz_app/quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _buildCategoryCard(BuildContext context, String title,IconData icon, Color color, String question){
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => QuizScreen(),));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow:[
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(0, 5),
            )
          ]
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center ,
          children: [
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle
              ),
              child: Icon(
                  icon,
                  size: 30,
                  color: color,
              ),
            ),
            SizedBox(height: 15,),
            Text(title, style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E50),
            ),
            ),
            SizedBox(height: 5,),
            Text(question, style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
            ),
          ],
        ),
      ) ,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF6C63FF),
              Color(0xFF3FD9D),
            ]
          )
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(15),

                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(0.9),
                            child: Icon(
                              Icons.person,
                              color: Color(0xFF6C63FF),
                            ),
                          ),
                          SizedBox(width: 10,),
                          Text("Tanviir", style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          )
                        ],
                      ),
                    ),
                    Icon(Icons.settings, color: Colors.white,)
                  ],
                ),
                SizedBox(height: 40,),
                Text("Ready to ", style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white.withOpacity(0.7)
                  ),
                ),
                Text("Challenge YourSelf ?", style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
                SizedBox(height: 20,),
                Text("Choose a category to start quiz", style: TextStyle(
                    fontSize: 16,
                    color: Colors.white.withOpacity(0.8)
                  ),
                ),
                SizedBox(height: 20,),
                Expanded(child: GridView.count(
                    crossAxisCount:2,
                  childAspectRatio: 0.85,
                    crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                    children: [
                      _buildCategoryCard(context, "Flutter Basics", Icons.flutter_dash, Color(0xFFFF6B6B), "10 Questions" ),
                      _buildCategoryCard(context, "Dart Programming", Icons.code, Color(0xFF4ECDC4), "15 Questions" ),
                      _buildCategoryCard(context, "UI Design", Icons.design_services, Color(0xFFFFBE0B), "10 Questions" ),
                      _buildCategoryCard(context, "State Management", Icons.category, Color(0xFF95E1D3), "10 Questions" ),
                    ],
                )
                )
              ],
            ),
          ),
        ),
      ) ,
    );
  }
}
