# Notion to GitHub Pages Workflow

This GitHub Actions workflow automatically fetches your public Notion portfolio page, converts it to a static website with local internal links, and deploys it to GitHub Pages daily at 07:00 UTC.

## 📋 Workflow Overview

### 1. **Schedule Trigger**
- **Frequency**: Daily at 07:00 UTC
- **Cron Expression**: `0 7 * * *`
- **Manual Trigger**: Also available via workflow dispatch

### 2. **Extraction & Conversion Process**

The workflow performs the following steps:

```
┌─────────────────────────────────────────────────────────┐
│ 1. Fetch Public Notion Page                            │
│    └─ URL: https://dmitrijscelinskis.notion.site/portfolio
│    └─ Includes: All subpages recursively               │
│    └─ Tool: notion2md                                  │
├─────────────────────────────────────────────────────────┤
│ 2. Convert Markdown to HTML                            │
│    └─ Process: Markdown → HTML                         │
│    └─ Tool: marked (Node.js markdown parser)           │
│    └─ Styling: Built-in responsive CSS                │
├─────────────────────────────────────────────────────────┤
│ 3. Fix Internal Links                                  │
│    └─ Convert: notion.site/page → ./page.html         │
│    └─ Benefit: Works offline with local links         │
├─────────────────────────────────────────────────────────┤
│ 4. Deploy to GitHub Pages                              │
│    └─ Branch: gh-pages (auto-created)                 │
│    └─ URL: https://username.github.io/repo/           │
└─────────────────────────────────────────────────────────┘
```

## ⚙️ Workflow Steps Breakdown

### Setup Phase
1. **Checkout Repository** - Retrieves latest code
2. **Setup Node.js** - Installs Node.js v18 runtime
3. **Install notion2md** - Global tool for Notion API access

### Extraction Phase
4. **Create Output Directory** - Staging area for raw Markdown files
5. **Fetch Notion Page** - Downloads page and subpages recursively
   - Uses `notion2md` with `--recursive --include-subpages` flags
   - Preserves file structure and hierarchy

### Conversion Phase
6. **Generate Static HTML** - Node.js script converts:
   - Markdown → HTML
   - Notion links → Local links
   - Adds responsive styling
   - Maintains file organization

7. **Ensure Index Page** - Creates landing page if missing

### Deployment Phase
8. **Configure Git** - Sets up commit author
9. **Commit Changes** - Records update in repository history
10. **Deploy to GitHub Pages** - Uses `peaceiris/actions-gh-pages@v3`
11. **Print Summary** - Logs completion status

## 🔧 Configuration

### Change Schedule
Edit `.github/workflows/notion-to-pages.yml`:

```yaml
schedule:
  - cron: '0 7 * * *'  # Change this time
```

**Cron Format**: `minute hour day month weekday`

| Timezone | Cron | Offset from UTC |
|----------|------|-----------------|
| UTC | `0 7 * * *` | +0 |
| UTC+1 (CET) | `0 6 * * *` | -1h |
| UTC+2 (CEST) | `0 5 * * *` | -2h |
| UTC-5 (EST) | `0 12 * * *` | +5h |
| UTC-8 (PST) | `0 15 * * *` | +8h |

### Change Notion Page URL
In the workflow under `env`:

```yaml
env:
  NOTION_PAGE_URL: 'https://dmitrijscelinskis.notion.site/portfolio'
```

## 🚀 Initial Setup

### 1. Enable GitHub Pages
- Go to **Settings** → **Pages**
- **Source**: Select "Deploy from a branch"
- **Branch**: Select `gh-pages` 
- **Folder**: Select `/ (root)`
- Click **Save**

### 2. Grant Workflow Permissions
- Go to **Settings** → **Actions** → **General**
- Under "Workflow permissions", select "Read and write permissions"
- Check "Allow GitHub Actions to create and approve pull requests"

### 3. Run First Time (Optional)
- Go to **Actions** tab
- Select **"Notion to GitHub Pages"** workflow
- Click **"Run workflow"** → **"Run workflow"** again

## 📁 Generated File Structure

```
your-repo/
├── .github/
│   └── workflows/
│       └── notion-to-pages.yml          # This workflow
├── notion-output/                       # Raw markdown files (cached)
│   ├── portfolio.md
│   ├── about.md
│   └── projects.md
├── site/                                # Generated static website
│   ├── index.html                       # Landing page
│   ├── portfolio.html
│   ├── about.html
│   └── projects.html
└── .github/workflows/notion-to-pages.yml
```

## 🔗 Internal Links

The workflow automatically converts Notion links to local HTML links:

**Before** (Notion):
```markdown
[About page](https://dmitrijscelinskis.notion.site/about)
```

**After** (Local):
```html
<a href="./about.html">About page</a>
```

## 📊 Monitoring

### View Workflow Runs
1. Go to **Actions** tab
2. Select **"Notion to GitHub Pages"**
3. View run history with status badges

### Check Deployment Status
1. Go to **Settings** → **Pages**
2. View deployment history and current URL
3. Click the deployment link to verify

### Debug Logs
If workflow fails:
1. Click the failed run
2. Expand **"Build and deploy"** section
3. Review logs for error messages

## 🆘 Troubleshooting

### "notion2md command not found"
- Ensure Node.js is installed globally
- The workflow installs it automatically; if errors persist, check npm permissions

### "Notion page not accessible"
- Verify the Notion page is **publicly shared**
- Check URL format in workflow
- Ensure no authentication is required

### "GitHub Pages not updating"
- Check **Settings** → **Pages** is configured correctly
- Verify workflow ran successfully in **Actions** tab
- GitHub Pages may cache; do a hard refresh (Cmd+Shift+R)

### "Local links not working"
- Verify HTML files exist in `site/` directory
- Check file naming consistency (all lowercase recommended)
- Inspect HTML file links in browser developer tools

## 🎨 Customization

### Modify HTML Styling
Edit the `template` function in the workflow's `convert.js` section:

```javascript
const template = (content, title) => `
<!DOCTYPE html>
<html>
<head>
  <style>
    /* Add your CSS here */
  </style>
</head>
...
```

### Add Custom Navigation
Edit the template's `<nav>` section to add links, breadcrumbs, or menus.

## 📝 Notes

- Notion page must be **publicly shared** (no auth required)
- Runs are logged; check **Actions** for status
- Deployments typically take 1-2 minutes
- GitHub Pages has rate limiting; consider spacing runs if needed
- Static site is read-only; updates require re-running workflow

## 🔐 Permissions

The workflow requires:
- `contents: write` - To commit changes
- `pages: write` - To deploy to GitHub Pages
- `id-token: write` - For authentication
- GitHub's default `GITHUB_TOKEN` (automatic)

All permissions are scoped to this workflow and are essential for operation.

## 📚 Related Tools

- **notion2md**: https://github.com/deeplex/notion2md
- **marked.js**: https://marked.js.org/
- **GitHub Pages**: https://pages.github.com/
- **GitHub Actions**: https://docs.github.com/actions

## ❓ FAQ

**Q: Can I customize the schedule to run on specific days?**
A: Yes, modify the cron expression. For example, `0 7 * * 1-5` runs Mon-Fri.

**Q: What if my Notion page structure changes?**
A: The workflow will automatically fetch the new structure on the next run.

**Q: Can I deploy to a different branch?**
A: Yes, change `publish_branch` in the workflow configuration.

**Q: Is my Notion data cached?**
A: Yes, locally in `notion-output/` for reference; regenerated with each run.

**Q: Can multiple sites run from one repository?**
A: Yes, create separate workflows with different Notion URLs and subdirectories.
