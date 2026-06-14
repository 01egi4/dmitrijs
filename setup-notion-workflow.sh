#!/bin/bash

# Notion to GitHub Pages - Setup Script
# This script sets up the repository for automatic Notion page publishing

set -e

echo "🚀 Setting up Notion to GitHub Pages workflow..."

# Create necessary directories
mkdir -p .github/workflows
mkdir -p notion-output
mkdir -p site

# Verify workflow file exists
if [ ! -f .github/workflows/notion-to-pages.yml ]; then
    echo "❌ Workflow file not found"
    exit 1
fi

echo "✓ Directory structure created"

# Create .gitignore entries if needed
if [ ! -f .gitignore ]; then
    cat > .gitignore << 'EOF'
node_modules/
.DS_Store
*.log
dist/
build/
EOF
    echo "✓ .gitignore created"
else
    # Ensure our entries are in .gitignore
    grep -q "node_modules/" .gitignore || echo "node_modules/" >> .gitignore
fi

echo ""
echo "📋 Setup Instructions:"
echo "====================="
echo ""
echo "1. GITHUB PAGES CONFIGURATION:"
echo "   - Go to: https://github.com/<username>/<repo>/settings/pages"
echo "   - Source: Select 'Deploy from a branch'"
echo "   - Branch: Select 'gh-pages' (or 'main' if using publish_branch)"
echo "   - Folder: Select '/ (root)'"
echo ""
echo "2. WORKFLOW WILL:"
echo "   - Run daily at 07:00 UTC (adjust cron in workflow if needed)"
echo "   - Fetch your Notion portfolio page and all subpages"
echo "   - Convert Markdown to static HTML"
echo "   - Create local internal links between pages"
echo "   - Deploy to GitHub Pages automatically"
echo ""
echo "3. MANUAL TRIGGER:"
echo "   - Visit: https://github.com/<username>/<repo>/actions"
echo "   - Select 'Notion to GitHub Pages' workflow"
echo "   - Click 'Run workflow' to trigger manually"
echo ""
echo "4. CUSTOM TIMEZONE:"
echo "   - Edit .github/workflows/notion-to-pages.yml"
echo "   - Change cron '0 7 * * *' to your preferred time"
echo "   - UTC+1 = '0 6 * * *', UTC+2 = '0 5 * * *', etc."
echo ""
echo "✓ Setup complete! Workflow is ready to use."
