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
 List<Project> projectsList = [
  Project(
    name: 'Smart Budget',
    details: '''
Built a full-stack Flutter application using Clean Architecture and Bloc state management. Integrated Supabase APIs with secure authentication, real-time synchronization, and responsive UI design. Focused on scalability, performance optimization, and clean code practices.
''',
    image: 'assets/images/smart_budget.png',
    link: 'https://github.com/AhmedTalat99/smart_budget.git',
  ),

  Project(
    name: 'Autikid',
    details: '''
Developed an AI-powered educational Flutter application for autistic children by integrating a Visual Question Answering (VQA) model with external APIs. Implemented Cubit state management and focused on accessibility, responsive UI, and smooth user experience.
''',
    image: 'assets/images/autikid.png',
    link:
        'https://github.com/VqaGraduationTeam/graduation_project_flutter.git',
  ),

  Project(
    name: 'Medical Clinic',
    details: '''
Collaborated within a multidisciplinary team to develop a medical clinic application using Flutter. Focused on responsive UI implementation, clean architecture principles, API integration, and improving overall usability and performance.
''',
    image: 'assets/images/medical.png',
    link: 'https://github.com/AhmedTalat99/medicalclinic_team13',
  ),

  Project(
    name: 'OnShoda',
    details: '''
Developed a media streaming Flutter application with audio playback and offline local storage using Hive. Implemented Provider state management and optimized application performance to ensure a smooth and responsive user experience.
''',
    image: 'assets/images/onshoda.png',
    link: 'https://github.com/AhmedTalat99/onshoda.git',
    
  ),

  Project(
    name: 'Dashboard',
    details: '''
Developed a responsive cross-platform Flutter dashboard supporting mobile, tablet, and desktop devices. Built reusable UI components and optimized performance to ensure a smooth and consistent user experience across different screen sizes.
''',
    image: 'assets/images/dashboard.png',
    link: 'https://github.com/AhmedTalat99/responsive_dash_board.git',
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
      itemCount: projectsList.length,
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
                        image: AssetImage(projectsList[index].image),
                        fit: BoxFit.fill),
                  ),
                ),
                Visibility(
                  visible: index == hoveredIndex,
                  child: GestureDetector(
                    onTap: () {
                      launchLink(projectsList[index].link);
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
                              AppColors.themeColor.withValues(alpha: 1.0),
                              AppColors.themeColor.withValues(alpha: 0.9),
                              AppColors.themeColor.withValues(alpha: 0.8),
                              AppColors.themeColor.withValues(alpha: 0.6),
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter),
                      ),
                      child: Column(
                        children: [
                          Text(
                            projectsList[index].name,
                            style: AppTextStyles.montserratStyle(
                                color: Colors.black87, fontSize: 20),
                          ),
                          Constants.sizedBox(height: 15.0),
                          Text(
                            projectsList[index].details,
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
