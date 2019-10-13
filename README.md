# full-icu-npm-npmrc-repro

This is a reproduction of the bug described by
<https://github.com/unicode-org/full-icu-npm/pull/40>:

> `.npmrc` files are used to configure `npm` and can be set on a per-project
> basis: <https://docs.npmjs.com/files/npmrc#per-project-config-file>
>
> On install, `npm` sets the `INIT_CWD` process variable to the original
> directory that ran `npm install`: <https://docs.npmjs.com/cli/run-script>
>
> ~Using `INIT_CWD` we can run the post install step in the correct directory.~
> Installing the `icu4c-data` in `INIT_CWD` doesn't work since the path isn't
> relative to `full-icu` during install. Instead we link to the `.npmrc` locally
> during install and everything works out.
>
> This is very useful for when folks use private registries.

## Instructions

Requires Node.js, npm, npx, and bash.

Run the following:

```bash
bash ./npm-install-npmrc-repro.sh
```

This will show that the following commands fail:

```bash
npm i -S 'full-icu'
npm i -S 'https://github.com/GrabCAD/full-icu-npm#fix-use-project-npmrc'
```

Only the following command successfully installs `full-icu`:

```bash
npm i -S 'https://github.com/dfrankland/full-icu-npm#fix-npmrc-config-install'
```
