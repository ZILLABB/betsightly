# Web Vitals Optimization Guide

This document outlines the Web Vitals optimizations implemented in the BetSightly project to improve performance, user experience, and SEO.

## Table of Contents

- [Core Web Vitals Overview](#core-web-vitals-overview)
- [Implemented Optimizations](#implemented-optimizations)
- [Measuring Web Vitals](#measuring-web-vitals)
- [Component Usage Guide](#component-usage-guide)
- [Best Practices](#best-practices)
- [Future Optimizations](#future-optimizations)

## Core Web Vitals Overview

Core Web Vitals are a set of specific factors that Google considers important for user experience:

### Largest Contentful Paint (LCP)

**What it measures**: Loading performance - how quickly the largest content element becomes visible.

**Target**: < 2.5 seconds

**Factors affecting LCP**:
- Server response time
- Resource load time
- Render-blocking JavaScript and CSS
- Client-side rendering
- Resource size

### First Input Delay (FID)

**What it measures**: Interactivity - how quickly the page responds to user interactions.

**Target**: < 100 milliseconds

**Factors affecting FID**:
- Long JavaScript tasks
- Large JavaScript bundles
- Third-party scripts
- Browser main thread contention

### Cumulative Layout Shift (CLS)

**What it measures**: Visual stability - how much the page layout shifts unexpectedly.

**Target**: < 0.1

**Factors affecting CLS**:
- Images without dimensions
- Ads, embeds, and iframes without dimensions
- Dynamically injected content
- Web fonts causing FOIT/FOUT
- Actions waiting for network responses

## Implemented Optimizations

### LCP Optimizations

1. **Image Optimization**
   - `OptimizedImage` component with proper dimensions
   - Preloading of critical images
   - Modern image formats (WebP, AVIF)
   - Responsive images with srcset

2. **Resource Prioritization**
   - `ResourceHints` component for preconnect and dns-prefetch
   - Preloading critical resources
   - Setting proper fetchPriority

3. **Code Splitting**
   - Route-based code splitting
   - Component-level code splitting
   - Optimized chunk configuration

### FID Optimizations

1. **JavaScript Optimization**
   - Deferred non-critical JavaScript
   - Reduced JavaScript bundle size
   - Optimized third-party scripts

2. **Main Thread Optimization**
   - Reduced long tasks
   - Optimized event handlers
   - Debounced expensive operations

### CLS Optimizations

1. **Layout Stability**
   - `StableLayout` component to prevent shifts
   - Pre-allocated space for dynamic content
   - Aspect ratio preservation for media

2. **Font Optimization**
   - `OptimizedFonts` component
   - Font display: swap
   - Font preloading
   - Font fallbacks with size-adjust

3. **Content Reservation**
   - Skeleton screens for loading states
   - Fixed dimensions for dynamic elements
   - Proper placeholders

## Measuring Web Vitals

We've implemented a comprehensive Web Vitals measurement system:

1. **Real-time Monitoring**
   - `webVitals.ts` utility for measuring Core Web Vitals
   - Integration with analytics
   - Custom event dispatching

2. **Development Dashboard**
   - `WebVitalsDashboard` component for real-time metrics
   - Visual indicators for performance issues
   - Available in development mode only

3. **Performance Budgets**
   - Defined thresholds for each metric
   - Visual indicators when thresholds are exceeded
   - Integration with CI/CD pipeline

## Component Usage Guide

### OptimizedImage

Use this component for all images to ensure proper loading and prevent layout shifts:

```tsx
<OptimizedImage
  src="/path/to/image.jpg"
  webpSrc="/path/to/image.webp"
  avifSrc="/path/to/image.avif"
  alt="Description"
  width={800}
  height={600}
  priority={isAboveTheFold}
  blurUp={!isAboveTheFold}
  blurHash="/path/to/placeholder.jpg"
/>
```

**Key props**:
- `priority`: Set to `true` for above-the-fold images
- `width` and `height`: Always provide to prevent layout shifts
- `blurUp`: Use for non-critical images to show a placeholder

### StableLayout

Use this component for dynamic content that might cause layout shifts:

```tsx
<StableLayout
  minHeight={200}
  isLoading={loading}
  adaptiveHeight={true}
>
  {content}
</StableLayout>
```

**Key props**:
- `minHeight`: Minimum height to reserve
- `isLoading`: Whether content is loading
- `adaptiveHeight`: Whether to adapt to content height

### OptimizedFonts

Use this component to optimize font loading:

```tsx
<OptimizedFonts
  fonts={[
    {
      family: 'Inter',
      url: '/fonts/inter.woff2',
      preload: true,
      display: 'swap'
    }
  ]}
/>
```

**Key props**:
- `fonts`: Array of font definitions
- `useFontLoadingAPI`: Whether to use the Font Loading API

### ResourceHints

Use this component to add resource hints:

```tsx
<ResourceHints
  hints={[
    { type: 'preconnect', href: 'https://api.example.com' },
    { type: 'dns-prefetch', href: 'https://cdn.example.com' },
    { type: 'preload', href: '/critical.js', as: 'script' }
  ]}
/>
```

**Key props**:
- `hints`: Array of resource hint definitions

## Best Practices

1. **Image Best Practices**
   - Always specify width and height
   - Use modern formats (WebP, AVIF)
   - Optimize images with proper tools
   - Lazy load below-the-fold images

2. **JavaScript Best Practices**
   - Split code by routes and components
   - Defer non-critical JavaScript
   - Minimize third-party scripts
   - Use web workers for heavy computations

3. **CSS Best Practices**
   - Use critical CSS for above-the-fold content
   - Minimize render-blocking CSS
   - Use efficient selectors
   - Avoid large CSS frameworks

4. **Font Best Practices**
   - Preload critical fonts
   - Use font-display: swap
   - Limit font variations
   - Use system fonts when possible

5. **Server Best Practices**
   - Optimize server response time
   - Use CDN for static assets
   - Implement proper caching
   - Use HTTP/2 or HTTP/3

## Future Optimizations

1. **Advanced Image Optimizations**
   - Implement image CDN
   - Add automatic responsive images
   - Implement content-aware image loading

2. **JavaScript Optimizations**
   - Implement module/nomodule pattern
   - Add script streaming
   - Optimize third-party scripts further

3. **Rendering Optimizations**
   - Implement streaming server-side rendering
   - Add partial hydration
   - Implement islands architecture

4. **Monitoring Improvements**
   - Add real user monitoring (RUM)
   - Implement performance regression testing
   - Add automated performance budgets
