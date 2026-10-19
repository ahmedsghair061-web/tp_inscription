/// Toutes les règles de validation de l'application.
///
/// Un validateur reçoit la valeur saisie et renvoie `null` si elle est valide,
/// ou le message d'erreur à afficher sous le champ.
class Validators {
  Validators._();

  static final RegExp _lettres = RegExp(r"^[A-Za-zÀ-ÖØ-öø-ÿ' \-]+$");
  static final RegExp _email = RegExp(r'^[\w.+\-]+@([A-Za-z0-9\-]+\.)+[A-Za-z]{2,}$');
  static final RegExp _majuscule = RegExp(r'[A-Z]');
  static final RegExp _chiffre = RegExp(r'[0-9]');

  static String? _nomPropre(String? v, String libelle, {required bool masculin}) {
    final valeur = (v ?? '').trim();
    final article = masculin ? 'Le' : 'La';
    if (valeur.isEmpty) return '$article $libelle est obligatoire';
    if (valeur.length < 2) {
      return '$article $libelle doit contenir au moins 2 caractères';
    }
    if (!_lettres.hasMatch(valeur)) {
      return '$article $libelle ne doit contenir que des lettres';
    }
    return null;
  }

  static String? nom(String? v) => _nomPropre(v, 'nom', masculin: true);

  static String? prenom(String? v) => _nomPropre(v, 'prénom', masculin: true);

  static String? email(String? v) {
    final valeur = (v ?? '').trim();
    if (valeur.isEmpty) return "L'e-mail est obligatoire";
    if (!_email.hasMatch(valeur)) return 'Format attendu : nom@domaine.com';
    return null;
  }

  static String? motDePasse(String? v) {
    final valeur = v ?? '';
    if (valeur.isEmpty) return 'Le mot de passe est obligatoire';
    if (valeur.length < 8) return 'Au moins 8 caractères';
    if (!_majuscule.hasMatch(valeur)) return 'Au moins une lettre majuscule';
    if (!_chiffre.hasMatch(valeur)) return 'Au moins un chiffre';
    return null;
  }

  static String? confirmation(String? v, String motDePasse) {
    if ((v ?? '').isEmpty) return 'Veuillez confirmer le mot de passe';
    if (v != motDePasse) return 'Les mots de passe ne correspondent pas';
    return null;
  }

  static String? profession(String? v) {
    final valeur = (v ?? '').trim();
    if (valeur.isEmpty) return 'La profession est obligatoire';
    if (valeur.length < 2) {
      return 'La profession doit contenir au moins 2 caractères';
    }
    return null;
  }

  static String? experience(String? v) {
    final valeur = (v ?? '').trim();
    if (valeur.isEmpty) return "Les années d'expérience sont obligatoires";
    final n = int.tryParse(valeur);
    if (n == null) return 'Veuillez saisir un nombre entier';
    if (n < 0 || n > 50) return 'Valeur comprise entre 0 et 50';
    return null;
  }

  static String? tjm(String? v) {
    final valeur = (v ?? '').trim().replaceAll(',', '.');
    if (valeur.isEmpty) return 'Le TJM est obligatoire';
    final n = double.tryParse(valeur);
    if (n == null) return 'Veuillez saisir un nombre valide';
    if (n < 50 || n > 3000) {
      return 'Le TJM doit être compris entre 50 € et 3000 €';
    }
    return null;
  }

  static String? biographie(String? v) {
    final valeur = (v ?? '').trim();
    if (valeur.isEmpty) return null; // facultative
    if (valeur.length < 20) {
      return 'Au moins 20 caractères (${valeur.length}/20) ou laissez vide';
    }
    return null;
  }

  static String? conditions(bool? v) {
    if (v != true) return 'Vous devez accepter les conditions d’utilisation';
    return null;
  }
}
