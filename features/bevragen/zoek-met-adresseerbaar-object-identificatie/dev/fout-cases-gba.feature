#language: nl

@gba
Functionaliteit: Zoek met adresseerbaar object identificatie - fout cases

  Regel: adresseerbaarObjectIdentificatie is een verplichte parameter

    @fout-case
    Scenario: De adresseerbaarObjectIdentificatie parameter is niet opgegeven
      Als gba personen wordt gezocht met de volgende parameters
      | naam   | waarde                                  |
      | type   | ZoekMetAdresseerbaarObjectIdentificatie |
      | fields | burgerservicenummer                     |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                           |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1      |
      | title    | Een of meerdere parameters zijn niet correct.                    |
      | status   | 400                                                              |
      | detail   | De foutieve parameter(s) zijn: adresseerbaarObjectIdentificatie. |
      | code     | paramsValidation                                                 |
      | instance | /haalcentraal/api/brp/personen                                   |
      En heeft het object de volgende 'invalidParams' gegevens
      | code     | name                             | reason                  |
      | required | adresseerbaarObjectIdentificatie | Parameter is verplicht. |

    @fout-case
    Scenario: Een lege string is opgegeven als adresseerbaar object identificatie waarde
      Als gba personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie |                                         |
      | fields                           | burgerservicenummer                     |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                           |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1      |
      | title    | Een of meerdere parameters zijn niet correct.                    |
      | status   | 400                                                              |
      | detail   | De foutieve parameter(s) zijn: adresseerbaarObjectIdentificatie. |
      | code     | paramsValidation                                                 |
      | instance | /haalcentraal/api/brp/personen                                   |
      En heeft het object de volgende 'invalidParams' gegevens
      | code     | name                             | reason                  |
      | required | adresseerbaarObjectIdentificatie | Parameter is verplicht. |

  Regel: Een adresseerbaarObjectIdentificatie is een string bestaande uit exact 16 cijfers

    @fout-case
    Abstract Scenario: <titel>
      Als gba personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | <adresseerbaarObjectIdentificatie>      |
      | fields                           | burgerservicenummer                     |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                           |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1      |
      | title    | Een of meerdere parameters zijn niet correct.                    |
      | status   | 400                                                              |
      | detail   | De foutieve parameter(s) zijn: adresseerbaarObjectIdentificatie. |
      | code     | paramsValidation                                                 |
      | instance | /haalcentraal/api/brp/personen                                   |
      En heeft het object de volgende 'invalidParams' gegevens
      | code    | name                             | reason                                       |
      | pattern | adresseerbaarObjectIdentificatie | Waarde voldoet niet aan patroon ^[0-9]{16}$. |

      Voorbeelden:
      | adresseerbaarObjectIdentificatie  | titel                                                                                 |
      | 123456789012345                   | De opgegeven adresseerbaarObjectIdentificatie is een string met minder dan 16 cijfers |
      | 12345678901234567                 | De opgegeven adresseerbaarObjectIdentificatie is een string met meer dan 16 cijfers   |
      | <script>1234567890123456</script> | De opgegeven adresseerbaarObjectIdentificatie bevat niet-cijfer karakters             |

  Regel: Alleen gespecificeerde parameters bij het opgegeven zoektype mogen worden gebruikt

    @fout-case
    Abstract Scenario: <titel>
      Als gba personen wordt gezocht met de volgende parameters
      | naam                             | waarde                                  |
      | type                             | ZoekMetAdresseerbaarObjectIdentificatie |
      | adresseerbaarObjectIdentificatie | 0599200051001501                        |
      | <parameter>                      | <waarde>                                |
      | fields                           | burgerservicenummer                     |
      Dan heeft de response een object met de volgende gegevens
      | naam     | waarde                                                      |
      | type     | https://datatracker.ietf.org/doc/html/rfc7231#section-6.5.1 |
      | title    | Een of meerdere parameters zijn niet correct.               |
      | status   | 400                                                         |
      | detail   | De foutieve parameter(s) zijn: <parameter>.                 |
      | code     | paramsValidation                                            |
      | instance | /haalcentraal/api/brp/personen                              |
      En heeft het object de volgende 'invalidParams' gegevens
      | code         | name        | reason                      |
      | unknownParam | <parameter> | Parameter is niet verwacht. |

      Voorbeelden:
      | titel                                                                                | parameter                  | waarde     |
      | zoeken met parameter uit ander zoektype                                              | voornamen                  | Pietje     |
      | typfout in naam optionele parameter                                                  | gemeenteVanInschijving     | 0363       |
      | zoeken met niet gespecificeerde parameter                                            | bestaatNiet                | een waarde |
