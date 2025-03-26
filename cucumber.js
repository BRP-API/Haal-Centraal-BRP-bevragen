module.exports = {
  default: {
    formatOptions: {
      snippetInterface: 'synchronous'
    }
  },
  dev: {
    formatOptions: {
      snippetInterface: 'synchronous'
    },
    worldParameters: {
      logger: {
        level: 'info'
      },
      addAcceptGezagVersionHeader: true
    }
  },
  testOud: {
    formatOptions: {
      snippetInterface: 'synchronous'
    },
    worldParameters: {
      logger: {
        level: 'warn'
      },
      addAcceptGezagVersionHeader: false
    },
    tags: 'not @2.7.0'
  },
  testNieuw: {
    formatOptions: {
      snippetInterface: 'synchronous'
    },
    worldParameters: {
      logger: {
        level: 'warn'
      },
      addAcceptGezagVersionHeader: true
    },
    tags: 'not @deprecated'
  }
}
