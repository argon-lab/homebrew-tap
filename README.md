# argon-lab/homebrew-tap

Homebrew tap for the [Argon](https://github.com/argon-lab/argon) CLI: MongoDB sandboxes for AI agents, with Git for MongoDB underneath.

```bash
brew install argon-lab/tap/argonctl
argon --version
```

This installs `argon` (and an `argonctl` alias) built from source with Go, on macOS or Linux. To upgrade: `brew upgrade argonctl`.

Argon needs MongoDB running as a replica set; a one-node replica set is fine. See the [quick start](https://github.com/argon-lab/argon/blob/master/docs/QUICK_START.md) or [argonlabs.tech/cli](https://argonlabs.tech/cli). Other ways to install: `npm install -g argonctl --allow-scripts=argonctl`.

## Maintaining the formula

`argonctl.rb` points at an Argon release tag and its tarball checksum. For each Argon release, open a pull request that updates `url` and `sha256`:

```bash
VERSION=2.12.0
curl -sL "https://github.com/argon-lab/argon/archive/refs/tags/v${VERSION}.tar.gz" | shasum -a 256
brew install --build-from-source ./argonctl.rb && brew test argonctl
```

The [Formula](.github/workflows/formula.yml) workflow runs `brew style`, `brew audit --strict --online`, a build from source, `brew test` and `brew livecheck` on macOS and Linux for every pull request and every week.

Issues with Argon itself belong in [argon-lab/argon](https://github.com/argon-lab/argon/issues).
