ardon @ ~/Notas_Cerebro % cat ./zshrc
cat: ./zshrc: No such file or directory
ardon @ ~/Notas_Cerebro % cat ~/.zshrc
# ╔══════════════════════════════════════════════════════════════╗
# ║           .zshrc — Ardon | MacBook M1                        ║
# ║           Edición Unificada y Limpia | Mayo 2026             ║
# ╚══════════════════════════════════════════════════════════════╝

# ══════════════════════════════════════════════════════════════
# BLOQUE 1 — CONDA (Miniconda)
# ══════════════════════════════════════════════════════════════
__conda_setup="$('/opt/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup

# ══════════════════════════════════════════════════════════════
# BLOQUE 2 — PATHS Y HERRAMIENTAS
# ══════════════════════════════════════════════════════════════
alias code='/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code'
export PATH="$PATH:/Users/ardon/.lmstudio/bin"

# ══════════════════════════════════════════════════════════════
# BLOQUE 3 — ALIAS DE PRODUCTIVIDAD
# ══════════════════════════════════════════════════════════════
alias velocidad="networkQuality"
alias modo_estudio="killall DeepL Steam Spotify 2>/dev/null; echo '🎯 Modo estudio activado.'"

# ══════════════════════════════════════════════════════════════
# BLOQUE 4 — SISTEMA DE NOTAS (ZETTELKASTEN)
# ══════════════════════════════════════════════════════════════
export NOTAS_DIR="$HOME/Notas_Cerebro"

nota() {
    mkdir -p "$NOTAS_DIR"
    if [ -z "$1" ]; then
        echo "📂 Notas recientes en $NOTAS_DIR:"
        ls -lt "$NOTAS_DIR" | head -n 10
    else
        # Contar cuántas notas existen ya
        count=$(ls "$NOTAS_DIR"/*.md 2>/dev/null | wc -l)
        next=$((count + 1))
        filename="$(date '+%Y-%m-%d')_${next}_$1.md"
        vim "$NOTAS_DIR/$filename"
    fi
}


buscar() {
    if [ -z "$1" ]; then
        echo "⚠️  Uso: buscar <término>"
        return 1
    fi
    echo "🔎 Buscando '$1' en tus notas..."
    grep -ril --color "$1" "$NOTAS_DIR"/*.md 2>/dev/null || echo "Sin resultados."
}

diario() {
    mkdir -p "$NOTAS_DIR"
    if [ -z "$*" ]; then
        echo "⚠️  Uso: diario \"Tu entrada aquí\""
        return 1
    fi
    echo "📅 $(date '+%Y-%m-%d %H:%M') | $*" >> "$NOTAS_DIR/diario.md"
    echo "✅ Guardado en diario.md"
}

# Abrir toda la carpeta de notas en Zed
alias cerebro='zed ~/Notas_Cerebro'

# ══════════════════════════════════════════════════════════════
# BLOQUE 5 — PERSONALIZACIÓN VISUAL
# ══════════════════════════════════════════════════════════════
export CLICOLOR=1
export LSCOLORS=Gxfxcxdxbxegedabagacad
alias ls='ls -G'
PROMPT='%F{cyan}%n%f @ %F{yellow}%~%f %F{magenta}%#%f '

# ══════════════════════════════════════════════════════════════
# BLOQUE 6 — MENSAJE DE BIENVENIDA
# ══════════════════════════════════════════════════════════════
echo "✨ Hola de nuevo, Ardon. Terminal lista — $(date '+%A, %d %b %Y | %H:%M')"

# ══════════════════════════════════════════════════════════════
# BLOQUE 7 — GIT & NUBE (Sincronización manual)
# ══════════════════════════════════════════════════════════════
alias nube='git add . && git commit -m "desde Mac" && git push'
alias pynube='git add . && git commit -m "update python" && git push'

# ══════════════════════════════════════════════════════════════
# BLOQUE 8 — NOTAS (Extras)
# ══════════════════════════════════════════════════════════════

listar_notas() {
    echo "📑 Listado de notas en $NOTAS_DIR:"
    ls -1 "$NOTAS_DIR"/*.md | sort | sed 's#.*/##'
}

abrir_nota() {
    if [ -z "$1" ]; then
        echo "⚠️ Uso: abrir_nota <número>"
        return 1
    fi
    file=$(ls "$NOTAS_DIR"/*_"$1"_*.md 2>/dev/null | head -n 1)
    if [ -z "$file" ]; then
        echo "❌ No encontré ninguna nota con número $1"
    else
        vim "$file"
    fi
}

indexar() {
    echo "# Índice de notas" > "$NOTAS_DIR/index.md"

    # Sección Python
    echo -e "\n## Python" >> "$NOTAS_DIR/index.md"
    grep -i "python" "$NOTAS_DIR"/*.md | cut -d: -f1 | sort -u | while read file; do
        nombre=$(basename "$file")
        echo "- [$nombre]($nombre)" >> "$NOTAS_DIR/index.md"
    done

    # Sección Medicina
    echo -e "\n## Medicina" >> "$NOTAS_DIR/index.md"
    grep -iE "crohn|eii|syncope|medicina|pathophysiology|trastornos|hemostasia|epidemi" "$NOTAS_DIR"/*.md | cut -d: -f1 | sort -u | while read file; do
        nombre=$(basename "$file")
        echo "- [$nombre]($nombre)" >> "$NOTAS_DIR/index.md"
    done

    # Sección Italiano
    echo -e "\n## Italiano" >> "$NOTAS_DIR/index.md"
    grep -i "italiano\|ita_" "$NOTAS_DIR"/*.md | cut -d: -f1 | sort -u | while read file; do
        nombre=$(basename "$file")
        echo "- [$nombre]($nombre)" >> "$NOTAS_DIR/index.md"
    done

    # Sección Inglés
    echo -e "\n## Inglés" >> "$NOTAS_DIR/index.md"
    grep -i "english\|englis\|whitman\|sherlock" "$NOTAS_DIR"/*.md | cut -d: -f1 | sort -u | while read file; do
        nombre=$(basename "$file")
        echo "- [$nombre]($nombre)" >> "$NOTAS_DIR/index.md"
    done

    # Sección Literatura
    echo -e "\n## Literatura" >> "$NOTAS_DIR/index.md"
    ls "$NOTAS_DIR"/*whitman*.md "$NOTAS_DIR"/*father*.md "$NOTAS_DIR"/*sherlock*.md 2>/dev/null | while read file; do
    	nombre=$(basename "$file")
        echo "- [$nombre]($nombre)" >> "$NOTAS_DIR/index.md"
    done


    echo "✅ Índice actualizado en $NOTAS_DIR/index.md"
	


}
