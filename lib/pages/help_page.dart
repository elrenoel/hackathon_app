import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F2FA),
      appBar: AppBar(
        title: const Text('Help & Support'),
        backgroundColor: const Color(0xFFD9C8F3),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: const [
          _HelpItem(
            question: 'What is Deep Read?',
            answer:
                'Deep Read helps you focus by reading articles slowly and mindfully without distractions.',
          ),
          _HelpItem(
            question: 'How is reading progress calculated?',
            answer:
                'Progress is based on reading duration and how much content you scroll through.',
          ),
          _HelpItem(
            question: 'Why can’t I read more articles?',
            answer:
                'You may have reached your daily reading target. Come back tomorrow to continue.',
          ),
          SizedBox(height: 20),
          _HelpInfoItem(
            icon: Icons.email_outlined,
            title: 'Contact Support',
            subtitle: 'support@deepread.app',
          ),
          SizedBox(height: 12),
          _HelpInfoItem(
            icon: Icons.info_outline,
            title: 'App Version',
            subtitle: 'v1.0.0',
          ),
        ],
      ),
    );
  }
}

class _HelpItem extends StatelessWidget {
  final String question;
  final String answer;

  const _HelpItem({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(answer, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _HelpInfoItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _HelpInfoItem({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF7C4DFF)),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.bodyMedium),
              Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ],
      ),
    );
  }
}
