import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/common_widgets.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  @override Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Padding(padding: const EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const Spacer(),
      Icon(Icons.storefront_rounded, size: 88, color: Theme.of(context).colorScheme.primary),
      const SizedBox(height: 16),
      Text('Welcome to Eshopify', textAlign: TextAlign.center, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w800)),
      const SizedBox(height: 8),
      const Text('Shop smarter with a premium, fast, and secure experience.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
      const Spacer(),
      PrimaryButton(label: 'Log In', onPressed: () => context.push('/login')),
      const SizedBox(height: 12),
      SecondaryButton(label: 'Create Account', onPressed: () => context.push('/signup')),
      const SizedBox(height: 12),
      TextButton(onPressed: () => context.go('/home'), child: const Text('Continue as Guest')),
    ]))));
  }
}

class _SocialButtons extends StatelessWidget {
  const _SocialButtons();
  @override Widget build(BuildContext context) {
    Widget btn(String label, IconData icon) => OutlinedButton.icon(onPressed: () {}, icon: Icon(icon), label: Text(label), style: OutlinedButton.styleFrom(minimumSize: const Size.fromHeight(48), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))));
    return Column(children: [btn('Continue with Google', Icons.g_mobiledata), const SizedBox(height: 10), btn('Continue with Apple', Icons.apple), const SizedBox(height: 10), btn('Continue with Facebook', Icons.facebook)]);
  }
}

class LoginScreen extends StatefulWidget { const LoginScreen({super.key}); @override State<LoginScreen> createState() => _LoginScreenState(); }
class _LoginScreenState extends State<LoginScreen> {
  final _form = GlobalKey<FormState>();
  bool _obscure = true;
  @override Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Log In')), body: SingleChildScrollView(padding: const EdgeInsets.all(24), child: Form(key: _form, child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const Text('Welcome back', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
      const SizedBox(height: 24),
      CustomTextField(label: 'Email', hint: 'you@example.com', prefix: Icons.email_outlined, keyboard: TextInputType.emailAddress, validator: (v) => v != null && v.contains('@') ? null : 'Enter a valid email'),
      const SizedBox(height: 16),
      CustomTextField(label: 'Password', prefix: Icons.lock_outline, obscure: _obscure, suffix: IconButton(icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off), onPressed: () => setState(() => _obscure = !_obscure)), validator: (v) => (v?.length ?? 0) >= 6 ? null : 'Minimum 6 characters'),
      Align(alignment: Alignment.centerRight, child: TextButton(onPressed: () => context.push('/forgot-password'), child: const Text('Forgot password?'))),
      const SizedBox(height: 8),
      PrimaryButton(label: 'Log In', onPressed: () { if (_form.currentState!.validate()) context.go('/home'); }),
      const SizedBox(height: 20), const Row(children: [Expanded(child: Divider()), Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Text('or')), Expanded(child: Divider())]), const SizedBox(height: 20),
      const _SocialButtons(),
      const SizedBox(height: 16), TextButton(onPressed: () => context.push('/signup'), child: const Text("Don't have an account? Sign up")),
    ]))));
  }
}

class SignupScreen extends StatefulWidget { const SignupScreen({super.key}); @override State<SignupScreen> createState() => _SignupScreenState(); }
class _SignupScreenState extends State<SignupScreen> {
  final _form = GlobalKey<FormState>();
  @override Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Create Account')), body: SingleChildScrollView(padding: const EdgeInsets.all(24), child: Form(key: _form, child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      CustomTextField(label: 'Full Name', prefix: Icons.person_outline, validator: (v) => (v?.isNotEmpty ?? false) ? null : 'Required'),
      const SizedBox(height: 16),
      CustomTextField(label: 'Email', prefix: Icons.email_outlined, keyboard: TextInputType.emailAddress, validator: (v) => v != null && v.contains('@') ? null : 'Enter a valid email'),
      const SizedBox(height: 16),
      CustomTextField(label: 'Password', prefix: Icons.lock_outline, obscure: true, validator: (v) => (v?.length ?? 0) >= 6 ? null : 'Minimum 6 characters'),
      const SizedBox(height: 24),
      PrimaryButton(label: 'Create Account', onPressed: () { if (_form.currentState!.validate()) context.push('/otp'); }),
      const SizedBox(height: 20), const _SocialButtons(),
    ]))));
  }
}

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});
  @override Widget build(BuildContext context) {
    final form = GlobalKey<FormState>();
    return Scaffold(appBar: AppBar(title: const Text('Forgot Password')), body: Padding(padding: const EdgeInsets.all(24), child: Form(key: form, child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const Text('Enter your email and we\'ll send a verification code.', style: TextStyle(color: Colors.grey)),
      const SizedBox(height: 20),
      CustomTextField(label: 'Email', prefix: Icons.email_outlined, keyboard: TextInputType.emailAddress, validator: (v) => v != null && v.contains('@') ? null : 'Enter a valid email'),
      const SizedBox(height: 24),
      PrimaryButton(label: 'Send Code', onPressed: () { if (form.currentState!.validate()) context.push('/otp'); }),
    ]))));
  }
}

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});
  @override Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('Verify Code')), body: Padding(padding: const EdgeInsets.all(24), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const Text('Enter the 6-digit code sent to your email.', style: TextStyle(color: Colors.grey)),
      const SizedBox(height: 24),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: List.generate(6, (i) => SizedBox(width: 46, child: TextField(textAlign: TextAlign.center, keyboardType: TextInputType.number, maxLength: 1, decoration: InputDecoration(counterText: '', border: OutlineInputBorder(borderRadius: BorderRadius.circular(12))))))),
      const SizedBox(height: 24),
      PrimaryButton(label: 'Verify', onPressed: () => context.go('/home')),
      TextButton(onPressed: () {}, child: const Text('Resend code')),
    ])));
  }
}
