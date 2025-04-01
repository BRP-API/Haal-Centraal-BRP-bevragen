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

  Abstract Scenario: de leeftijd van de minderjarige wordt geleverd
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

  @gezag-api
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
      | geboortedatum          |
      | vandaag - 10 jaar      |
      | gisteren - 15 jaar     |
      | morgen - 18 jaar       |
      | vorige maand - 12 jaar |
