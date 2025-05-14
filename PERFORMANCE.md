# BetSightly Performance Optimizations

This document outlines the performance optimizations implemented in the BetSightly project to improve loading times, reduce bundle size, and enhance the overall user experience.

## Table of Contents

- [Bundle Optimization](#bundle-optimization)
- [Code Splitting](#code-splitting)
- [Lazy Loading](#lazy-loading)
- [Image Optimization](#image-optimization)
- [Caching Strategy](#caching-strategy)
- [Performance Analysis](#performance-analysis)
- [Future Optimizations](#future-optimizations)

## Bundle Optimization

We've implemented several techniques to reduce the bundle size and improve loading performance:

### Minification and Compression

- **Terser**: All JavaScript code is minified using Terser with aggressive settings
- **Gzip and Brotli**: Assets are compressed using both Gzip and Brotli algorithms
- **Tree Shaking**: Unused code is eliminated through tree shaking

### Chunk Splitting

The bundle is split into logical chunks to improve caching and reduce initial load time:

- `react-core`: Core React libraries (react, react-dom)
- `router`: React Router related code
- `ui`: UI components and styling libraries
- `utils`: Utility libraries
- `icons`: Icon components
- `vendor`: Other third-party dependencies
- `page-*`: One chunk per page

### Dependency Optimization

- Dependencies are analyzed for size and optimized
- Large dependencies are loaded asynchronously when possible
- Only necessary parts of libraries are imported

## Code Splitting

Code splitting is implemented at multiple levels:

### Route-Based Splitting

Each route is loaded separately using React's lazy loading:

```jsx
const HomePage = lazy(() => import('./pages/HomePage'));
const PredictionsPage = lazy(() => import('./pages/PredictionsPage'));
// ...other pages
```

This ensures that users only download the code they need for the current page.

### Component-Based Splitting

Large components are also split out and loaded on demand:

```jsx
const PredictionCard = lazy(() => import("../components/predictions/PredictionCard"));
const RolloverTracker = lazy(() => import("../components/results/RolloverTracker"));
const StatsOverview = lazy(() => import("../components/results/StatsOverview"));
```

### Dynamic Imports

Heavy functionality that isn't needed immediately is loaded dynamically:

```jsx
// Example: Load PDF generation only when needed
const generatePDF = async (data) => {
  const { jsPDF } = await import('jspdf');
  const { autoTable } = await import('jspdf-autotable');
  // Generate PDF...
};
```

## Lazy Loading

### Component Lazy Loading

Components are wrapped with Suspense and ErrorBoundary for graceful loading:

```jsx
<TrackedErrorBoundary>
  <Suspense fallback={<ComponentLoadingFallback />}>
    <PredictionCard prediction={prediction} />
  </Suspense>
</TrackedErrorBoundary>
```

### Loading Fallbacks

Custom loading fallbacks are implemented for a better user experience:

- `PageLoadingFallback`: Skeleton UI for page loading
- `ComponentLoadingFallback`: Simpler loading state for components

### Below-the-fold Content

Content that appears below the fold is loaded only when needed:

- Virtualized lists for long content
- Intersection Observer for triggering loads
- Pagination with on-demand loading

## Image Optimization

### Optimized Image Component

A custom `OptimizedImage` component handles:

- Responsive images with appropriate sizes
- Modern formats (WebP, AVIF) with fallbacks
- Lazy loading with blur-up effect
- Proper aspect ratio preservation

### Image Processing

Images are automatically optimized during the build process:

- Compression of JPG, PNG, and SVG
- Conversion to WebP and AVIF formats
- Creation of multiple sizes for responsive serving
- Generation of tiny placeholders for blur-up effect

### Image Loading Strategy

- Critical images are preloaded
- Non-critical images are lazy loaded
- Proper `srcset` and `sizes` attributes for responsive loading

## Caching Strategy

### Asset Caching

- Long-term caching for static assets with content hashing
- Separate chunks for better cache utilization
- Cache headers for optimal browser caching

### Data Caching

- API responses are cached with appropriate TTLs
- Local storage for persistent data
- Memory cache for frequently accessed data
- Cache invalidation strategy for data updates

## Performance Analysis

### Bundle Analysis

Run the bundle analyzer to identify optimization opportunities:

```bash
npm run analyze
```

This will:
1. Build the application with the analyzer plugin
2. Generate a visualization of the bundle
3. Provide recommendations for further optimization

### Performance Metrics

Key metrics we track:

- **Total Bundle Size**: Target < 200KB (gzipped)
- **First Contentful Paint (FCP)**: Target < 1.8s
- **Largest Contentful Paint (LCP)**: Target < 2.5s
- **Time to Interactive (TTI)**: Target < 3.5s
- **Cumulative Layout Shift (CLS)**: Target < 0.1

### Optimization Scripts

Several scripts are available for performance optimization:

- `npm run optimize-images`: Optimize all images in the project
- `npm run analyze-bundle`: Analyze the bundle size and get recommendations
- `npm run optimize`: Run all optimization scripts
- `npm run perf`: Run optimizations and build the project

## Future Optimizations

Planned optimizations for future releases:

1. **Service Worker**: Implement offline support and background updates
2. **Preloading**: Add intelligent preloading of likely next pages
3. **Font Optimization**: Implement font subsetting and display optimizations
4. **Resource Hints**: Add dns-prefetch, preconnect, and preload directives
5. **HTTP/2 Server Push**: Configure server push for critical resources
6. **Intersection Observer API**: Further optimize below-the-fold loading
7. **Web Workers**: Move heavy computations off the main thread

## Contributing

When contributing to the project, please follow these performance guidelines:

1. Run `npm run analyze` before and after your changes to ensure you're not negatively impacting performance
2. Use the `OptimizedImage` component for all images
3. Implement lazy loading for any large components
4. Be mindful of adding new dependencies
5. Write efficient code that minimizes reflows and repaints

## Resources

- [Web Vitals](https://web.dev/vitals/)
- [Lighthouse Performance Scoring](https://developers.google.com/web/tools/lighthouse/scoring)
- [React Performance Optimization](https://reactjs.org/docs/optimizing-performance.html)
- [Vite Build Optimization](https://vitejs.dev/guide/build.html)
- [Modern Image Optimization](https://web.dev/fast/#optimize-your-images)
