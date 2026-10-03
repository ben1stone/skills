#!/bin/sh
# Usage: npm run new -- <skill-name>
set -e

name="$1"
if ! echo "$name" | grep -Eq '^[a-z0-9]+(-[a-z0-9]+)*$'; then
  echo "Usage: npm run new -- <skill-name>  (lowercase, hyphens allowed)" >&2
  exit 1
fi

root="$(cd "$(dirname "$0")/.." && pwd)"
dest="$root/skills/$name"

if [ -e "$dest" ]; then
  echo "skills/$name already exists" >&2
  exit 1
fi

mkdir -p "$dest"
sed "s/{{name}}/$name/g" "$root/template/SKILL.template.md" > "$dest/SKILL.md"
echo "Created skills/$name/SKILL.md"
