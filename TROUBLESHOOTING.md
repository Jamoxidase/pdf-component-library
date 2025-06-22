# PDF Component Library - Troubleshooting Guide

Quick reference for common issues and their solutions.

## 🚨 Common Error Messages and Fixes

### "digital envelope routines::unsupported"
```bash
# Solution: Use legacy OpenSSL provider
NODE_OPTIONS="--openssl-legacy-provider" yarn start
```

### "Module not found: Error: Can't resolve '@allenai/pdf-components'"
```bash
# Solution: Rebuild and relink library
cd ui/library && yarn build
cd ../demo && yarn add file:../library/dist/allenai-pdf-components-1.0.1.tgz
```

### "EADDRINUSE: address already in use :::12000"
```bash
# Solution: Kill existing process or change port
lsof -ti:12000 | xargs kill -9
# OR edit ui/demo/webpack.config.js and change port number
```

### Blank page or infinite loading
```bash
# Solution: Check console errors and restart
# 1. Open browser dev tools (F12)
# 2. Check Console tab for errors
# 3. Restart dev server: Ctrl+C then yarn start
```

## 🔧 Quick Diagnostic Commands

### Check if everything is installed correctly:
```bash
# From repository root
ls ui/library/dist/allenai-pdf-components-1.0.1.tgz  # Should exist
ls ui/demo/node_modules/@allenai/pdf-components      # Should exist
ls ui/demo/public/pdfs/*.pdf                         # Should show 3 PDF files
```

### Verify Node.js compatibility:
```bash
node --version  # Should be 16.x - 22.x
yarn --version  # Should be 1.22.x+
```

### Test library build:
```bash
cd ui/library
yarn build
echo $?  # Should output 0 (success)
```

## 🔄 Reset Everything (Nuclear Option)

If nothing else works, start fresh:

```bash
# From repository root
rm -rf ui/demo/node_modules ui/library/node_modules
rm -rf ui/library/dist
cd ui/library && yarn install && yarn build
cd ../demo && yarn install
yarn add file:../library/dist/allenai-pdf-components-1.0.1.tgz
NODE_OPTIONS="--openssl-legacy-provider" yarn start
```

## 📋 Pre-flight Checklist

Before asking for help, verify:

- [ ] Node.js version is 16.x - 22.x
- [ ] Yarn is installed and working
- [ ] You're in the correct directory (pdf-component-library root)
- [ ] Library builds successfully (`ui/library/yarn build`)
- [ ] Demo dependencies are installed (`ui/demo/yarn install`)
- [ ] Library is linked to demo (check `ui/demo/node_modules/@allenai/pdf-components`)
- [ ] Using `NODE_OPTIONS="--openssl-legacy-provider"` flag
- [ ] Port 12000 is available
- [ ] PDF files exist in `ui/demo/public/pdfs/`

## 🆘 Still Having Issues?

1. **Check browser console** (F12 → Console tab) for specific error messages
2. **Try the automated setup script**: `./setup-dev.sh`
3. **Use Docker as fallback**: `docker-compose up --build` (from root)
4. **Check the full setup guide**: `DEVELOPMENT_SETUP.md`

## 📞 Success Indicators

You know it's working when:
- ✅ Webpack dev server starts without errors
- ✅ Browser opens to http://localhost:12000
- ✅ PDF loads and displays text content
- ✅ Navigation controls work (zoom, page numbers)
- ✅ Sidebar features work (outline, thumbnails)
- ✅ No red errors in browser console