import 'package:flutter/material.dart';
import 'package:flutter_mobile/src/api/model/dashboard.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sizer/sizer.dart';
import '../Widget/color.dart';
import '../Widget/task_group.dart';
import 'package:flutter_mobile/src/api/api.dart';
import '../Widget/customAppBarr.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  Dashboard dashboard = Dashboard();

  @override
  void initState() {
    API.dashboard(context).then((value) {
      setState(() {
        dashboard = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: ClipPath(
            clipper: CustomAppBar(),
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              color: Color(0xff4d87b7),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Selamat Datang",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 36,
                      color: Colors.white,
                    ),
                  ),
                  // Align(
                  //   alignment: Alignment.center,
                  Container(
                      child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      dashboard.nama.toString(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.blue[100],
                          fontSize: 24,
                          fontWeight: FontWeight.w700),
                    ),
                  )),

                  // ),
                ],
              ),
            ),
          ),
          preferredSize: Size.fromHeight(kToolbarHeight + 120)),
      extendBody: true,
      body: _buildBody(),
    );
  }

  Stack _buildBody() {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      buildGrid(),
                      const SizedBox(
                        height: 25,
                      ),
                      // _onGoingHeader(),
                      const SizedBox(
                        height: 10,
                      ),
                      // const OnGoingTask(),
                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  StaggeredGrid buildGrid() {
    return StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 15,
      crossAxisSpacing: 15,
      children: [
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1.3,
          child: TaskGroupContainer(
            color: Colors.pink,
            icon: Icons.flip_camera_android,
            taskCount: dashboard.log_mobilitas,
            taskGroup: "Mobilitas",
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1,
          child: TaskGroupContainer(
            color: Colors.deepOrange,
            isSmall: true,
            icon: Icons.person,
            taskCount: -1,
            taskGroup: "Profil",
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1.3,
          child: TaskGroupContainer(
            color: Colors.green,
            icon: Icons.inventory,
            taskCount: dashboard.log_peminjaman,
            taskGroup: "Peminjaman",
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 1,
          mainAxisCellCount: 1.1,
          child: TaskGroupContainer(
            color: Colors.blue,
            isSmall: true,
            icon: Icons.info,
            taskCount: -1,
            taskGroup: "Tentang Aplikasi",
          ),
        ),
      ],
    );
  }
}

class OnGoingTask extends StatelessWidget {
  const OnGoingTask({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(
        20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      width: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 60,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Startup Website Design with Responsive",
                  style: TextStyle(
                    color: Colors.blueGrey[700],
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.timelapse,
                      color: Colors.purple[300],
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "10:00 AM - 12:30PM",
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.purple[50],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Text(
                    "Complete - 80%",
                    style: TextStyle(
                      color: Colors.purple,
                    ),
                  ),
                )
              ],
            ),
          ),
          const Icon(
            Icons.rocket_rounded,
            size: 60,
            color: Colors.orange,
          )
        ],
      ),
    );
  }
}

// class BottomNavClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path = Path();

//     path.lineTo(0, size.height);
//     path.lineTo(size.width, size.height);
//     path.lineTo(size.width, 0);

//     final firstControlPoint = Offset(size.width * 0.6, 0);
//     final firstEndPoint = Offset(size.width * 0.58, 44);
//     path.quadraticBezierTo(
//       firstControlPoint.dx,
//       firstControlPoint.dy,
//       firstEndPoint.dx,
//       firstEndPoint.dy,
//     );

//     final secControlPoint = Offset(size.width * 0.55, 50);
//     final secEndPoint = Offset(size.width * 0.5, 50);
//     path.quadraticBezierTo(
//       secControlPoint.dx,
//       secControlPoint.dy,
//       secEndPoint.dx,
//       secEndPoint.dy,
//     );

// //     path.lineTo(size.width * 0.45, 30);

// //     final lastControlPoint = Offset(size.width * 0.45, 20);
// //     final lastEndPoint = Offset(size.width * 0.2, 30);
// //     path.quadraticBezierTo(
// //       lastControlPoint.dx,
// //       lastControlPoint.dy,
// //       lastEndPoint.dx,
// //       lastEndPoint.dy,
// //     );

//     path.close();

//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }
