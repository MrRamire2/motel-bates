function googleTranslateElementInit() {
  new google.translate.TranslateElement({
      pageLanguage: 'en',
      includedLanguages: 'es,en',
      layout: google.translate.TranslateElement.InlineLayout.SIMPLE, // diseño del widget
      autoDisplay: false
  }, 'google_translate_element');
}