import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../providers/app_provider.dart';
import '../services/notification_service.dart';
import '../data/dummy_data.dart';
import '../models/exercise_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile', style: TextStyle(fontWeight: FontWeight.w600)),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 8),
            _buildProfileAvatar(context, provider),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => _showEditNameDialog(context, provider),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    provider.userName,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.edit, size: 18, color: Theme.of(context).primaryColor.withAlpha(150)),
                ],
              ),
            ),
            const SizedBox(height: 4),
            const Text('On a journey to better posture', style: TextStyle(fontSize: 14, color: Color(0xFF8E8E93))),
            const SizedBox(height: 28),
            _buildStatsRow(context, provider),
            const SizedBox(height: 28),
            _buildSectionHeader(context, 'Preferences'),
            const SizedBox(height: 12),
            _buildThemeToggleTile(context, provider),
            const SizedBox(height: 8),
            _buildDifficultySelector(context, provider),
            const SizedBox(height: 20),
            _buildSectionHeader(context, 'Settings'),
            const SizedBox(height: 12),
            _buildSettingsTile(context, Icons.notifications_outlined, 'Reminders', 'Set daily exercise reminders', onTap: () => _showReminderSettings(context)),
            _buildSettingsTile(context, Icons.cloud_download_outlined, 'Download HD Resources', 'Save exercise GIFs for offline HD playback', onTap: () => _showDownloadResources(context)),
            _buildSettingsTile(context, Icons.info_outline, 'Learn about Pectus Excavatum', 'Understanding your condition', onTap: () => _showLearnAboutPE(context)),
            _buildSettingsTile(context, Icons.help_outline, 'Help & Support', 'FAQ and contact us', onTap: () {}),
            const SizedBox(height: 32),
            Text('App made by Talha Riaz', style: TextStyle(fontSize: 13, color: Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(60), fontWeight: FontWeight.w500)),
            const SizedBox(height: 8),
            Text('v1.0.0', style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(35))),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileAvatar(BuildContext context, AppProvider provider) {
    return GestureDetector(
      onTap: () => _showProfilePictureOptions(context, provider),
      child: Stack(
        children: [
          Container(
            width: 110, height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Theme.of(context).primaryColor.withAlpha(80), width: 2.5),
              color: Theme.of(context).cardTheme.color,
            ),
            child: ClipOval(
              child: provider.profileImagePath != null && File(provider.profileImagePath!).existsSync()
                  ? Image.file(File(provider.profileImagePath!), fit: BoxFit.cover, width: 110, height: 110)
                  : Icon(Icons.person, size: 50, color: Theme.of(context).primaryColor),
            ),
          ),
          Positioned(
            bottom: 2, right: 2,
            child: Container(
              width: 34, height: 34,
              decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor),
              child: Icon(Icons.camera_alt, size: 18, color: Theme.of(context).scaffoldBackgroundColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow(BuildContext context, AppProvider provider) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(color: Theme.of(context).cardTheme.color, borderRadius: BorderRadius.circular(24)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatColumn(context, '${provider.completedSessions}', 'Sessions', Icons.fitness_center),
          Container(width: 1, height: 36, color: Theme.of(context).dividerColor),
          _buildStatColumn(context, '${provider.streakDays}', 'Day Streak', Icons.local_fire_department),
          Container(width: 1, height: 36, color: Theme.of(context).dividerColor),
          _buildStatColumn(context, '${provider.completedSessions * 5}', 'Minutes', Icons.timer),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(padding: const EdgeInsets.only(left: 4), child: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Theme.of(context).textTheme.bodyLarge?.color))),
    );
  }

  Widget _buildDifficultySelector(BuildContext context, AppProvider provider) {
    final levels = ['Easy', 'Medium', 'Hard'];
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(color: Theme.of(context).cardTheme.color, borderRadius: BorderRadius.circular(100)),
      child: Row(
        children: levels.map((level) {
          final isSelected = provider.difficultyLevel == level;
          return Expanded(
            child: GestureDetector(
              onTap: () => provider.setDifficultyLevel(level),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(color: isSelected ? Theme.of(context).primaryColor : Colors.transparent, borderRadius: BorderRadius.circular(100)),
                child: Center(child: Text(level, style: TextStyle(fontSize: 14, fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500, color: isSelected ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).textTheme.labelLarge?.color))),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildStatColumn(BuildContext context, String value, String label, IconData icon) {
    return Column(children: [
      Icon(icon, color: Theme.of(context).primaryColor, size: 20),
      const SizedBox(height: 8),
      Text(value, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color)),
      const SizedBox(height: 4),
      Text(label, style: TextStyle(fontSize: 12, color: Theme.of(context).textTheme.labelLarge?.color)),
    ]);
  }

  Widget _buildThemeToggleTile(BuildContext context, AppProvider provider) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: Theme.of(context).cardTheme.color, borderRadius: BorderRadius.circular(20)),
      child: SwitchListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        secondary: Container(width: 42, height: 42, decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor.withAlpha(20)), child: Icon(provider.isDarkMode ? Icons.dark_mode : Icons.light_mode, color: Theme.of(context).primaryColor, size: 20)),
        title: Text('Dark Mode', style: TextStyle(fontWeight: FontWeight.w600, color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: 15)),
        subtitle: Text('Toggle light and dark theme', style: TextStyle(fontSize: 13, color: Theme.of(context).textTheme.labelLarge?.color)),
        value: provider.isDarkMode,
        onChanged: (val) => provider.toggleTheme(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        activeTrackColor: Theme.of(context).primaryColor.withAlpha(100),
        activeThumbColor: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _buildSettingsTile(BuildContext context, IconData icon, String title, String subtitle, {required VoidCallback onTap}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: Theme.of(context).cardTheme.color, borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(width: 42, height: 42, decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor.withAlpha(20)), child: Icon(icon, color: Theme.of(context).primaryColor, size: 20)),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: Theme.of(context).textTheme.bodyLarge?.color, fontSize: 15)),
        subtitle: Text(subtitle, style: TextStyle(fontSize: 13, color: Theme.of(context).textTheme.labelLarge?.color)),
        trailing: Icon(Icons.chevron_right, color: Theme.of(context).textTheme.labelLarge?.color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onTap: onTap,
      ),
    );
  }

  // ─── Edit Name Dialog ───
  void _showEditNameDialog(BuildContext context, AppProvider provider) {
    final controller = TextEditingController(text: provider.userName);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A2E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Edit Name', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: TextField(
          controller: controller,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Enter your name',
            hintStyle: const TextStyle(color: Color(0xFF5A5A5E)),
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: const Color(0xFF4DD0E1).withAlpha(100))),
            focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF4DD0E1))),
          ),
          textCapitalization: TextCapitalization.words,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: Color(0xFF8E8E93))),
          ),
          ElevatedButton(
            onPressed: () async {
              if (controller.text.trim().isNotEmpty) {
                await provider.setUserName(controller.text.trim());
                if (context.mounted) Navigator.pop(ctx);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4DD0E1),
              foregroundColor: const Color(0xFF0D0D0F),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
            ),
            child: const Text('Save', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // ─── Profile Picture Picker ───
  void _showProfilePictureOptions(BuildContext context, AppProvider provider) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A2E),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Container(width: 40, height: 4, decoration: BoxDecoration(color: const Color(0xFF5A5A5E), borderRadius: BorderRadius.circular(100))),
              const SizedBox(height: 24),
              const Text('Profile Picture', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 20),
              _buildSheetOption(ctx, Icons.camera_alt_outlined, 'Take a Photo', () async {
                Navigator.pop(ctx);
                await _pickImage(context, provider, ImageSource.camera);
              }),
              const SizedBox(height: 10),
              _buildSheetOption(ctx, Icons.photo_library_outlined, 'Choose from Gallery', () async {
                Navigator.pop(ctx);
                await _pickImage(context, provider, ImageSource.gallery);
              }),
              if (provider.profileImagePath != null) ...[
                const SizedBox(height: 10),
                _buildSheetOption(ctx, Icons.delete_outline, 'Remove Photo', () async {
                  Navigator.pop(ctx);
                  await provider.setProfileImagePath('');
                }),
              ],
              const SizedBox(height: 16),
            ]),
          ),
        );
      },
    );
  }

  Future<void> _pickImage(BuildContext context, AppProvider provider, ImageSource source) async {
    try {
      final picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(source: source, maxWidth: 512, maxHeight: 512, imageQuality: 80);
      if (pickedFile == null) return;

      // Copy to app's permanent directory
      final appDir = await getApplicationDocumentsDirectory();
      final ext = pickedFile.path.contains('.') ? '.${pickedFile.path.split('.').last}' : '.jpg';
      final fileName = 'profile_${DateTime.now().millisecondsSinceEpoch}$ext';
      final savedFile = await File(pickedFile.path).copy('${appDir.path}/$fileName');

      await provider.setProfileImagePath(savedFile.path);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Profile picture updated!'),
            backgroundColor: const Color(0xFF1A1A2E),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          ),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not pick image: $e'),
            backgroundColor: Colors.red[900],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          ),
        );
      }
    }
  }

  Widget _buildSheetOption(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
        decoration: BoxDecoration(color: const Color(0xFF262640), borderRadius: BorderRadius.circular(100)),
        child: Row(children: [
          Icon(icon, color: const Color(0xFF4DD0E1), size: 22),
          const SizedBox(width: 14),
          Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white)),
          const Spacer(),
          const Icon(Icons.chevron_right, color: Color(0xFF5A5A5E)),
        ]),
      ),
    );
  }

  // ─── Reminder Settings ───
  void _showReminderSettings(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A2E),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (ctx) => const _ReminderSettingsSheet(),
    );
  }

  // ─── Learn About PE ───
  void _showLearnAboutPE(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A2E),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.75, maxChildSize: 0.9, minChildSize: 0.5, expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.all(24),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: const Color(0xFF5A5A5E), borderRadius: BorderRadius.circular(100)))),
                const SizedBox(height: 24),
                const Center(child: Text('About Pectus Excavatum', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white))),
                const SizedBox(height: 24),
                _infoSection('What is Pectus Excavatum?', 'Pectus Excavatum (PE) is the most common congenital chest wall deformity, affecting approximately 1 in 300-400 people. It occurs when the breastbone (sternum) is sunken into the chest, creating a concave or "funnel" appearance.'),
                _infoSection('Causes', 'The exact cause is unknown, but it is believed to be related to abnormal growth of cartilage connecting the ribs to the sternum. It often runs in families and is more common in males.'),
                _infoSection('Symptoms', '• Chest pain or discomfort\n• Shortness of breath during exercise\n• Decreased exercise tolerance\n• Rapid heartbeat\n• Fatigue\n• Poor posture'),
                _infoSection('How Exercise Helps', 'While exercise cannot fully correct PE, regular targeted exercises can:\n\n• Improve posture and chest appearance\n• Strengthen chest and back muscles\n• Increase lung capacity\n• Boost cardiovascular fitness\n• Build confidence and mental resilience'),
                _infoSection('Important Note', 'This app is designed as a supportive tool. Always consult with a healthcare professional for personalized medical advice about your condition.'),
                const SizedBox(height: 12),
                _infoSection('Developer & Portfolio', 'This app is designed and developed by Talha Riaz. For more fitness tools, apps, and portfolios, visit the link below.'),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final uri = Uri.parse('https://bytalhar.com');
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri, mode: LaunchMode.externalApplication);
                      }
                    },
                    icon: const Icon(Icons.language, size: 18),
                    label: const Text('Visit bytalhar.com', style: TextStyle(fontWeight: FontWeight.bold)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4DD0E1).withAlpha(30),
                      foregroundColor: const Color(0xFF4DD0E1),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                        side: const BorderSide(color: Color(0xFF4DD0E1), width: 0.5),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ]),
            );
          },
        );
      },
    );
  }

  Widget _infoSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Color(0xFF4DD0E1))),
        const SizedBox(height: 8),
        Text(content, style: const TextStyle(fontSize: 14, color: Color(0xFFB0B0B8), height: 1.6)),
      ]),
    );
  }
}

