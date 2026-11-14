#!/usr/bin/env bash
set -euo pipefail

# Install or update the shared LaTeX style for every user of alfdoc: one clone in the
# texmf tree, where kpsewhich finds it, taken from this repo on GitHub.
#   curl -fsSL https://raw.githubusercontent.com/Atcold/alfdoc/master/install.sh | bash
texmf="$HOME/Library/texmf/tex/latex/alfdoc"
url="https://github.com/Atcold/alfdoc"

# The clone is this repo if its origin names Atcold/alfdoc, over any transport:
# https or ssh, with or without the .git suffix.
is_alfdoc() {
    case "$(git -C "$1" remote get-url origin 2>/dev/null)" in
        *github.com[:/]Atcold/alfdoc | *github.com[:/]Atcold/alfdoc.git) return 0 ;;
    esac
    return 1
}

mkdir -p "$(dirname "$texmf")"
if [ -d "$texmf/.git" ] && is_alfdoc "$texmf"; then
    git -C "$texmf" pull --ff-only
    echo "alfdoc updated in $texmf"
    exit 0
fi

# Preserve anything else that occupies the path, links to a removed folder included.
if [ -e "$texmf" ] || [ -L "$texmf" ]; then
    mkdir -p "$HOME/Work/Scratch/alfdoc-install"
    backup=$(mktemp -d "$HOME/Work/Scratch/alfdoc-install/install.XXXXXX")
    mv "$texmf" "$backup/alfdoc"
    echo "previous alfdoc moved to $backup/alfdoc"
fi

git clone -q "$url" "$texmf"
echo "alfdoc installed in $texmf"
