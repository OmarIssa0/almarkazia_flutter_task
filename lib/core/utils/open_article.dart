import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openArticle(BuildContext context, String articleUrl) async {
  final messenger = ScaffoldMessenger.maybeOf(context);
  final uri = Uri.tryParse(articleUrl);

  if (uri == null || !(uri.isScheme('http') || uri.isScheme('https'))) {
    _showMessage(messenger, 'Invalid article URL');
    return;
  }

  final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);

  if (!launched) {
    _showMessage(messenger, 'Could not open article');
  }
}

void _showMessage(ScaffoldMessengerState? messenger, String message) {
  if (messenger == null || !messenger.mounted) {
    return;
  }

  messenger.showSnackBar(SnackBar(content: Text(message)));
}
