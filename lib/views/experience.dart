import 'package:flutter/material.dart';

import '../models/experience_model.dart';

class Experience extends StatelessWidget {
   Experience({super.key});
final List<ExperienceModel> experiences = [
  ExperienceModel(
    title: "Flutter Developer",
    company: "Freelance",
    period: "Jul 2024 - Nov 2024",
    description:
        "Built scalable Flutter apps including an educational app (Sawa) and an AI-powered web app, with Firebase integration and a focus on clean architecture, performance, and responsive UI/UX.",
  ),
  ExperienceModel(
    title: "Flutter Developer Intern",
    company: "SimulationFirms",
    period: "Mar 2024 - Apr 2024",
    description:
        "Worked on building UI components using Flutter, improved state management using Bloc, and collaborated in team-based development.",
  ),
  ExperienceModel(
    title: "Mentor Flutter Developer",
    company: "SameCourse",
    period: "Dec 2023 - Jan 2024",
    description:
        "Mentored junior developers in Flutter fundamentals, UI design, and best practices for clean architecture.",
  ),
  ExperienceModel(
    title: "Freelance Flutter Developer",
    company: "Self-employed",
    period: "2024 - Present",
    description:
        "Developed multiple mobile applications including portfolio apps, learning apps, and business solutions using Flutter & Firebase.",
  ),
];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Experience",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 30),

          Column(
            children: experiences
                .asMap()
                .entries
                .map((entry) => buildTimelineItem(entry.value, entry.key))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget buildTimelineItem(ExperienceModel exp, int index) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Timeline line
        Column(
          children: [
            Container(
              width: 14,
              height: 14,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
            if (index != experiences.length - 1)
              Container(
                width: 2,
                height: 100,
                color: Colors.blue,
              ),
          ],
        ),

        const SizedBox(width: 20),

        // Card
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 30),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xff1E1E2C),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exp.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "${exp.company} • ${exp.period}",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade400,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  exp.description,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade300,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}