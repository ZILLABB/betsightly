# BetSightly Progressive Web App (PWA)

This document outlines the Progressive Web App (PWA) features implemented in the BetSightly project, providing offline capabilities, improved performance, and a more app-like experience.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Implementation Details](#implementation-details)
- [Testing PWA Features](#testing-pwa-features)
- [Deployment Considerations](#deployment-considerations)
- [Future Enhancements](#future-enhancements)

## Overview

BetSightly is now a Progressive Web App (PWA), which means it can be installed on users' devices and used offline. This provides several benefits:

- **Offline Access**: Users can access predictions and data even without an internet connection
- **Faster Load Times**: Assets are cached for quicker subsequent visits
- **App-like Experience**: Can be installed on home screens and launched like native apps
- **Background Updates**: Service worker updates the app in the background
- **Push Notifications**: (Future enhancement) Can send notifications to users

## Features

### Offline Support

- **Service Worker**: Caches assets and API responses for offline use
- **Offline-First Data Fetching**: Tries network first, falls back to cache
- **Offline UI Indicators**: Shows when the app is working offline
- **Stale Data Indicators**: Indicates when data might be outdated

### Installation

- **Web App Manifest**: Allows the app to be installed on devices
- **Install Prompt**: (Future enhancement) Custom prompt to encourage installation
- **App Icons**: Full set of icons for various platforms and sizes

### Performance

- **Precaching**: Critical assets are cached during service worker installation
- **Runtime Caching**: Dynamic content is cached as it's accessed
- **Cache Strategies**: Different strategies for different types of content:
  - **Cache First**: For static assets like images and fonts
  - **Stale While Revalidate**: For API responses and dynamic content
  - **Network First**: For critical up-to-date data

### User Experience

- **Update Notifications**: Notifies users when a new version is available
- **Offline Notifications**: Informs users when they're working offline
- **Seamless Updates**: Updates happen in the background

## Implementation Details

### Service Worker

We use Workbox (via vite-plugin-pwa) to generate and manage our service worker. The service worker is configured in `vite.config.ts`:

```typescript
VitePWA({
  registerType: 'autoUpdate',
  includeAssets: ['favicon.ico', 'apple-touch-icon.png', 'masked-icon.svg'],
  manifest: {
    name: 'BetSightly',
    short_name: 'BetSightly',
    description: 'Smart betting predictions and analysis',
    theme_color: '#1A1A27',
    background_color: '#1A1A27',
    display: 'standalone',
    icons: [
      // Icons configuration...
    ],
  },
  workbox: {
    // Cache strategies configuration...
  },
})
```

### PWA Provider

We've created a `PWAProvider` component that manages:

- Service worker registration and updates
- Online/offline status detection
- Update and offline notifications

```tsx
<PWAProvider>
  <App />
</PWAProvider>
```

### Offline-First Data Fetching

The `useOfflineData` hook provides offline-first data fetching:

```typescript
const {
  data,
  isLoading,
  error,
  isStale,
  refresh,
  lastUpdated
} = useOfflineData({
  cacheKey: 'my-data',
  fetchFn: async () => {
    // Fetch data from API
    return await fetchDataFromApi();
  },
  initialData: [],
  cacheTTL: 3600, // 1 hour
});
```

### UI Components

- **PWAUpdateNotification**: Notifies users when updates are available
- **OfflineNotification**: Shows when the app is offline or ready for offline use
- **OfflineStatusBar**: Displays online status and data freshness

## Testing PWA Features

To test the PWA features:

1. **Build the PWA**:
   ```bash
   npm run build:pwa
   ```

2. **Serve the build**:
   ```bash
   npm run preview
   ```

3. **Test offline functionality**:
   - Open Chrome DevTools
   - Go to Application > Service Workers
   - Check "Offline" checkbox
   - Refresh the page and verify it still works

4. **Test installation**:
   - In Chrome, you should see an install icon in the address bar
   - Click it to install the app
   - Verify the app launches as a standalone window

5. **Test update flow**:
   - Make a change to the app
   - Rebuild with `npm run build:pwa`
   - Refresh the page
   - Verify you see the update notification

## Deployment Considerations

When deploying the PWA, consider the following:

1. **HTTPS**: PWAs require HTTPS to work properly
2. **Cache Headers**: Set appropriate cache headers for static assets
3. **Service Worker Scope**: Ensure the service worker is served from the correct scope
4. **Cross-Origin Resources**: Make sure cross-origin resources are properly configured for caching

## Future Enhancements

1. **Push Notifications**: Implement push notifications for new predictions
2. **Background Sync**: Add background sync for submitting data when offline
3. **Periodic Sync**: Periodically update data in the background
4. **Custom Install Prompt**: Create a more engaging install prompt
5. **Offline Game Data**: Cache more game data for comprehensive offline experience
6. **Improved Offline UI**: Enhance the offline experience with more offline-specific features
7. **Analytics**: Track PWA usage and installation rates

## Resources

- [Workbox Documentation](https://developers.google.com/web/tools/workbox)
- [Vite PWA Plugin](https://vite-pwa-org.netlify.app/)
- [Web App Manifest](https://developer.mozilla.org/en-US/docs/Web/Manifest)
- [Service Worker API](https://developer.mozilla.org/en-US/docs/Web/API/Service_Worker_API)
- [PWA Checklist](https://web.dev/pwa-checklist/)
