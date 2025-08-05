
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:project_timerbox/model/timer.dart';
// import 'package:project_timerbox/services/function.dart';
// class ChartPage extends StatefulWidget {
//   const ChartPage({super.key});

//   @override
//   State<ChartPage> createState() => _ChartPageState();
// }

// class _ChartPageState extends State<ChartPage> {
//   // Colors for ranking
//   final List<Color> rankColors = [
//     const Color.fromARGB(255, 129, 25, 18),         // Highest
//     const Color.fromARGB(255, 218, 75, 18),      // 2nd
//     const Color.fromARGB(255, 226, 137, 59),        // 3rd
//     const Color.fromARGB(255, 201, 196, 36),       // 4th
//     const Color.fromARGB(255, 79, 141, 7),      // 5th
//     const Color.fromARGB(255, 5, 92, 56),        // 6th+
//   ];

//   @override
//   void initState() {
//     getData(); // Fetch Hive data
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      // appBar:  PreferredSize(preferredSize: Size.fromHeight(80),
      //       child: Container(
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      //           color: const Color.fromARGB(255, 10, 90, 35),),
      //         child: SafeArea(
      //           child:Center(
      //             child: Row(
      //               children: [
      //                   SizedBox(width: 8,),
      //                   IconButton(onPressed: (){Navigator.pop(context);}, icon: Icon(Icons.arrow_back,color: Colors.white,size: 24,)),
      //                   SizedBox(width: 42,),
      //                   const Text('Task Duration Chart',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold,),),
      //               ],
      //             ),
      //           ) ),
      //       ),
      //     ),
//       body: ValueListenableBuilder(
//         valueListenable: valueNotifier, 
//         builder: (context, List<Activity> activities, child) {
//           if(activities.isEmpty){
//             return Center(child: Text('No data available'),);
//           }
//          activities.sort((a,b)=>b.duration.compareTo(a.duration));
//          List<PieChartSectionData> sections=[];
//          for(int i=0;i<activities.length;i++){
//               final activity=activities[i];
//               final color = chartColors[i % chartColors.length]; // Cycle colors
//               final radius = 60 - (i * 5);
//               sections.add(
//               PieChartSectionData(
//                 value: activity.duration.toDouble(),
//                 title: "${activity.title}\n${activity.duration} min",
//                 color: color,
//                 radius: radius < 30 ? 30 : radius, // Set minimum size
//                 titleStyle: const TextStyle(
//                   color: Colors.white,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 12,
//                 ),
//               ),
//             );
//          }
//           return Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: PieChart(
//               PieChartData(
//                 sections: sections,
//                 centerSpaceRadius: 40,
//                 sectionsSpace: 2,
//               ),
//             ),
//           );
//        },
//         ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:project_timerbox/services/function.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});
  @override
  State<ChartPage> createState() => ChartPageState();
}

class ChartPageState extends State<ChartPage> {
  @override
  void initState() {
      getData(); 
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(preferredSize: Size.fromHeight(80),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
                color: const Color.fromARGB(255, 10, 90, 35),),
              child: SafeArea(
                child:Center(
                  child: 
                   const Text('Task Duration Chart',style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold,),),
                ) ),
            ),
          ),
    body: ValueListenableBuilder(
            valueListenable: valueNotifier,
                builder: (context,tasks, _) {
                    if (tasks.isEmpty) {
                      return Center(child: Text("No task data"));
                  }

        tasks.sort((a, b) => b.duration.compareTo(a.duration));

       final chartColors = [
      const Color.fromARGB(255, 164, 29, 19),
      const Color.fromARGB(255, 9, 58, 98),
      const Color.fromARGB(255, 223, 135, 3),
      const Color.fromARGB(255, 37, 133, 40),
      Colors.purple,
      Colors.teal,
      Colors.orange,
      ];

      List<PieChartSectionData> sections = [];

     for (int i = 0; i < tasks.length; i++) {
      final color = chartColors[i % chartColors.length];

      sections.add(
        PieChartSectionData(
          value: tasks[i].duration.toDouble(),
          title: "${tasks[i].duration} min",
          color: color,
          radius: 45, 
          titleStyle: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      );
     }
     return Padding(
       padding: const EdgeInsets.all(25),
      
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 250,
            child: PieChart(
              PieChartData(
                sections: sections,
                centerSpaceRadius: 40,
                sectionsSpace: 2,
              ),
            ),
           
          ),

          const SizedBox(height: 20),
          
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             Wrap(
              spacing: 10,
              children: [
                for(int i=0;i<tasks.length;i++)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 15,
                      height: 15,
                      color: chartColors[i%chartColors.length],
                    ),
                  SizedBox(width: 6,),
                  Text(
                  tasks[i].title,
                  style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.black, 
                ),
                ),
               ],
                )
              ],
             )
            ],
          ),
          SizedBox(height: 20),
          Text(
            "Most time spent: ${tasks.first.title} (${tasks.first.duration} min)",style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
   },
  )
 );
 }
}

