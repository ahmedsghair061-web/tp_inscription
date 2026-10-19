import 'package:flutter/material.dart';

import '../models/user_profile.dart';
import '../utils/validators.dart';
import 'step_one_screen.dart';

/// Maquette 03 – Récapitulatif et validation finale.
class SummaryScreen extends StatefulWidget {
  final UserProfile profil;

  const SummaryScreen({super.key, required this.profil});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  final _formKey = GlobalKey<FormState>();

  void _retourEtape1() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const StepOneScreen()),
      (route) => false,
    );
  }

  Future<void> _reinitialiser() async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Tout effacer ?'),
        content: const Text(
          'Les informations saisies seront perdues et vous reviendrez '
          'à la première étape.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Annuler'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size(0, 40)),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Effacer'),
          ),
        ],
      ),
    );
    if (ok == true && mounted) _retourEtape1();
  }

  Future<void> _confirmer() async {
    if (!_formKey.currentState!.validate()) return;
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        icon: Icon(
          Icons.check_circle,
          color: Theme.of(ctx).colorScheme.primary,
          size: 56,
        ),
        title: const Text('Compte créé'),
        content: Text(
          'Bienvenue ${widget.profil.prenom} ! '
          'Votre compte a été créé avec succès.',
          textAlign: TextAlign.center,
        ),
        actions: [
          FilledButton(
            style: FilledButton.styleFrom(minimumSize: const Size(120, 44)),
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Terminer'),
          ),
        ],
      ),
    );
    if (mounted) _retourEtape1();
  }

  @override
  Widget build(BuildContext context) {
    final p = widget.profil;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Récapitulatif de votre profil'),
        actions: [
          IconButton(
            tooltip: 'Réinitialiser',
            icon: const Icon(Icons.restart_alt),
            onPressed: _reinitialiser,
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(4),
          child: LinearProgressIndicator(value: 1, minHeight: 4),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _SectionCard(
              titre: 'Identité',
              lignes: [
                _Ligne(Icons.person_outline, 'Nom', p.nom),
                _Ligne(Icons.person_outline, 'Prénom', p.prenom),
                _Ligne(Icons.email_outlined, 'E-mail', p.email),
                _Ligne(
                  Icons.lock_outline,
                  'Mot de passe',
                  '•' * p.motDePasse.length,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _SectionCard(
              titre: 'Profil professionnel',
              lignes: [
                _Ligne(Icons.work_outline, 'Profession', p.profession),
                _Ligne(
                  Icons.timeline,
                  'Expérience',
                  '${p.experience ?? 0} an(s)',
                ),
                _Ligne(
                  Icons.payments_outlined,
                  'TJM',
                  '${(p.tjm ?? 0).toStringAsFixed(2)} €',
                ),
                _Ligne(
                  Icons.notes,
                  'Biographie',
                  p.biographie.isEmpty ? 'Non renseignée' : p.biographie,
                ),
              ],
            ),
            const SizedBox(height: 16),
            FormField<bool>(
              initialValue: false,
              validator: Validators.conditions,
              builder: (state) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CheckboxListTile(
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    title: const Text('J’accepte les conditions'),
                    value: state.value ?? false,
                    onChanged: (v) => state.didChange(v),
                  ),
                  if (state.hasError)
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        state.errorText!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: _confirmer,
              child: const Text('Confirmer et créer le compte'),
            ),
          ],
        ),
      ),
    );
  }
}

class _Ligne {
  final IconData icone;
  final String libelle;
  final String valeur;
  const _Ligne(this.icone, this.libelle, this.valeur);
}

class _SectionCard extends StatelessWidget {
  final String titre;
  final List<_Ligne> lignes;

  const _SectionCard({required this.titre, required this.lignes});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: const Color(0xFFF2F7F9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Text(
                titre,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            for (final l in lignes)
              ListTile(
                dense: true,
                leading: Icon(l.icone),
                title: Text(l.libelle),
                subtitle: Text(l.valeur),
              ),
          ],
        ),
      ),
    );
  }
}
