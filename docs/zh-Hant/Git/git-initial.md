# Git Initial

## create a new repository on the command line

```shell
echo "# README" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/{username}/{reponame}.git
git push -u origin main
```

## push an existing repository from the command line

```shell
git remote add origin https://github.com/{username}/{reponame}.git
git branch -M main
git push -u origin main
```

## import code from another repository

```shell
You can initialize this repository with code from a Subversion, Mercurial, or TFS project.
```
