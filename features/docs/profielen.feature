#language: nl
Functionaliteit: profielen

  Regel: bestaande scenarios die niet zijn gewijzigd

    Scenario: scenario die voor alle profielen moet worden uitgevoerd

    @info-api
    Scenario: scenario die voor InfoApi en InfoApiDeprecated profielen moet worden uitgevoerd

    @data-api
    Scenario: scenario die voor DataApi en DataApiDeprecated profielen moet worden uitgevoerd

    @gezag-api
    Scenario: scenario die voor GezagApi en GezagApiDeprecated profielen moet worden uitgevoerd

    @skip-verify
    Scenario: scenario die voor geen enkel profiel moet worden uitgevoerd

  @nieuw
  Regel: nieuwe scenarios

    Scenario: nieuwe scenario die voor InfoApi, DataApi en GezagApi profielen moet worden uitgevoerd

    @info-api
    Scenario: nieuwe scenario die voor InfoApi profiel moet worden uitgevoerd

    @data-api
    Scenario: nieuwe scenario die voor DataApi profiel moet worden uitgevoerd

    @gezag-api
    Scenario: nieuwe scenario die voor GezagApi profiel moet worden uitgevoerd

  @deprecated
  Regel: deprecated scenarios

    Scenario: deprecated scenario die voor InfoApiDeprecated, DataApiDeprecated en GezagApiDeprecated profielen moet worden uitgevoerd

    @info-api
    Scenario: deprecated scenario die voor InfoApiDeprecated profiel moet worden uitgevoerd

    @data-api
    Scenario: deprecated scenario die voor DataApiDeprecated profiel moet worden uitgevoerd

    @gezag-api
    Scenario: deprecated scenario die voor GezagApiDeprecated profiel moet worden uitgevoerd
