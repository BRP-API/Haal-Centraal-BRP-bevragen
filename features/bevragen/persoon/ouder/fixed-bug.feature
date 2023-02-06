# language: nl

Functionaliteit: Persoon: ouder

  Scenario: persoon heeft een ouder '1' met voornamen in onderzoek en een ouder '2'
    Gegeven de persoon met burgerservicenummer '000000012' heeft een ouder '1' met de volgende gegevens
    | naam                            | waarde   |
    | voornamen (02.10)               | Renée    |
    | aanduiding in onderzoek (83.10) | 020210   |
    | datum ingang onderzoek (83.20)  | 20220307 |
    En de persoon heeft een ouder '2' met de volgende gegevens
    | naam              | waarde |
    | voornamen (02.10) | Willy  |
    Als personen wordt gezocht met de volgende parameters
    | naam                | waarde                                         |
    | type                | RaadpleegMetBurgerservicenummer                |
    | burgerservicenummer | 000000012                                      |
    | fields              | ouders.ouderAanduiding,ouders.naam.voorletters |
    Dan heeft de response een persoon met een 'ouder' met alleen de volgende gegevens
    | naam            | waarde |
    | ouderAanduiding | 1      |
    En heeft de 'ouder' de volgende 'naam' gegevens
    | naam                                         | waarde       |
    | voorletters                                  | R.           |
    | inOnderzoek.voorletters                      | true         |
    | inOnderzoek.datumIngangOnderzoek.type        | Datum        |
    | inOnderzoek.datumIngangOnderzoek.datum       | 2022-03-07   |
    | inOnderzoek.datumIngangOnderzoek.langFormaat | 7 maart 2022 |
    En heeft de persoon een 'ouder' met de volgende gegevens
    | naam             | waarde |
    | ouderAanduiding  | 2      |
    | naam.voorletters | W.     |
