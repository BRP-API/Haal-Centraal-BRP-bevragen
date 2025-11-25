module.exports = {
  default: {
    formatOptions: {
      snippetInterface: 'synchronous'
    }
  },
  dev: {
    worldParameters: {
      logger: {
        level: 'info'
      }
    }
  },
  UnitTest: {
    tags: 'not @skip-verify and not @integratie and not @gezag-api and not @data-api and not @info-api and not @deprecated'
  },
  Integratie: {
    tags: 'not @skip-verify and @integratie'
  },
  InfoApi: {
    worldParameters: {
      apiUrl: 'http://localhost:5002/haalcentraal/api',
      api: 'info-api',
      logger: {
        level: 'warn'
      },
      addAcceptGezagVersionHeader: true
    },
    tags: 'not @skip-verify and not @stap-documentatie and not @deprecated and ((not @gezag-api and not @data-api) or @info-api)'
  },
  InfoApiDeprecated: {
    worldParameters: {
      apiUrl: 'http://localhost:5002/haalcentraal/api',
      api: 'info-api',
      tagScenariosAsDeprecated: true,
      logger: {
        level: 'warn'
      },
      addAcceptGezagVersionHeader: false
    },
    tags: 'not @skip-verify and not @stap-documentatie and ((@deprecated and ((not @data-api and not @gezag-api) or @info-api)) or (not @deprecated and not @nieuw and ((not @data-api and not @gezag-api) or @info-api)))'
  },
  DataApi: {
    worldParameters: {
      apiUrl: 'http://localhost:8000/haalcentraal/api',
      api: 'data-api',
      logger: {
        level: 'warn'
      },
      addAcceptGezagVersionHeader: true
    },
    tags: 'not @skip-verify and not @deprecated and ((not @gezag-api and not @info-api) or @data-api)'
  },
  DataApiDeprecated: {
    worldParameters: {
      apiUrl: 'http://localhost:8000/haalcentraal/api',
      api: 'data-api',
      tagScenariosAsDeprecated: true,
      logger: {
        level: 'warn'
      },
      addAcceptGezagVersionHeader: false
    },
    tags: 'not @skip-verify and ((@deprecated and ((not @gezag-api and not @info-api) or @data-api)) or (not @deprecated and not @nieuw and ((not @gezag-api and not @info-api) or @data-api)))'
  },
  GezagApi: {
    worldParameters: {
      apiUrl: 'http://localhost:8080/api/v1/opvragenBevoegdheidTotGezag',
      api: 'gezag-api',
      logger: {
        level: 'warn'
      },
      addAcceptGezagVersionHeader: true
    },
    tags: 'not @skip-verify and not @deprecated and ((not @data-api and not @info-api) or @gezag-api)'
  },
  GezagApiDeprecated: {
    worldParameters: {
      apiUrl: 'http://localhost:8080/api/v1/opvragenBevoegdheidTotGezag',
      api: 'gezag-api',
      tagScenariosAsDeprecated: true,
      logger: {
        level: 'warn'
      },
      addAcceptGezagVersionHeader: false
    },
    tags: 'not @skip-verify and ((@deprecated and ((not @data-api and not @info-api) or @gezag-api)) or (not @deprecated and not @nieuw and ((not @data-api and not @info-api) or @gezag-api)))'
  },
  AenP: {
    worldParameters: {
      apiUrl: 'http://localhost:8080/haalcentraal/api',
      api: 'autorisatie-en-protocollering',
      logger: {
        level: 'warn'
      },
      oAuth: {
        enable: true
      },
      addAcceptGezagVersionHeader: false,
      logFileToAssert: './test-data/logs/brp-autorisatie-protocollering.json'
    },
    tags: 'not @skip-verify and not @stap-documentatie and not @deprecated and not @gezag-api and not @data-api'
  }
}
