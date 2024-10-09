import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:portflolio/globals/app_assets.dart';

import '../globals/app_colors.dart';
import '../globals/app_text_styles.dart';
import '../globals/constants.dart';
import '../globals/launch_link.dart';
import '../helper/helper_class.dart';
import '../models/project.dart';

class Projects extends StatefulWidget {
  const Projects({super.key});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  final onH0verEffect = Matrix4.identity()..scale(1.0);
  List<Project> projects = [
    Project(
      name: 'Medical Clinic',
      details:
          '• Collaborated on the design and development of a comprehensive medical clinic application, focusing on user-friendly interfaces and efficient functionality.',
      image: 'assets/images/medical.png',
      link: 'https://github.com/AhmedTalat99/medicalclinic_team13',
    ),
    Project(
      name: 'Autikid',
      details: '''
Developed an educational app for autistic children using Dart and Flutter, integrated with a Visual Question Answering (VQA) model to assist in improving their abilities.
''',
      image: 'assets/images/autikid.png',
      link:
          'https://github.com/VqaGraduationTeam/graduation_project_flutter.git',
    ),
    Project(
      name: 'Dashboard',
      details: '''
Developed a cross-platform app for smartphones, tablets, and desktops with a responsive design using Flutter to ensure a smooth and consistent user experience
''',
      image: 'assets/images/dashboard.png',
      link: 'https://github.com/AhmedTalat99/responsive_dash_board.git',
    ),
    Project(
      name: 'Services',
      details: '''
Developed a shopping app that displays various services for customers, featuring API integration for data fetching and English-Arabic language 
''',
      image: 'assets/images/services.png',
      link: 'https://github.com/AhmedTalat99/services.git',
    ),
    Project(
      name: 'Notes',
      details: '''
     I created a notes app that stores and edits notes locally using Hive for local storage and Cubit for efficient state management.
''',
      image: 'assets/images/notes.jpeg',
      link: 'https://github.com/AhmedTalat99/Notes.git',
    ),
  ];

/*   List images = <String>[
    AppAssets.work1,
    AppAssets.work2,
    AppAssets.work1,
    AppAssets.work2,
    AppAssets.work1,
    AppAssets.work2,
  ]; */

  var hoveredIndex;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return HelperClass(
      mobile: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildProjectText(),
          Constants.sizedBox(height: 40.0),
          buildProjectGridView(crossAxisCount: 1)
        ],
      ),
      tablet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildProjectText(),
          Constants.sizedBox(height: 40.0),
          buildProjectGridView(crossAxisCount: 2)
        ],
      ),
      desktop: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          buildProjectText(),
          Constants.sizedBox(height: 40.0),
          buildProjectGridView(crossAxisCount: 3),
        ],
      ),
      paddingWidth: size.width * 0.1,
      bgColor: AppColors.bgColor2,
    );
  }

  GridView buildProjectGridView({required int crossAxisCount}) {
    return GridView.builder(
      itemCount: projects.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisExtent: 280,
        mainAxisSpacing: 24,
        crossAxisSpacing: 24,
      ),
      itemBuilder: (context, index) {
        // var image = images[index];
        return FadeInUpBig(
          duration: const Duration(milliseconds: 1600),
          child: InkWell(
            onTap: () {},
            onHover: (value) {
              setState(() {
                if (value) {
                  hoveredIndex = index;
                } else {
                  hoveredIndex = null;
                }
              });
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        image: AssetImage(projects[index].image),
                        fit: BoxFit.fill),
                  ),
                ),
                Visibility(
                  visible: index == hoveredIndex,
                  child: GestureDetector(
                    onTap: () {
                      launchLink(projects[index].link);
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 600),
                      transform: index == hoveredIndex ? onH0verEffect : null,
                      curve: Curves.easeIn,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                            colors: [
                              AppColors.themeColor.withOpacity(1.0),
                              AppColors.themeColor.withOpacity(0.9),
                              AppColors.themeColor.withOpacity(0.8),
                              AppColors.themeColor.withOpacity(0.6),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter),
                      ),
                      child: Column(
                        children: [
                          Text(
                            projects[index].name,
                            style: AppTextStyles.montserratStyle(
                                color: Colors.black87, fontSize: 20),
                          ),
                          Constants.sizedBox(height: 15.0),
                          Text(
                            projects[index].details,
                            style: AppTextStyles.normalStyle(
                                color: Colors.black87),
                            textAlign: TextAlign.center,
                          ),
                          Constants.sizedBox(height: 30.0),
                          CircleAvatar(
                            maxRadius: 25,
                            backgroundColor: Colors.white,
                            child: Image.asset(
                              AppAssets.share,
                              width: 25,
                              height: 25,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  FadeInDown buildProjectText() {
    return FadeInDown(
      duration: const Duration(milliseconds: 1200),
      child: RichText(
        text: TextSpan(
          text: 'Latest ',
          style: AppTextStyles.headingStyles(fontSize: 30.0),
          children: [
            TextSpan(
              text: 'Projects',
              style: AppTextStyles.headingStyles(
                  fontSize: 30, color: AppColors.robinEdgeBlue),
            )
          ],
        ),
      ),
    );
  }
}
