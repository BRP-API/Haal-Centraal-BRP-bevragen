# language: nl
Functionaliteit: zoek personen met geslachtsnaam, voornamen en gemeente van inschrijving
  Als consumer
  wil ik personen kunnen vinden door het opgeven van de gemeente waar ze zijn ingeschreven én hun geslachtsnaam en voornamen

  Achtergrond:
    Gegeven adres 'A1'
      | gemeentecode (92.10) |
      |                 0599 |

  Regel: personen worden gevonden als zij staan ingeschreven in de opgegeven gemeente én hun geslachtsnaam en voornamen komen exact overeen met de opgegeven geslachtsnaam en voornamen (niet hoofdlettergevoelig)

    Abstract Scenario: geslachtsnaam, voornamen en gemeente waar personen zijn ingeschreven komen exact overeen met de opgegeven geslachtsnaam, voornamen en gemeente van inschrijving parameters
      Gegeven de persoon 'Pieter'
      * heeft de volgende gegevens
        | geslachtsnaam (02.40) | voornamen (02.10) |
        | Maassen               | Pieter            |
      En 'Pieter' is 5 jaar geleden ingeschreven op adres 'A1'
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met geslachtsnaam '<geslachtsnaam>', voornamen '<voornamen>' en gemeente van inschrijving '0599'
      Dan wordt 'Pieter' gevonden

      Voorbeelden:
        | geslachtsnaam | voornamen |
        | Maassen       | Pieter    |
        | MAASSEN       | PIETER    |
        | MAASSEN       | pieter    |

    Scenario: de te vinden persoon heeft een geslachtsnaam van twee karakters lang
      Gegeven de persoon 'Miriam'
      * heeft de volgende gegevens
        | geslachtsnaam (02.40) | voornamen (02.10) |
        | Os                    | Miriam            |
      En 'Miriam' is 5 jaar geleden ingeschreven op adres 'A1'
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met geslachtsnaam 'Os', voornamen 'Miriam' en gemeente van inschrijving '0599'
      Dan wordt 'Miriam' gevonden

  Regel: de optionele 'voorvoegsel' parameter (niet hoofdlettergevoelig) kan worden gebruikt om de zoek criteria aan te scherpen

    Scenario: geslachtsnaam, voorvoegsel, voornamen en gemeente waar de personen zijn ingeschreven komen overeen met de opgegeven geslachtsnaam, voorvoegsel, voornamen en gemeente van inschrijving parameters
      Gegeven de persoon 'Pieter'
      * heeft de volgende gegevens
        | geslachtsnaam (02.40) | voorvoegsel (02.30) | voornamen (02.10) |
        | Maassen               | van                 | Pieter            |
      En 'Pieter' is 5 jaar geleden ingeschreven op adres 'A1'
      Als 'burgerservicenummer' wordt gevraagd van personen gezocht met geslachtsnaam 'Maassen', voornamen 'Pieter' en gemeente van inschrijving '0599' en parameters
        | voorvoegsel    |
        | <voorvoegsels> |
      Dan wordt 'Pieter' gevonden

      Voorbeelden:
        | voorvoegsels |
        | van          |
        | Van          |
        | VAN          |
