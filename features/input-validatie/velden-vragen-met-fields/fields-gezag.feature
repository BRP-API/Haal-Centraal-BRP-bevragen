# language: nl
@input-validatie
Functionaliteit: geldige fields waarden voor het vragen van het gezag veld

  Regel: het volledige en exacte pad (hoofdletter gevoelig) van een veld moet worden opgegeven als fields waarde om het betreffende veld te vragen

    Abstract Scenario: het gezag veld wordt gevraagd met fields waarde 'gezag'
      Als 'gezag' wordt gevraagd van personen gezocht met <zoek methode>
      Dan heeft de response geen foutmelding

      Voorbeelden:
        | zoek methode                       |
        | burgerservicenummer                |
        | adresseerbaar object identificatie |

    @fout-case
    Scenario: het gezag veld wordt gevraagd met fields waarde 'gezag' bij zoeken met '<zoek methode>'
      Als 'gezag' wordt gevraagd van personen gezocht met <zoek methode>
      Dan heeft de response een foutmelding
        | naam     | waarde                                                      |
        | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
        | title    | Een of meerdere parameters zijn niet correct.               |
        | status   |                                                         400 |
        | detail   | De foutieve parameter(s) zijn: fields[0].                   |
        | code     | paramsValidation                                            |
        | instance | /haalcentraal/api/brp/personen                              |
      En parameter foutmeldingen
        | code   | name      | reason                                       |
        | fields | fields[0] | Parameter bevat een niet bestaande veldnaam. |

      Voorbeelden:
        | zoek methode                                          |
        | geslachtsnaam en geboortedatum                        |
        | geslachtsnaam, voornamen en gemeente van inschrijving |
        | nummeraanduiding identificatie                        |
        | postcode en huisnummer                                |
        | straatnaam, huisnummer en gemeente van inschrijving   |

  Regel: het is niet toegestaan om specifieke sub-velden van het gezag veld te vragen

    @fout-case
    Abstract Scenario: het gezag veld wordt gevraagd met fields waarde '<fields>'
      Als '<fields>' wordt gevraagd van personen gezocht met <zoek methode>
      Dan heeft de response een foutmelding
        | naam     | waarde                                                      |
        | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
        | title    | Een of meerdere parameters zijn niet correct.               |
        | status   |                                                         400 |
        | detail   | De foutieve parameter(s) zijn: fields[0].                   |
        | code     | paramsValidation                                            |
        | instance | /haalcentraal/api/brp/personen                              |
      En parameter foutmeldingen
        | code   | name      | reason                                        |
        | fields | fields[0] | Parameter bevat een niet toegestane veldnaam. |

      Voorbeelden:
        | fields             | zoek methode                       |
        | gezag.type         | burgerservicenummer                |
        | gezag.minderjarige | adresseerbaar object identificatie |
        | gezag.ouders       | burgerservicenummer                |
        | gezag.ouder        | adresseerbaar object identificatie |
        | gezag.derde        | burgerservicenummer                |
        | gezag.derden       | adresseerbaar object identificatie |
        | gezag.toelichting  | burgerservicenummer                |
        | gezag.nietBestaand | adresseerbaar object identificatie |
