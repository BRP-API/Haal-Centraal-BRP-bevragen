# language: nl
Functionaliteit: leveren van de leeftijd van de minderjarige van een gezagsrelatie

  Achtergrond:
    Gegeven de persoon 'Saskia' met burgerservicenummer '000000012'
    * is meerderjarig
    En de persoon 'Maarten' met burgerservicenummer '000000024'
    * is meerderjarig
    En 'Saskia' en 'Maarten' zijn met elkaar gehuwd met de volgende gegevens
      | datum huwelijkssluiting/aangaan geregistreerd partnerschap (06.10) |
      |                                                           20000401 |
    En de persoon 'Rachel' met burgerservicenummer '000000036'
    * heeft 'Saskia' als ouder 1
    * is in Nederland geboren
    * is ingeschreven in de BRP

  @info-api
  Regel: leeftijd van een minderjarige wordt niet geleverd bij een volledig onbekende geboortedatum, een geboortedatum waarvan alleen het jaar bekend is of een geboortedatum waarvan alleen de dag onbekend is en de geboortemaand is gelijk aan de huidige maand

    Abstract Scenario: de geboortedatum van de minderjarige is een volledig datum
      Gegeven de persoon 'Rachel' heeft de volgende gegevens
        | geboortedatum (03.10) |
        | <geboortedatum>       |
      Als 'gezag' wordt gevraagd van personen gezocht met burgerservicenummer van 'Rachel'
      Dan is het gezag over 'Rachel' gezamenlijk gezag met ouder 'Saskia' en derde 'Maarten'
      En heeft de minderjarige de volgende gegevens
        | leeftijd   |
        | <leeftijd> |

      Voorbeelden:
        | geboortedatum          | leeftijd |
        | vandaag - 10 jaar      |       10 |
        | gisteren - 15 jaar     |       15 |
        | morgen - 18 jaar       |       17 |
        | vorige maand - 12 jaar |       12 |

    Abstract Scenario: de geboortedag van de minderjarige is onbekend en de geboortemaand is niet de huidige maand
      Gegeven de persoon 'Rachel' heeft de volgende gegevens
        | geboortedatum (03.10) |
        | <geboortedatum>       |
      Als 'gezag' wordt gevraagd van personen gezocht met burgerservicenummer van 'Rachel'
      Dan is het gezag over 'Rachel' gezamenlijk gezag met ouder 'Saskia' en derde 'Maarten'
      En heeft de minderjarige de volgende gegevens
        | leeftijd   |
        | <leeftijd> |

      Voorbeelden:
        | geboortedatum            | leeftijd |
        | vorige maand - 12 jaar   |       12 |
        | volgende maand - 16 jaar |       15 |

    Scenario: de geboortedag van de minderjarige is onbekend en de geboortemaand is de huidige maand
      Gegeven de persoon 'Rachel' heeft de volgende gegevens
        | geboortedatum (03.10) |
        | deze maand - 10 jaar  |
      Als 'gezag' wordt gevraagd van personen gezocht met burgerservicenummer van 'Rachel'
      Dan is het gezag over 'Rachel' gezamenlijk gezag met ouder 'Saskia' en derde 'Maarten'
      En heeft de minderjarige geen leeftijd

  @gezag-api
  Regel: de geboortedatum van een minderjarige wordt altijd geleverd

    Abstract Scenario: de geboortedatum van de minderjarige wordt geleverd
      Gegeven de persoon 'Rachel' heeft de volgende gegevens
        | geboortedatum (03.10) |
        | <geboortedatum>       |
      Als 'gezag' wordt gevraagd van personen gezocht met burgerservicenummer van 'Rachel'
      Dan is het gezag over 'Rachel' gezamenlijk gezag met ouder 'Saskia' en derde 'Maarten'
      En heeft de minderjarige de volgende gegevens
        | geboorte.datum  |
        | <geboortedatum> |

      Voorbeelden:
        | geboortedatum            |
        | vandaag - 10 jaar        |
        | gisteren - 15 jaar       |
        | morgen - 18 jaar         |
        | vorige maand - 12 jaar   |
        | deze maand - 14 jaar     |
        | volgende maand - 16 jaar |
        | vorig jaar - 9 jaar      |
        | volgend jaar - 8 jaar    |
        |           5 jaar geleden |
