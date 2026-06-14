# Quick Start Guide

## ✅ What's Been Created

Your repository now has a complete GitHub Actions workflow that:
- **Fetches** your Notion portfolio daily at 07:00 UTC
- **Converts** it to static HTML with local links
- **Deploys** automatically to GitHub Pages

## 🚀 Quick Setup (3 Steps)

### Step 1: Enable GitHub Pages
1. Go to your repo on GitHub.com
2. **Settings** → **Pages**
3. **Source**: "Deploy from a branch"
4. **Branch**: Select `gh-pages`
5. Click **Save**

### Step 2: Grant Permissions (if needed)
1. **Settings** → **Actions** → **General**
2. Enable "Read and write permissions" for workflows
3. Save

### Step 3: Wait for First Run
- The workflow runs automatically **every day at 07:00 UTC**
- Or manually trigger it from the **Actions** tab
- First deployment takes ~1-2 minutes

## 📁 Files Created

| File | Purpose |
|------|---------|
| `.github/workflows/notion-to-pages.yml` | Main GitHub Actions workflow |
| `NOTION_WORKFLOW_README.md` | Full documentation |
| `setup-notion-workflow.sh` | Setup helper script |

## 🔗 Your GitHub Pages URL

Once deployed, your site will be at:
```
https://<your-username>.github.io/<your-repo-name>/
```

## ⏰ Customizing Schedule

Edit `.github/workflows/notion-to-pages.yml`, line ~8:

```yaml
schedule:
  - cron: '0 7 * * *'  # Change the time here
```

**Examples:**
- `0 9 * * *` = 09:00 UTC daily
- `0 7 * * 1` = Monday at 07:00 UTC
- `0 7 * * 0,6` = Weekends at 07:00 UTC

## 🔍 Check Status

1. Go to your repo on GitHub
2. Click **Actions** tab
3. Select **"Notion to GitHub Pages"** workflow
4. View running/completed workflows
5. Click a run to see details

## 🆘 Issues?

### Site not updating?
- ✓ Check Actions tab for workflow errors
- ✓ Verify GitHub Pages is enabled in Settings
- ✓ Wait 1-2 minutes for deployment
- ✓ Hard refresh your browser (Cmd+Shift+R)

### Workflow won't run?
- ✓ Verify GitHub Pages is enabled first
- ✓ Check Actions permissions are enabled
- ✓ Try manually running from Actions tab

## 📚 Full Documentation

See `NOTION_WORKFLOW_README.md` for:
- Detailed step-by-step process
- Customization options
- Troubleshooting guide
- Advanced configuration

## 💡 What Happens Each Run

```
Notion Page Fetched
        ↓
    Markdown Files
        ↓
    HTML Generated
        ↓
    Links Converted (notion.site → local)
        ↓
    Site Deployed
        ↓
    ✓ Live on GitHub Pages
```

## 🎯 Next Steps

1. ✅ Set up GitHub Pages (Settings)
2. ✅ Wait for first workflow run (or manually trigger)
3. ✅ Visit your GitHub Pages URL
4. ✅ Share with others!

**Questions?** See the detailed docs in `NOTION_WORKFLOW_README.md`.
