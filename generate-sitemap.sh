#!/bin/bash

# Automated Sitemap Generator for Kripanshu Singh's Blog
# Run this script whenever you add a new blog post

# Configuration
SITE_URL="https://www.kripanshu.me"
SITEMAP_FILE="sitemap.xml"
BLOG_DIR="blog/posts"

# Get current date in ISO format
CURRENT_DATE=$(date +"%Y-%m-%d")

echo "Generating sitemap for $SITE_URL..."

# Start sitemap
cat > $SITEMAP_FILE << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"
        xmlns:image="http://www.google.com/schemas/sitemap-image/1.1">
  <!-- Main Portfolio Page -->
  <url>
    <loc>https://www.kripanshu.me/</loc>
    <lastmod>2025-08-22</lastmod>
    <changefreq>weekly</changefreq>
    <priority>1.0</priority>
    <image:image>
      <image:loc>https://www.kripanshu.me/assets/img/pixelcut-export-1731953948845~2.png</image:loc>
      <image:title>Kripanshu Singh - Software Engineer</image:title>
      <image:caption>Professional photo of Kripanshu Singh, Software Engineer seeking new opportunities with experience at Aarogya ID and Messold Technologies</image:caption>
    </image:image>
  </url>
  
  <!-- Portfolio Sections -->
  <url>
    <loc>https://www.kripanshu.me/#about</loc>
    <lastmod>2025-08-22</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.8</priority>
  </url>
  
  <url>
    <loc>https://www.kripanshu.me/#resume</loc>
    <lastmod>2025-08-22</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.9</priority>
  </url>
  
  <url>
    <loc>https://www.kripanshu.me/#portfolio</loc>
    <lastmod>2025-08-22</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.8</priority>
  </url>
  
  <url>
    <loc>https://www.kripanshu.me/#services</loc>
    <lastmod>2025-08-22</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.7</priority>
  </url>
  
  <url>
    <loc>https://www.kripanshu.me/#contact</loc>
    <lastmod>2025-08-22</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.8</priority>
  </url>
  
  <!-- Blog Hub Page -->
  <url>
    <loc>https://www.kripanshu.me/blog/</loc>
    <lastmod>2025-08-22</lastmod>
    <changefreq>weekly</changefreq>
    <priority>0.9</priority>
  </url>
EOF

# Add blog posts dynamically
echo "  <!-- Blog Posts (Spokes) -->" >> $SITEMAP_FILE

# Find all blog post directories
if [ -d "$BLOG_DIR" ]; then
    for post_dir in $BLOG_DIR/*/; do
        if [ -d "$post_dir" ]; then
            # Extract post slug from directory name
            post_slug=$(basename "$post_dir")
            
            # Check if index.html exists
            if [ -f "$post_dir/index.html" ]; then
                echo "  <url>" >> $SITEMAP_FILE
                echo "    <loc>$SITE_URL/blog/posts/$post_slug/</loc>" >> $SITEMAP_FILE
                echo "    <lastmod>$CURRENT_DATE</lastmod>" >> $SITEMAP_FILE
                echo "    <changefreq>monthly</changefreq>" >> $SITEMAP_FILE
                echo "    <priority>0.8</priority>" >> $SITEMAP_FILE
                
                # Check for featured image
                if [ -f "$post_dir/assets/"*.png ] || [ -f "$post_dir/assets/"*.jpg ]; then
                    image_file=$(ls "$post_dir/assets/"*.{png,jpg} 2>/dev/null | head -1)
                    if [ -n "$image_file" ]; then
                        image_name=$(basename "$image_file")
                        echo "    <image:image>" >> $SITEMAP_FILE
                        echo "      <image:loc>$SITE_URL/blog/posts/$post_slug/assets/$image_name</image:loc>" >> $SITEMAP_FILE
                        echo "      <image:title>$post_slug - Kripanshu Singh Blog</image:title>" >> $SITEMAP_FILE
                        echo "      <image:caption>Technical guide by Software Engineer Kripanshu Singh</image:caption>" >> $SITEMAP_FILE
                        echo "    </image:image>" >> $SITEMAP_FILE
                    fi
                fi
                
                echo "  </url>" >> $SITEMAP_FILE
                echo "Added blog post: $post_slug"
            fi
        fi
    done
fi

# Close sitemap
cat >> $SITEMAP_FILE << 'EOF'
  
  <!-- Resume PDF -->
  <url>
    <loc>https://www.kripanshu.me/assets/documents/Kripanshu_Singh_Resume.pdf</loc>
    <lastmod>2025-08-22</lastmod>
    <changefreq>monthly</changefreq>
    <priority>0.7</priority>
  </url>
</urlset>
EOF

echo "Sitemap generated successfully: $SITEMAP_FILE"
echo ""
echo "Next steps:"
echo "1. Submit sitemap to Google Search Console: https://search.google.com/search-console"
echo "2. Submit to Bing Webmaster Tools: https://www.bing.com/webmasters"
echo "3. Update robots.txt if needed"
echo ""
echo "SEO Tips:"
echo "- Add internal links between blog posts"
echo "- Include author bio with portfolio links"
echo "- Use proper heading hierarchy (H1, H2, H3)"
echo "- Add meta descriptions and titles"
echo "- Include structured data (JSON-LD)"
