import { defineConfig } from 'cypress';
import { configureAxe } from 'cypress-axe';

export default defineConfig({
  e2e: {
    baseUrl: 'http://localhost:5176',
    setupNodeEvents(on, config) {
      // Configure axe-core
      configureAxe(on, {
        // Axe configuration options
        rules: [
          // Enable all rules
          { id: '*', enabled: true },
          // Disable specific rules if needed
          // { id: 'color-contrast', enabled: false },
        ],
      });

      // Add other node events here
      on('task', {
        log(message) {
          console.log(message);
          return null;
        },
        table(message) {
          console.table(message);
          return null;
        },
      });
    },
    viewportWidth: 1280,
    viewportHeight: 720,
    video: false,
    screenshotOnRunFailure: true,
    defaultCommandTimeout: 10000,
    requestTimeout: 10000,
    responseTimeout: 10000,
    pageLoadTimeout: 30000,
    chromeWebSecurity: false,
  },

  component: {
    devServer: {
      framework: 'react',
      bundler: 'vite',
    },
    setupNodeEvents(on, config) {
      // Configure axe-core
      configureAxe(on, {
        // Axe configuration options
        rules: [
          // Enable all rules
          { id: '*', enabled: true },
          // Disable specific rules if needed
          // { id: 'color-contrast', enabled: false },
        ],
      });

      // Add other node events here
      on('task', {
        log(message) {
          console.log(message);
          return null;
        },
        table(message) {
          console.table(message);
          return null;
        },
      });
    },
    viewportWidth: 1280,
    viewportHeight: 720,
    video: false,
    screenshotOnRunFailure: true,
    defaultCommandTimeout: 10000,
    specPattern: 'src/**/*.cy.{js,jsx,ts,tsx}',
  },

  // Global configuration
  retries: {
    runMode: 2,
    openMode: 0,
  },

  env: {
    // Environment variables
    apiUrl: 'http://localhost:8000/api',
    coverage: false,
  },
});
