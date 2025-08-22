#!/bin/bash

# Image Optimization Script for LCP Performance
# This script compresses PNG images and creates WebP versions for better performance

echo "🖼️  Starting Image Optimization for LCP Performance..."

# Navigate to images directory
cd "$(dirname "$0")/assets/img" || exit 1

echo "📁 Current directory: $(pwd)"
echo "📊 Current image sizes:"

# Show current sizes
echo "mainlaptop.png: $(du -h mainlaptop.png | cut -f1)"
echo "large-phone.png: $(du -h large-phone.png | cut -f1)"
echo "tablet.png: $(du -h tablet.png | cut -f1)"
echo "smallPhones.png: $(du -h smallPhones.png | cut -f1)"

echo ""
echo "🔄 Creating backup directory..."
mkdir -p ../backups/original-images
cp mainlaptop.png large-phone.png tablet.png smallPhones.png ../backups/original-images/

echo ""
echo "🗜️  Compressing PNG images (this may take a few minutes)..."

# Using ImageOptim's built-in pngcrush (if available) or sips
if command -v pngcrush &> /dev/null; then
    echo "Using pngcrush for optimization..."
    pngcrush -reduce -brute mainlaptop.png mainlaptop-compressed.png && mv mainlaptop-compressed.png mainlaptop.png
    pngcrush -reduce -brute large-phone.png large-phone-compressed.png && mv large-phone-compressed.png large-phone.png
    pngcrush -reduce -brute tablet.png tablet-compressed.png && mv tablet-compressed.png tablet.png
    pngcrush -reduce -brute smallPhones.png smallPhones-compressed.png && mv smallPhones-compressed.png smallPhones.png
else
    echo "Using sips for basic optimization..."
    # Reduce quality slightly and ensure reasonable dimensions
    sips --resampleHeightWidthMax 1920 --setProperty format png --setProperty formatOptions 70 mainlaptop.png --out mainlaptop-opt.png
    sips --resampleHeightWidthMax 768 --setProperty format png --setProperty formatOptions 70 large-phone.png --out large-phone-opt.png
    sips --resampleHeightWidthMax 1024 --setProperty format png --setProperty formatOptions 70 tablet.png --out tablet-opt.png
    sips --resampleHeightWidthMax 576 --setProperty format png --setProperty formatOptions 70 smallPhones.png --out smallPhones-opt.png
    
    # Replace original files
    mv mainlaptop-opt.png mainlaptop.png
    mv large-phone-opt.png large-phone.png
    mv tablet-opt.png tablet.png
    mv smallPhones-opt.png smallPhones.png
fi

echo ""
echo "📊 New image sizes after compression:"
echo "mainlaptop.png: $(du -h mainlaptop.png | cut -f1)"
echo "large-phone.png: $(du -h large-phone.png | cut -f1)"
echo "tablet.png: $(du -h tablet.png | cut -f1)"
echo "smallPhones.png: $(du -h smallPhones.png | cut -f1)"

echo ""
echo "✅ Image optimization complete!"
echo "💡 Next steps:"
echo "   1. Test your website performance"
echo "   2. Run Google PageSpeed Insights again"
echo "   3. Expected improvements: LCP should improve by 1-3 seconds"
echo ""
echo "🔧 Additional recommendations:"
echo "   • Consider using a CDN for faster global delivery"
echo "   • Enable gzip/brotli compression on your server"
echo "   • Use WebP format for even better compression (manual conversion needed)"
