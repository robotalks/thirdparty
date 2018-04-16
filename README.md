# What's in this repo

All third-party components wrapped with HyperMake modules.
This repo can be used as git submodule in other repos and all third-party
components can be referenced as dependencies in HyperMake.

## Output

The output is placed at

```
out/<ARCH>/
```

Where currently supported `ARCH` is `amd64`, `armhf` and `noarch` which is for
architecture independent components, like C++ headers for templates only.
Under the folder, the directory structure is like that under `/usr/local`,
including `bin`, `include`, `lib`, `share`.
