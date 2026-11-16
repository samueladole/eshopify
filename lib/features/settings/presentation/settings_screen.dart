import 'package:flutter/material.dart';
import '../../../core/state/app_state.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override Widget build(BuildContext context) {
    final app = AppStateScope.of(context);
    return Scaffold(appBar: AppBar(title: const Text('Settings')), body: ListView(children: [
      const _Head('Appearance'),
      RadioListTile<ThemeMode>(title: const Text('System'), value: ThemeMode.system, groupValue: app.themeMode, onChanged: (v) => app.toggleTheme(v!)),
      RadioListTile<ThemeMode>(title: const Text('Light'), value: ThemeMode.light, groupValue: app.themeMode, onChanged: (v) => app.toggleTheme(v!)),
      RadioListTile<ThemeMode>(title: const Text('Dark'), value: ThemeMode.dark, groupValue: app.themeMode, onChanged: (v) => app.toggleTheme(v!)),
      const Divider(),
      const _Head('Preferences'),
      ListTile(title: const Text('Language'), subtitle: Text(app.language), trailing: const Icon(Icons.chevron_right), onTap: () => _pick(context, 'Language', ['English','Spanish','French'], app.setLanguage)),
      ListTile(title: const Text('Currency'), subtitle: Text(app.currency), trailing: const Icon(Icons.chevron_right), onTap: () => _pick(context, 'Currency', ['USD','EUR','GBP'], app.setCurrency)),
      SwitchListTile(title: const Text('Order notifications'), value: app.orderNotifications, onChanged: app.setOrderNotifications),
      SwitchListTile(title: const Text('Promotional notifications'), value: app.promoNotifications, onChanged: app.setPromoNotifications),
      const Divider(),
      const _Head('Legal & About'),
      ListTile(title: const Text('Privacy Policy'), trailing: const Icon(Icons.open_in_new), onTap: () {}),
      ListTile(title: const Text('Terms of Service'), trailing: const Icon(Icons.open_in_new), onTap: () {}),
      ListTile(title: const Text('Delete Account'), textColor: Colors.red, leading: const Icon(Icons.delete_outline, color: Colors.red), onTap: () {}),
      const ListTile(title: Text('App Version'), subtitle: Text('1.0.0 (UI demo)')),
    ]));
  }
  void _pick(BuildContext context, String title, List<String> opts, ValueChanged<String> onPick) => showModalBottomSheet(context: context, showDragHandle: true, builder: (_) => SafeArea(child: Column(mainAxisSize: MainAxisSize.min, children: [Padding(padding: const EdgeInsets.all(16), child: Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18))), ...opts.map((o) => ListTile(title: Text(o), onTap: () { onPick(o); Navigator.pop(context); }))])));
}
class _Head extends StatelessWidget { final String t; const _Head(this.t); @override Widget build(BuildContext context) => Padding(padding: const EdgeInsets.fromLTRB(16,16,16,4), child: Text(t, style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w700))); }