// ─── Reminder Settings Stateful Sheet ───
class _ReminderSettingsSheet extends StatefulWidget {
  const _ReminderSettingsSheet();

  @override
  State<_ReminderSettingsSheet> createState() => _ReminderSettingsSheetState();
}

class _ReminderSettingsSheetState extends State<_ReminderSettingsSheet> {
  final NotificationService _notifService = NotificationService();
  bool _enabled = false;
  TimeOfDay _selectedTime = const TimeOfDay(hour: 9, minute: 0);
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final enabled = await _notifService.isReminderEnabled();
    final hour = await _notifService.getReminderHour();
    final minute = await _notifService.getReminderMinute();
    if (mounted) {
      setState(() {
        _enabled = enabled;
        _selectedTime = TimeOfDay(hour: hour, minute: minute);
        _loading = false;
      });
    }
  }

  Future<void> _toggleReminder(bool value) async {
    try {
      if (value) {
        // Request permissions (only prompts on Android 13+)
        final granted = await _notifService.requestPermissions();
        
        // On older Androids, it might return false but still work, 
        // so we only block if we're sure it's denied on newer versions.
        // For now, let's try to schedule anyway and only alert if it fails.
        
        await _notifService.scheduleDailyReminder(
          hour: _selectedTime.hour, 
          minute: _selectedTime.minute
        );
        
        if (mounted) {
          setState(() => _enabled = true);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Reminders enabled!'),
              backgroundColor: const Color(0xFF4DD0E1).withAlpha(100),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
            ),
          );
        }
        
        // Send a test notification to confirm it's working
        await _notifService.sendTestNotification();
      } else {
        await _notifService.cancelAllReminders();
        if (mounted) {
          setState(() => _enabled = false);
        }
      }
    } catch (e) {
      debugPrint('Reminder toggle error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red[900],
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          ),
        );
      }
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(primary: Color(0xFF4DD0E1), surface: Color(0xFF1A1A2E), onSurface: Colors.white),
            timePickerTheme: TimePickerThemeData(backgroundColor: const Color(0xFF1A1A2E), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && mounted) {
      setState(() => _selectedTime = picked);
      if (_enabled) {
        await _notifService.scheduleDailyReminder(hour: picked.hour, minute: picked.minute);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Container(width: 40, height: 4, decoration: BoxDecoration(color: const Color(0xFF5A5A5E), borderRadius: BorderRadius.circular(100))),
          const SizedBox(height: 24),
          const Text('Exercise Reminders', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 8),
          const Text('Get daily reminders to do your exercises', style: TextStyle(fontSize: 14, color: Color(0xFF8E8E93))),
          const SizedBox(height: 24),
          if (_loading)
            const CircularProgressIndicator(color: Color(0xFF4DD0E1))
          else ...[
            // Enable toggle
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              decoration: BoxDecoration(color: const Color(0xFF262640), borderRadius: BorderRadius.circular(20)),
              child: SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Daily Reminder', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                subtitle: Text(_enabled ? 'Enabled' : 'Disabled', style: const TextStyle(color: Color(0xFF8E8E93), fontSize: 13)),
                value: _enabled,
                onChanged: _toggleReminder,
                activeThumbColor: const Color(0xFF4DD0E1),
                inactiveTrackColor: const Color(0xFF3A3A4E),
              ),
            ),
            const SizedBox(height: 14),
            // Time picker
            GestureDetector(
              onTap: _pickTime,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                decoration: BoxDecoration(color: const Color(0xFF262640), borderRadius: BorderRadius.circular(20)),
                child: Row(children: [
                  const Icon(Icons.access_time, color: Color(0xFF4DD0E1), size: 22),
                  const SizedBox(width: 14),
                  const Text('Reminder Time', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15)),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(color: const Color(0xFF4DD0E1).withAlpha(20), borderRadius: BorderRadius.circular(100), border: Border.all(color: const Color(0xFF4DD0E1).withAlpha(40))),
                    child: Text(_selectedTime.format(context), style: const TextStyle(color: Color(0xFF4DD0E1), fontWeight: FontWeight.w700, fontSize: 15)),
                  ),
                ]),
              ),
            ),
          ],
          const SizedBox(height: 24),
        ]),
      ),
    );
  }
}

