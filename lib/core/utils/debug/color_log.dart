/// Utility class per logging colorato nella console
/// 
/// Usa codici ANSI per colorare i messaggi di debug
/// Esempio di uso:
/// ```dart
/// ColorLog.error('Connessione fallita');
/// ColorLog.success('Login completato');
/// ColorLog.warning('Cache quasi piena');
/// ColorLog.info('Caricamento dati...');
/// ColorLog.debug('Valore variabile: $value');
/// ```
class ColorLog {
  // Codici colore ANSI
  static const String _reset = '\x1B[0m';
  static const String _red = '\x1B[31m';
  static const String _green = '\x1B[32m';
  static const String _yellow = '\x1B[33m';
  static const String _blue = '\x1B[34m';
  static const String _magenta = '\x1B[35m';
  static const String _cyan = '\x1B[36m';
  static const String _white = '\x1B[37m';
  
  // Stili aggiuntivi
  static const String _bold = '\x1B[1m';
  static const String _dim = '\x1B[2m';
  
  // Background colors
  static const String _bgRed = '\x1B[41m';
  static const String _bgGreen = '\x1B[42m';
  static const String _bgYellow = '\x1B[43m';

  /// Log di errore (rosso)
  static void error(String message) {
    print('${_red}ERROR: $message$_reset');
  }

  /// Log di successo (verde)
  static void success(String message) {
    print('${_green}SUCCESS: $message$_reset');
  }

  /// Log di warning (giallo)
  static void warning(String message) {
    print('${_yellow}WARNING: $message$_reset');
  }

  /// Log informativo (cyan)
  static void info(String message) {
    print('${_cyan}INFO: $message$_reset');
  }

  /// Log di debug (magenta)
  static void debug(String message) {
    print('${_magenta}DEBUG: $message$_reset');
  }

  /// Log di rete/API (blu)
  static void network(String message) {
    print('${_blue}NETWORK: $message$_reset');
  }

  /// Log critico con background rosso
  static void critical(String message) {
    print('$_bgRed$_white${_bold}CRITICAL: $message$_reset');
  }

  /// Log personalizzato con colore specifico
  static void custom(String message, {
    String color = _white,
    bool bold = false,
  }) {
    final style = bold ? '$color$_bold' : color;
    print('$style$message$_reset');
  }

  /// Stampa un separatore colorato
  static void separator({String color = _cyan}) {
    print("$color${'─' * 50}$_reset");
  }

  /// Stampa un header con background
  static void header(String title) {
    print('$_bgGreen$_white$_bold $title $_reset');
  }
}