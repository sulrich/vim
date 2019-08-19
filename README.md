# overview

my personal collection of vim shiz. plugins are kept in submodules (this assumes
that the modules are available via git) things which aren't necessarily standard
submodules are integrated into this repo directly.


# plugins

## plugin: installation

```
git submodule add <git-clone-url> pack/default/start
git commit # to actually commit the submodule
```

## plugin: refresh
```
git submodule update --remote --merge --recursive
git commit
```

## plugin: removal

```
git submodule deinit <local-path-to-submodule-entry>
git rm <local-path-to-submodule-entry>
rm -rf .git/modules/pack/default/start/<local-package-dir-name>
git commit
```

# new host installation

```
git clone https://github.com/sulrich/vim.git
git submodule update --init
```
