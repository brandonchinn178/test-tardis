# test-tardis

This repo contains a quick Haskell exercise using the [tardis][tardis] package.

I wanted to see if using the Tardis monad to reduce the number of passes in a
data structure would reduce the runtime. It doesn't seem like it does, but
maybe my usage of HashMap slows it down.

## Usage

```bash
stack build --test --bench
```

[tardis]: https://www.stackage.org/lts-13.17/package/tardis-0.4.1.0
