## Changes

<!-- Describe the formula/version change, or the documentation/workflow change. -->

## Formula release checklist

<!-- For documentation/workflow-only PRs, mark this section as not applicable. -->

- [ ] Source URL and SHA-256 match the intended release.
- [ ] For a new upstream version, removed any previous `revision` entry and stale bottle block.
- [ ] `brew test-bot` passed on macOS and Ubuntu for the latest PR commit.
- [ ] Both `bottles_macos-26` and `bottles_ubuntu-latest` artifacts are available.

## Maintainer: publish and merge

**For formula releases, leave this PR open. Do not use GitHub's Merge button.**

1. Review the changes and wait for both bottle builds to pass.
2. Open [Actions → brew pr-pull](https://github.com/pelarejo/homebrew-tap/actions/workflows/publish.yml)
   and select **Run workflow** on `main`.
3. Set `pull_request` to this PR's number and `head_sha` to the full reviewed
   head commit SHA. If the PR changes, review and wait for its new checks first.
4. Wait for the workflow to succeed. It applies the PR changes, publishes the
   bottles, commits their metadata, and pushes to `main`.
5. Verify the release assets and updated formula on `main` before considering
   the release complete.

Documentation/workflow-only PRs can use the normal GitHub merge flow.

### If a formula release was already merged manually

Rerunning the publishing workflow may fail with an empty cherry-pick. Push checks
on `main` do not build or upload bottles.

For a fresh build through the existing workflows, open a new PR from the latest
`main`: keep the source URL/checksum, add `revision 1` (or increment the existing
revision), and remove the old bottle block. Wait for both bottle builds, then
publish that PR using **brew pr-pull** as described above. This creates a new
Homebrew package revision of the same upstream release, such as `0.1.2_1`.
