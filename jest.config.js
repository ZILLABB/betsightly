export default {
  preset: "ts-jest/presets/js-with-ts-esm",
  testEnvironment: "jsdom",
  moduleNameMapper: {
    // Handle CSS imports (with CSS modules)
    "\\.css$": "identity-obj-proxy",
    // Handle image imports
    "\\.(jpg|jpeg|png|gif|webp|svg)$": "<rootDir>/src/__mocks__/fileMock.js",
    // Handle decimal.js import issues
    "^decimal.js$": "<rootDir>/src/__mocks__/decimal.js",
  },
  transform: {
    "^.+\\.(ts|tsx)$": [
      "ts-jest",
      {
        useESM: true,
        tsconfig: "tsconfig.test.json",
      },
    ],
    "^.+\\.(js|jsx)$": ["babel-jest"],
  },
  extensionsToTreatAsEsm: [".ts", ".tsx"],
  setupFilesAfterEnv: ["<rootDir>/src/setupTests.js"],
  testPathIgnorePatterns: ["/node_modules/", "/cypress/"],
  moduleFileExtensions: ["ts", "tsx", "js", "jsx", "json", "node"],
  collectCoverage: false,
  collectCoverageFrom: [
    "src/**/*.{js,jsx,ts,tsx}",
    "!src/**/*.d.ts",
    "!src/__mocks__/**",
    "!src/main.tsx",
  ],
  // Temporarily disable coverage thresholds
  // coverageThreshold: {
  //   global: {
  //     branches: 70,
  //     functions: 70,
  //     lines: 70,
  //     statements: 70,
  //   },
  // },
  // Improve module resolution
  moduleDirectories: ["node_modules", "<rootDir>"],
  // Transform ignore patterns to handle ESM modules
  transformIgnorePatterns: [
    "/node_modules/(?!(decimal\\.js|@tailwindcss|tailwindcss)/)",
  ],
};
