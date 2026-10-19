import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/user_profile.dart';
import '../utils/validators.dart';
import 'summary_screen.dart';

/// Maquette 02 – Profil professionnel.
class StepTwoScreen extends StatefulWidget {
  final UserProfile profil;

  const StepTwoScreen({super.key, required this.profil});

  @override
  State<StepTwoScreen> createState() => _StepTwoScreenState();
}

class _StepTwoScreenState extends State<StepTwoScreen> {
  final _formKey = GlobalKey<FormState>();

  final _professionCtrl = TextEditingController();
  final _experienceCtrl = TextEditingController();
  final _tjmCtrl = TextEditingController();
  final _bioCtrl = TextEditingController();

  @override
  void dispose() {
    _professionCtrl.dispose();
    _experienceCtrl.dispose();
    _tjmCtrl.dispose();
    _bioCtrl.dispose();
    super.dispose();
  }

  void _suivant() {
    if (!_formKey.currentState!.validate()) return;
    final profil = widget.profil.copyWith(
      profession: _professionCtrl.text.trim(),
      experience: int.parse(_experienceCtrl.text.trim()),
      tjm: double.parse(_tjmCtrl.text.trim().replaceAll(',', '.')),
      biographie: _bioCtrl.text.trim(),
    );
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => SummaryScreen(profil: profil)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Profil Professionnel – Étape 2/3'),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(4),
          child: LinearProgressIndicator(value: 2 / 3, minHeight: 4),
        ),
      ),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _professionCtrl,
              textInputAction: TextInputAction.next,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(
                labelText: 'Profession',
                prefixIcon: Icon(Icons.work_outline),
              ),
              validator: Validators.profession,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _experienceCtrl,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(2),
              ],
              decoration: const InputDecoration(
                labelText: "Années d'expérience",
                prefixIcon: Icon(Icons.timeline),
              ),
              validator: Validators.experience,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _tjmCtrl,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              textInputAction: TextInputAction.next,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
              ],
              decoration: const InputDecoration(
                labelText: 'TJM (taux journalier moyen)',
                prefixIcon: Icon(Icons.payments_outlined),
                suffixText: '€',
              ),
              validator: Validators.tjm,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _bioCtrl,
              maxLength: 300,
              maxLines: 5,
              minLines: 4,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                labelText: 'Biographie (facultative)',
                alignLabelWithHint: true,
              ),
              validator: Validators.biographie,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _suivant,
              child: const Text('Suivant'),
            ),
          ],
        ),
      ),
    );
  }
}
