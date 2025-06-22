# PDF Component Library - Development Setup Guide

This guide provides step-by-step instructions for setting up and running the PDF component library demo locally.

## Prerequisites

- Node.js (tested with v22.16.0, but requires legacy OpenSSL provider)
- Yarn package manager (v1.22.22+)
- Git

## Quick Start

### 1. Clone and Navigate
```bash
git clone https://github.com/Jamoxidase/pdf-component-library.git
cd pdf-component-library
```

### 2. Install Dependencies

Install library dependencies:
```bash
cd ui/library
yarn install
```

Install demo dependencies:
```bash
cd ../demo
yarn install
```

### 3. Build the Library

From the `ui/library` directory:
```bash
yarn build
```

This creates a package at `ui/library/dist/allenai-pdf-components-1.0.1.tgz`

### 4. Link the Library to Demo

From the `ui/demo` directory:
```bash
yarn add file:../library/dist/allenai-pdf-components-1.0.1.tgz
```

### 5. Start the Development Server

From the `ui/demo` directory:
```bash
NODE_OPTIONS="--openssl-legacy-provider" yarn start
```

The demo will be available at: `http://localhost:12000`

## Troubleshooting

### Node.js Compatibility Issues

If you encounter OpenSSL or webpack errors:
- Use Node.js 16-22
- Always include `NODE_OPTIONS="--openssl-legacy-provider"` when starting the dev server
- If using older Node.js versions, you may not need the OpenSSL flag

### Library Linking Issues

If the demo can't find `@allenai/pdf-components`:
1. Ensure the library is built: `cd ui/library && yarn build`
2. Remove any broken symlinks: `rm -rf ui/demo/node_modules/@allenai/pdf-components`
3. Reinstall the library: `cd ui/demo && yarn add file:../library/dist/allenai-pdf-components-1.0.1.tgz`

### Port Issues

The demo runs on port 12000 by default. If this port is in use:
- Check `ui/demo/webpack.config.js` and modify the `devServer.port` setting
- Update any CORS or host configurations accordingly

### PDF Loading Issues

The demo includes local PDF files in `ui/demo/public/pdfs/`:
- `2409.13740v2.pdf` - Research paper (1.9MB)
- `2504.15777v1-3.pdf` - Research paper (6.2MB) 
- `dummy.pdf` - Small test file (13KB)

If PDFs don't load:
1. Verify files exist in `ui/demo/public/pdfs/`
2. Check browser console for CORS or loading errors
3. Ensure webpack dev server is serving static files correctly

## Development Workflow

### Making Changes to the Library

1. Make changes in `ui/library/src/`
2. Rebuild: `cd ui/library && yarn build`
3. Update demo: `cd ../demo && yarn add file:../library/dist/allenai-pdf-components-1.0.1.tgz`
4. Restart dev server if needed

### Making Changes to the Demo

1. Make changes in `ui/demo/components/` or other demo files
2. The webpack dev server will hot-reload automatically
3. No rebuild needed for demo-only changes

## Features Available in Demo

- **PDF Rendering**: Full PDF display with text layer
- **Navigation**: Page controls, zoom, thumbnails
- **Interactive Elements**: Citations, highlighting, annotations
- **Sidebar Features**: Outline, thumbnails, highlights
- **Note Taking**: Hypothesis.io integration
- **Accessibility**: Keyboard navigation, screen reader support

## Configuration Files

Key configuration files and their purposes:

- `ui/demo/webpack.config.js` - Webpack dev server configuration
- `ui/demo/package.json` - Demo dependencies and scripts
- `ui/library/package.json` - Library dependencies and build scripts
- `ui/demo/components/Reader.tsx` - Main demo component with PDF integration

## Environment Variables

No environment variables are required for basic functionality. The demo uses:
- Local PDF files (no external API keys needed)
- Mock citation data (no external services required)
- Local development server (no deployment configuration needed)

## Docker Alternative (Optional)

If you prefer Docker (though local setup is recommended):

```bash
# From repository root
docker-compose up --build
```

Note: Docker setup may have additional complexity. Local development is more reliable.

## Common Issues and Solutions

### "Module not found: @allenai/pdf-components"
- **Solution**: Rebuild library and reinstall in demo (see Library Linking Issues above)

### "digital envelope routines::unsupported"
- **Solution**: Use `NODE_OPTIONS="--openssl-legacy-provider"` flag

### "Cannot resolve 'pdfjs-dist/cmaps'"
- **Solution**: Ensure webpack is copying cmaps correctly (check webpack.config.js CopyPlugin)

### Blank page or infinite loading
- **Solution**: Check browser console for errors, verify PDF files exist, restart dev server

### Port 12000 already in use
- **Solution**: Kill existing process or change port in webpack.config.js

## Success Indicators

When everything is working correctly, you should see:
1. Webpack dev server starts without errors
2. Browser opens to `http://localhost:12000`
3. PDF loads and displays properly
4. All interactive features work (zoom, navigation, citations)
5. No console errors in browser developer tools

## Getting Help

If you encounter issues not covered here:
1. Check the browser console for specific error messages
2. Verify all dependencies are installed correctly
3. Ensure you're using compatible Node.js version
4. Try the troubleshooting steps in order
5. Consider using the Docker setup as an alternative

## Last Updated

This guide was last updated based on successful setup with:
- Node.js v22.16.0
- Yarn v1.22.22
- PDF Component Library commit: 92b70f4