void _showDownloadResources(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xFF13131A),
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
    builder: (context) => const _DownloadResourcesDialog(),
  );
}

class _DownloadResourcesDialog extends StatefulWidget {
  const _DownloadResourcesDialog();

  @override
  State<_DownloadResourcesDialog> createState() => _DownloadResourcesDialogState();
}

class _DownloadResourcesDialogState extends State<_DownloadResourcesDialog> {
  bool _isLoading = true;
  bool _isDownloading = false;
  int _totalGifs = 0;
  int _downloadedCount = 0;
  String _currentDownloadingName = '';
  List<Exercise> _gifsToDownload = [];

  @override
  void initState() {
    super.initState();
    _checkStatus();
  }

  Future<void> _checkStatus() async {
    final directory = await getApplicationDocumentsDirectory();
    final gifsDir = Directory('${directory.path}/gifs');
    if (!await gifsDir.exists()) {
      await gifsDir.create(recursive: true);
    }

    final toDownload = dummyExercises.where((e) => e.gifUrl != null).toList();
    int count = 0;

    for (final exercise in toDownload) {
      final fileName = exercise.gifUrl!.split('/').last;
      final file = File('${gifsDir.path}/$fileName');
      if (await file.exists()) {
        count++;
      }
    }

    if (mounted) {
      setState(() {
        _gifsToDownload = toDownload;
        _totalGifs = toDownload.length;
        _downloadedCount = count;
        _isLoading = false;
      });
    }
  }

