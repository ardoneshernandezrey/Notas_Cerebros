#!/bin/zsh

BASE="/Users/ardon/Notas_Cerebro"
PATRONES="$BASE/patrones.json"

# En Zsh activa NULL_GLOB para que *.md no falle ni lance error si no hay archivos
setopt NULL_GLOB

echo "🤖 ULTRA PRO: Clasificación inteligente iniciada…"

# Función: detectar categoría usando jq
detectar_categoria() {
    local nombre="$1"
    local nombre_lc="${nombre:l}" # Sintaxis nativa de Zsh para pasar a minúsculas

    # Comprobamos si el nombre CONTIENE la palabra clave del JSON de forma segura
    jq -r --arg nom "$nombre_lc" '
        to_entries[] |
        select(.value | any(. as $p | $nom | contains($p | ascii_downcase))) |
        .key
    ' "$PATRONES" | head -n 1
}

# Función: aprender patrón nuevo
aprender_patron() {
    local archivo="$1"
    local nombre="${archivo:l}"

    # Extraer palabras reemplazando _ y - por espacios
    local palabras="${nombre//[_\-]/ }"

    # Elegir la palabra más larga (> 4 caracteres)
    local mejor=$(echo "$palabras" | tr ' ' '\n' | awk 'length>4' | head -n 1)

    if [[ -n "$mejor" ]]; then
        echo "🧠 Aprendido nuevo patrón: $mejor"
        jq --arg palabra "$mejor" '.["Miscelánea"] += [$palabra]' "$PATRONES" > "$PATRONES.tmp"
        mv "$PATRONES.tmp" "$PATRONES"
    fi
}

# Crear lista de archivos .md
archivos=("$BASE"/*.md)

# En Zsh, los arreglos vacíos devuelven tamaño 0 con $#archivos
if (( $#archivos == 0 )); then
    echo "ℹ️ No hay archivos .md sueltos para clasificar."
else
    for archivo in $archivos; do
        [[ -f "$archivo" ]] || continue

        nombre="${archivo:t}" # Equivalente nativo en Zsh a $(basename "$archivo")

        categoria=$(detectar_categoria "$nombre")
        
        if [[ -z "$categoria" ]]; then
            categoria="Miscelánea"
        fi

        destino="$BASE/$categoria"
        mkdir -p "$destino"

        if [[ "$archivo" != "$destino/$nombre" ]]; then
            mv "$archivo" "$destino/"
            echo "✔️ Movido: $nombre → $categoria"
        fi

        if [[ "$categoria" == "Miscelánea" ]]; then
            aprender_patron "$nombre"
        fi
    done
fi

echo "✨ ULTRA PRO completado."
