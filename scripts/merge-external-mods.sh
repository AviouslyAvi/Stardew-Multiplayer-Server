#!/bin/bash
set -e

EXT_MODS_DIR="/external-mods"
GAME_MODS_DIR="/data/stardewvalley/Mods"

if [[ ! -d "${EXT_MODS_DIR}" ]]; then
  echo "[mods] No external mods mount found at ${EXT_MODS_DIR}; skipping merge."
  exit 0
fi

echo "[mods] Merging external mods from ${EXT_MODS_DIR} into ${GAME_MODS_DIR}..."

mkdir -p "${GAME_MODS_DIR}"

# Copy each top-level mod folder into the game Mods directory so built-in mods remain available.
for item in "${EXT_MODS_DIR}"/*; do
  [[ -e "${item}" ]] || continue
  name="$(basename "${item}")"

  # Skip common generated folders from local Windows installs.
  if [[ "${name}" == "ConsoleCommands" || "${name}" == "SaveBackup" ]]; then
    echo "[mods] Skipping helper folder: ${name}"
    continue
  fi

  target="${GAME_MODS_DIR}/${name}"
  rm -rf "${target}"
  cp -a "${item}" "${target}"
  echo "[mods] Installed external mod: ${name}"
done

echo "[mods] External mod merge complete."
