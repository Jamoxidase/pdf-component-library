#!/bin/bash

# PDF Component Library - Development Setup Script
# This script automates the setup process for local development

set -e  # Exit on any error

echo "🚀 Setting up PDF Component Library for development..."

# Check if we're in the right directory
if [ ! -f "README.md" ] || [ ! -d "ui" ]; then
    echo "❌ Error: Please run this script from the pdf-component-library root directory"
    exit 1
fi

# Check Node.js version
NODE_VERSION=$(node --version)
echo "📋 Using Node.js version: $NODE_VERSION"

# Check if yarn is installed
if ! command -v yarn &> /dev/null; then
    echo "❌ Error: Yarn is not installed. Please install yarn first."
    exit 1
fi

YARN_VERSION=$(yarn --version)
echo "📋 Using Yarn version: $YARN_VERSION"

echo ""
echo "📦 Installing library dependencies..."
cd ui/library
yarn install

echo ""
echo "🔨 Building the library..."
yarn build

# Check if build was successful
if [ ! -f "dist/allenai-pdf-components-1.0.1.tgz" ]; then
    echo "❌ Error: Library build failed - package not found"
    exit 1
fi

echo ""
echo "📦 Installing demo dependencies..."
cd ../demo
yarn install

echo ""
echo "🔗 Linking library to demo..."
# Remove any existing broken symlinks
if [ -L "node_modules/@allenai/pdf-components" ]; then
    rm -f node_modules/@allenai/pdf-components
fi

# Install the built library package
yarn add file:../library/dist/allenai-pdf-components-1.0.1.tgz

echo ""
echo "✅ Setup complete!"
echo ""
echo "🎯 To start the development server, run:"
echo "   cd ui/demo"
echo "   NODE_OPTIONS=\"--openssl-legacy-provider\" yarn start"
echo ""
echo "🌐 The demo will be available at: http://localhost:12000"
echo ""
echo "📚 For more details, see DEVELOPMENT_SETUP.md"