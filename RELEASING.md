# Releasing the self-hosted chart

OpsLevel cuts self-hosted releases of `charts/opslevel` and publishes them through Replicated. These tasks are
the repository side of that process:

- `task internal-release` publishes the chart as it stands to the `Helm-Unstable` channel for internal testing.
  The **Internal Release** GitHub Action runs it when a merge to `main` changes the chart's `version`.
- `task public-release` publishes it to the customer `Helm` channel. It only runs from a clean, up-to-date
  `main`. Pass `RELEASE_NOTES=path/to/notes.md` (to either task) to publish release notes with it. The
  **Public Release** GitHub Action runs it on demand, given the version to release (which must match `main`'s) and
  the notes.
- `task pin-digests` sets each private-ECR image's `digest` in `values.yaml` to what its `tag` points at today,
  since the chart pulls `repo:tag@digest`. `CHECK=true` only reports stale digests. It needs AWS credentials that
  can describe images in the registry.

The chart's `version` and `appVersion` are both the release's date, unpadded, e.g. `2026.10.29`.
