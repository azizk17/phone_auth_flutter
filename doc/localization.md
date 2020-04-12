## Localization

### Resources:

- https://flutter.dev/docs/development/accessibility-and-localization/internationalization

### Commands

#### note: if you are on Windows, these commands might not work properly on powerShell. use Git Bash instead.

```
 flutter pub run intl_translation:extract_to_arb --output-dir=lib/src/i18n lib/src/locale.dart
```

```
 flutter pub run intl_translation:generate_from_arb --output-dir=lib/src/i18n --no-use-deferred-loading lib/src/locale.dart lib/src/i18n/intl_*.arb

```
