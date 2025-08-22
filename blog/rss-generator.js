/*
 * RSS Feed Generator for Cross-Platform Distribution
 * Add this to your blog to enable easy syndication
 */

export const generateRSSFeed = () => {
  const posts = [
    {
      title: "JWT vs Sessions: Complete Authentication Guide 2025",
      description:
        "Software Engineer explains JWT vs Sessions with practical examples, code samples, and a quick decision framework.",
      url: "https://www.kripanshu.me/blog/posts/jwt-vs-sessions/",
      pubDate: "2025-08-22",
      category: "Web Development",
    },
    // Add more posts here
  ];

  const rssItems = posts
    .map(
      (post) => `
    <item>
      <title><![CDATA[${post.title}]]></title>
      <description><![CDATA[${post.description}]]></description>
      <link>${post.url}</link>
      <guid isPermaLink="true">${post.url}</guid>
      <pubDate>${new Date(post.pubDate).toUTCString()}</pubDate>
      <category><![CDATA[${post.category}]]></category>
      <author>kripanshusingh160305@gmail.com (Kripanshu Singh)</author>
    </item>
  `,
    )
    .join("");

  return `<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
  <channel>
    <title>Kripanshu Singh - Software Engineering Blog</title>
    <description>Practical guides on web development, authentication, and full-stack development from Software Engineer Kripanshu Singh</description>
    <link>https://www.kripanshu.me/blog/</link>
    <atom:link href="https://www.kripanshu.me/blog/rss.xml" rel="self" type="application/rss+xml"/>
    <language>en-US</language>
    <managingEditor>kripanshusingh160305@gmail.com (Kripanshu Singh)</managingEditor>
    <webMaster>kripanshusingh160305@gmail.com (Kripanshu Singh)</webMaster>
    <lastBuildDate>${new Date().toUTCString()}</lastBuildDate>
    <category>Software Development</category>
    <ttl>60</ttl>
    ${rssItems}
  </channel>
</rss>`;
};
