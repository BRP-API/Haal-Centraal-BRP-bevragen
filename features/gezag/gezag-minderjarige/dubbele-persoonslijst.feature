# language: nl
Functionaliteit: Leveren gezag wanneer er een persoonslijst wordt gevonden met opschorting reden F (Fout) of W (Wissen)

  Regel: Wanneer de gevraagde persoonslijst opschorting F (Fout) of W (Wissen) heeft, wordt geen gezag geleverd

  Abstract Scenario: Er is een persoonslijst met opschorting <opschorting reden>
    Gegeven de persoon 'Gerda' met burgerservicenummer '000000012'
    * is meerderjarig
    En de persoon 'Aart' met burgerservicenummer '000000024'
    * is meerderjarig
    En 'Gerda' en 'Aart' zijn met elkaar gehuwd
    En de persoon 'Hakim' met burgerservicenummer '000000036'
    * is meerderjarig
    En de persoon 'Bert' met burgerservicenummer '000000048'
    * is minderjarig
    * is ingeschreven in de BRP
    * is in Nederland geboren
    * heeft 'Hakim' als ouder 1
    En de persoonslijst van 'Bert' is opgeschort met reden '<opschorting reden>'
    Als 'gezag' wordt gevraagd van 'Bert'
    Dan heeft 'Bert' geen gezaghouder

    Voorbeelden:
      | opschorting reden | omschrijving |
      | F                 | Fout         |
      | W                 | Wissen       |

  Regel: Een persoonslijst met opschorting F (Fout) of W (Wissen) wordt genegeerd wanneer er ook een andere persoonslijst is met hetzelfde burgerservicenummer

  Abstract Scenario: Er is een persoonslijst met opschorting <opschorting reden> en een andere persoonslijst met zelfde bsn en zonder opschorting bijhouding
    Gegeven de persoon 'Gerda' met burgerservicenummer '000000012'
    * is meerderjarig
    En de persoon 'Aart' met burgerservicenummer '000000024'
    * is meerderjarig
    En 'Gerda' en 'Aart' zijn met elkaar gehuwd
    En de persoon 'Hakim' met burgerservicenummer '000000036'
    * is meerderjarig
    En de persoon 'Bert' met burgerservicenummer '000000048'
    * is minderjarig
    * is ingeschreven in de BRP
    * is in Nederland geboren
    * heeft 'Hakim' als ouder 1
    En de persoonslijst van 'Bert' is opgeschort met reden '<opschorting reden>'
    En de persoon 'Ernie' met burgerservicenummer '000000048'
    * is minderjarig
    * is ingeschreven in de BRP
    * is in Nederland geboren
    * heeft 'Gerda' als ouder 1
    * heeft 'Aart' als ouder 2
    Als 'gezag' wordt gevraagd van 'Ernie'
    Dan is het gezag over 'Ernie' gezamenlijk ouderlijk gezag met ouder 'Gerda' en ouder 'Aart'

    Voorbeelden:
      | opschorting reden | omschrijving |
      | F                 | Fout         |
      | W                 | Wissen       |
