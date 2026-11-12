#!/usr/bin/env bash
# Pins every private-ECR image in values.yaml to the digest its tag points at today.
# ECR tags in these repos are mutable, so the chart pulls repo:tag@digest.
#
#   scripts/pin-digests.sh          rewrite stale digests in place
#   scripts/pin-digests.sh --check  exit 1 if any digest is stale, change nothing
#
# Read-only against AWS (ecr describe-images). Fails if a tag doesn't exist.
set -euo pipefail

VALUES="${VALUES:-charts/opslevel/values.yaml}"
CHECK=false
[[ "${1:-}" == "--check" ]] && CHECK=true

# One row per image: path, repository, tag, current digest, digest's line number.
# The minio CLI image uses the *CLI keys beside the server image's.
images() {
  for suffix in "" "CLI"; do
    yq -r ".. | select(tag == \"!!map\" and has(\"repository${suffix}\"))
      | [(path | join(\".\")) + \"${suffix:+ (CLI)}\", .repository${suffix}, .tag${suffix}, .digest${suffix}, (.digest${suffix} | line)]
      | @tsv" "$VALUES"
  done
}

stale=0
while IFS=$'\t' read -r path repo tag digest line; do
  [[ "$repo" =~ ^[0-9]+\.dkr\.ecr\.([a-z0-9-]+)\.amazonaws\.com/(.+)$ ]] || continue
  region="${BASH_REMATCH[1]}"
  name="${BASH_REMATCH[2]}"

  if [[ "$line" == "0" ]]; then
    echo "error: $path has no digest key to pin" >&2
    exit 1
  fi

  want=$(aws ecr describe-images --region "$region" --repository-name "$name" \
    --image-ids imageTag="$tag" --query 'imageDetails[0].imageDigest' --output text)

  if [[ "$want" == "$digest" ]]; then
    echo "ok     $path $name:$tag"
    continue
  fi

  stale=1
  echo "stale  $path $name:$tag  $digest -> $want"
  $CHECK && continue
  sed -i.bak "${line}s|\"${digest}\"|\"${want}\"|" "$VALUES"
  if ! sed -n "${line}p" "$VALUES" | grep -qF "\"${want}\""; then
    echo "error: couldn't rewrite line $line of $VALUES; is the digest quoted?" >&2
    exit 1
  fi
done < <(images)

rm -f "$VALUES.bak"
$CHECK && exit $stale
exit 0