  Future<void> _startDownload() async {
    setState(() {
      _isDownloading = true;
    });

    final directory = await getApplicationDocumentsDirectory();
    final gifsDir = Directory('${directory.path}/gifs');

    try {
      for (final exercise in _gifsToDownload) {
        if (!mounted) break;
        final fileName = exercise.gifUrl!.split('/').last;
        final file = File('${gifsDir.path}/$fileName');

        if (!await file.exists()) {
          setState(() {
            _currentDownloadingName = exercise.title;
          });

          final response = await http.get(Uri.parse(exercise.gifUrl!));
          if (response.statusCode == 200) {
            await file.writeAsBytes(response.bodyBytes);
          }
        }

        if (mounted) {
          setState(() {
            _downloadedCount++;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Download interrupted: $e'),
            backgroundColor: Colors.red[900],
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isDownloading = false;
          _currentDownloadingName = '';
        });
        if (_downloadedCount == _totalGifs) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('All HD Resources downloaded successfully!'),
              backgroundColor: Colors.green[900],
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = _totalGifs > 0 ? _downloadedCount / _totalGifs : 0.0;
    final allDownloaded = _downloadedCount == _totalGifs;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFF5A5A5E),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'HD Exercise Resources',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Download high definition animated guides to your device for instant, offline, and blurry-free playback.',
              style: TextStyle(fontSize: 14, color: Color(0xFF8E8E93)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 28),
            if (_isLoading)
              const Center(child: CircularProgressIndicator(color: Color(0xFF4DD0E1)))
            else ...[
              // Progress Bar
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 10,
                  backgroundColor: const Color(0xFF262640),
                  color: const Color(0xFF4DD0E1),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _isDownloading
                        ? 'Downloading: $_currentDownloadingName'
                        : allDownloaded
                            ? 'All resources downloaded'
                            : 'Ready to download',
                    style: const TextStyle(color: Color(0xFF8E8E93), fontSize: 13),
                  ),
                  Text(
                    '$_downloadedCount / $_totalGifs',
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              if (!allDownloaded && !_isDownloading)
                ElevatedButton(
                  onPressed: _startDownload,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4DD0E1),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                  ),
                  child: const Text('Download Now', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                )
              else if (_isDownloading)
                ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF262640),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(color: Colors.white70, strokeWidth: 2),
                      ),
                      SizedBox(width: 12),
                      Text('Downloading...', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                )
              else
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF262640),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                  ),
                  child: const Text('Close', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
            ],
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
