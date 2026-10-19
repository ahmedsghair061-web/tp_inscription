import 'package:flutter_test/flutter_test.dart';
import '../lib/utils/validators.dart';

void main() {
  group('Nom / Prénom', () {
    test('trop court', () {
      expect(Validators.nom('A'), 'Le nom doit contenir au moins 2 caractères');
    });
    test('caractères interdits', () {
      expect(Validators.nom('Ben 3li'), 'Le nom ne doit contenir que des lettres');
    });
    test('espaces seuls = vide', () {
      expect(Validators.prenom('   '), 'Le prénom est obligatoire');
    });
    test('accents, tiret, apostrophe', () {
      expect(Validators.nom("Jean-Éloi d'Ar"), isNull);
    });
  });

  group('E-mail', () {
    test('vide', () => expect(Validators.email(''), isNotNull));
    test('sans extension', () {
      expect(Validators.email('ali@gmail'), 'Format attendu : nom@domaine.com');
    });
    test('valide', () => expect(Validators.email('ali@gmail.com'), isNull));
  });

  group('Mot de passe', () {
    test('trop court', () => expect(Validators.motDePasse('Ab1'), 'Au moins 8 caractères'));
    test('sans majuscule', () {
      expect(Validators.motDePasse('bonjour12'), 'Au moins une lettre majuscule');
    });
    test('sans chiffre', () {
      expect(Validators.motDePasse('Bonjourtous'), 'Au moins un chiffre');
    });
    test('valide', () => expect(Validators.motDePasse('Bonjour12'), isNull));
  });

  group('Confirmation', () {
    test('différente', () {
      expect(Validators.confirmation('x', 'Bonjour12'),
          'Les mots de passe ne correspondent pas');
    });
    test('identique', () => expect(Validators.confirmation('Bonjour12', 'Bonjour12'), isNull));
  });

  group('Expérience', () {
    test('hors bornes', () {
      expect(Validators.experience('75'), 'Valeur comprise entre 0 et 50');
    });
    test('valide', () => expect(Validators.experience('10'), isNull));
  });

  group('TJM', () {
    test('trop bas', () {
      expect(Validators.tjm('25'), 'Le TJM doit être compris entre 50 € et 3000 €');
    });
    test('virgule acceptée', () => expect(Validators.tjm('350,50'), isNull));
    test('non numérique', () => expect(Validators.tjm('abc'), isNotNull));
  });

  group('Biographie', () {
    test('vide valide', () => expect(Validators.biographie(''), isNull));
    test('trop courte', () {
      expect(Validators.biographie('Je code.'),
          'Au moins 20 caractères (8/20) ou laissez vide');
    });
    test('assez longue', () {
      expect(Validators.biographie('Développeur mobile passionné par Flutter.'), isNull);
    });
  });

  group('Conditions', () {
    test('non cochée', () {
      expect(Validators.conditions(false),
          'Vous devez accepter les conditions d’utilisation');
    });
    test('cochée', () => expect(Validators.conditions(true), isNull));
  });
}
