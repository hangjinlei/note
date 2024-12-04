# Deploy to GitHub Pages

Version: Angular 18

```bash
ng build --output-path docs --base-href ./
```

```bash
mv docs/browser/* docs/
```

```bash
cp docs/index.html docs/404.html
```

## Reference

-   [Linkedin - Publish A Blazor Or Any Webapp On GitHub Pages For Free](https://www.linkedin.com/pulse/publish-blazor-any-webapp-github-pages-free-rikam-palkar/)
