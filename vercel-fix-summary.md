# 🔧 **Fixed: Vercel Deployment Error**

## ❌ **Error:**

```
Invalid route source pattern
The source property follows the syntax from path-to-regexp, not the RegExp syntax.
```

## 🔍 **Root Cause:**

The issue was in this line in `vercel.json`:

```json
"source": "/blog/posts/*/assets/(.*)"
```

**Problem:** Vercel uses `path-to-regexp` syntax, where `*` is not a valid wildcard pattern.

## ✅ **Solution:**

**Before (❌ Invalid):**

```json
"source": "/blog/posts/*/assets/(.*)"
```

**After (✅ Valid):**

```json
"source": "/blog/posts/(.*)/assets/(.*)"
```

## 📚 **Vercel Path-to-RegExp Syntax Reference:**

### **✅ Valid Patterns:**

- `(.*)` - Captures any characters (including `/`)
- `([^/]+)` - Captures any characters except `/` (single segment)
- `/blog/posts/(.*)/assets/(.*)` - Captures post slug and asset file
- `/api/users/([^/]+)` - Captures single user ID segment

### **❌ Invalid Patterns:**

- `*` - Not valid (use `(.*)` instead)
- `**` - Not valid (use `(.*)` instead)
- `?` - Not a wildcard (it's an optional character modifier)

## 🎯 **What Your Fixed Config Does:**

### **Headers:**

```json
{
  "source": "/blog/posts/(.*)/assets/(.*)",
  "headers": [
    {
      "key": "Cache-Control",
      "value": "public, max-age=31536000, immutable"
    }
  ]
}
```

**Matches:**

- ✅ `/blog/posts/jwt-vs-sessions/assets/jwt_vs_session.png`
- ✅ `/blog/posts/react-hooks-guide/assets/hero.jpg`
- ✅ `/blog/posts/any-post-name/assets/any-file.ext`

### **Rewrites:**

```json
{
  "source": "/blog/posts/jwt-vs-sessions",
  "destination": "/blog/posts/jwt-vs-sessions/index.html"
}
```

**Converts:**

- `kripanshu.me/blog/posts/jwt-vs-sessions` → serves `/blog/posts/jwt-vs-sessions/index.html`

## 🚀 **Deploy Status:**

Your `vercel.json` is now valid and should deploy successfully!

### **Benefits of This Fix:**

- ✅ **Proper Caching:** Blog post assets get 1-year cache headers
- ✅ **Clean URLs:** `/blog/posts/jwt-vs-sessions` works without `.html`
- ✅ **SEO Optimized:** Search engines prefer clean URLs
- ✅ **Performance:** Static assets cached properly

## 🧪 **Test After Deployment:**

1. Visit `https://kripanshu.me/blog/posts/jwt-vs-sessions`
2. Check Network tab - assets should have `Cache-Control: public, max-age=31536000, immutable`
3. Verify JWT image loads: `https://kripanshu.me/blog/posts/jwt-vs-sessions/assets/jwt_vs_session.png`

**🎉 Ready to deploy! Your Vercel configuration is now syntactically correct.**
